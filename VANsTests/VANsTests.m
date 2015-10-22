//
//  VANsTests.m
//  VANsTests
//
//  Created by Marc Humet on 24/07/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "EQLGarageModel.h"
#import "EQLAppDelegate.h"
#import "EQLFormData.h"


@interface VANsTests : XCTestCase

@end

EQLGarageModel *garage;
EQLFormData *formData;
NSArray *resultsArray;
BOOL testing;
BOOL testing = true;

@implementation VANsTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    //Generar un EQLGarageModel a mano es la currada de la vida. He refactorizado codigo de otro sitio para poder hacer esto.
    
     formData = [[EQLFormData alloc] init];
    
    //https://www.bignerdranch.com/blog/asynchronous-testing-with-xcode-6/
    XCTestExpectation *expectation =
    [self expectationWithDescription:@"High Expectations"];
    
    garage = [[EQLGarageModel alloc]init];
    
    //Aqui he entes els bloques!! Li pasem un Array de objectes que encara no tenim pero que tindrem en el futur. I el codi de test que nomes pot estar dintre de la clase de testing.
    
    garage.testBlock = ^void(NSArray *objects){
        XCTAssert((unsigned long)objects.count > 0);
        [expectation fulfill];
    };
    
    //Nomes utilitzem un flag a la funcio que cridem per saber que hem de executar mes codi a dins amb el bloc
    [garage doAsyncQueryToParse: true];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}


- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDescargaTodosLosVans
{
    //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
    
    //Aqui lo que me gustaria es poder hacer que cargue todo el modelo normal de la aplicación (EQLGarageModel) y solo variar los valores que le hemos pasado por el formulario.
    
    XCTAssertEqual([garage.allVans count], (NSUInteger) 7, @"No se han descargado 7 vans." );
    
}

- (void) test_StdCar_StdHorse_LicB
{
    formData.mmaCar = 2350;
    formData.mmrCar = 1900;
    formData.pesoCaballo = 450;
    formData.licence = 0;
    
    resultsArray = [formData calculateThingsWithModel:(EQLGarageModel *)garage andForm:(EQLFormData *) formData];
    XCTAssertEqual([resultsArray[0] count], (NSUInteger) 2, @"Debería haber 2 vans de 1 caballo" );
    NSLog(@"ResultsArray1 %@",resultsArray[1]);
    XCTAssertEqual([resultsArray[1] count], (NSUInteger) 0,  @"No debería haber nada");
    
    
}

- (void) test_StdCar_StdHorse_LicB96
{

    formData.mmaCar = 2350;
    formData.mmrCar = 1900;
    formData.pesoCaballo = 450;
    formData.licence = 1;
    
    resultsArray = [formData calculateThingsWithModel:(EQLGarageModel *)garage andForm:(EQLFormData *) formData];
    XCTAssertEqual([resultsArray[0] count], (NSUInteger) 2, @"Debería haber 2 vans de 1 caballo" );
    XCTAssertEqual([resultsArray[1] count], (NSUInteger) 1, @"Debería haber 1 van de 2 caballos" );

}


//- (void) test_BigCar_StdHorse_LicE
//{
//    
//    formData.mmaCar = 3500;
//    formData.mmrCar = 3500;
//    formData.pesoCaballo = 450;
//    formData.licence = 2;
//    
//    resultsArray = [formData calculateThingsWithModel:(EQLGarageModel *)garage andForm:(EQLFormData *) formData];
//    XCTAssertEqual([resultsArray[0] count], (NSUInteger) 2, @"Debería haber 2 vans de 1 caballo" );
//   // XCTAssertEqual([resultsArray[1] count], (NSUInteger) 2, @"Debería haber 1 van de 2 caballos" );
//    
//    //XCTAssertEqual([resultsArray[2] count], (NSUInteger) 1, @"Debería haber 1 van de 3 caballos" );
//    //XCTAssertEqual([resultsArray[3] count], (NSUInteger) 1, @"Debería haber 1 van de 4 caballos" );
//
//     }

@end
