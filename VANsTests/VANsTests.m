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
EQLmodeloVan *van;
EQLFormData *formData;

@implementation VANsTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
   
    //https://www.bignerdranch.com/blog/asynchronous-testing-with-xcode-6/
    XCTestExpectation *expectation =
    [self expectationWithDescription:@"High Expectations"];
    
    
    formData = [[EQLFormData alloc] init];
    formData.mmaCar = 2350;
    formData.mmrCar = 1900;
    formData.pesoCaballo = 450;
    formData.licence = 0;
    
    //Generar un EQLGarageModel a mano es la currada de la vida. He refactorizado codigo de otro sitio para poder hacer esto.
    
    garage = [[EQLGarageModel alloc]init];

    garage.testBlock = ^void(){
     //   XCTAssert((unsigned long)objects.count > 0);
        [expectation fulfill];
    };
    
    
  
    garage.oneHorseVans = [[NSMutableArray alloc]init];
    garage.twoHorseVans = [[NSMutableArray alloc]init];
    garage.threeHorseVans = [[NSMutableArray alloc]init];
    garage.fourHorseVans = [[NSMutableArray alloc]init];
    
    PFQuery *queryVans = [PFQuery queryWithClassName:@"modeloVan"];
    [queryVans orderByAscending:@"Priority"];
    [queryVans whereKey:@"enabled" equalTo:@(YES)];
    queryVans.cachePolicy = kPFCachePolicyCacheThenNetwork;
    
    [queryVans findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error){
            NSLog(@"Successfully retrieved %lu vans.", (unsigned long)objects.count);
            XCTAssert((unsigned long)objects.count > 0);
            [expectation fulfill];
            
            garage.allVans = [objects mutableCopy];
            for (id van in    garage.allVans){
                // NSLog(@"Entra al for");
                PFObject *parseVan = van;
                int numHorsesInPFObject = [[parseVan objectForKey:@"horsesNum"] intValue];
                
                //  switch ([van horsesNum]) {
                switch (numHorsesInPFObject) {
                    case 1:
                        [garage.oneHorseVans addObject:van];
                        break;
                    case 2:
                        [garage.twoHorseVans addObject:van];
                        break;
                    case 3:
                        [garage.threeHorseVans addObject:van];
                        break;
                    case 4:
                        [garage.fourHorseVans addObject:van];
                        break;
                    default:
                        garage.executionFlag = YES;
                        break;
                }
            }
                NSLog(@"Hay %lu Vans en el array", (unsigned long)[garage.allVans count]);
        } else {
            NSLog(@"Error en la descarga de Parse: %@ %@", error, [error userInfo]);
        }
    }];
    
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

- (void)testDescargaVans
{
    //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
    
    //Aqui lo que me gustaria es poder hacer que cargue todo el modelo normal de la aplicación (EQLGarageModel) y solo variar los valores que le hemos pasado por el formulario.
    
    
    // NSLog(@"Hay %lu Vans en el array", (unsigned long)[garage.allVans count]);
    XCTAssertEqual([garage.allVans count], (NSUInteger) 6, @"No se han descargado 6 vans." );
    
   // XCTAssertNotNil([formData calculateThingsWithModel:(EQLGarageModel *)garage andForm:(EQLFormData *) formData]);
    
}

- (void) testCalculosResultados
{
    
    
    
}

@end
