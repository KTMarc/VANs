//
//  EQLGarageModel.m
//  VANs
//
//  Created by Marc Humet on 01/08/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLGarageModel.h"

@interface EQLGarageModel()

@property (strong, nonatomic) NSMutableArray *oneHorseVans;
@property (strong, nonatomic) NSMutableArray *twoHorseVans;
@property (strong, nonatomic) NSMutableArray *threeHorseVans;
@property (strong, nonatomic) NSMutableArray *fourHorseVans;

@end

@implementation EQLGarageModel

#pragma mark - Properties

- (NSUInteger)oneHorseCount
{
    return [self.oneHorseVans count];
}

- (NSUInteger)twoHorseCount
{
    return [self.twoHorseVans count];
}

- (NSUInteger)threeHorseCount
{
    return [self.threeHorseVans count];
}

- (NSUInteger)fourHorseCount
{
    return [self.fourHorseVans count];
}


#pragma mark - Init
//-(id)init{
//    
//    if (self = [super init]) {
//       
//    }
//    return self;
//}

+ (NSArray *) allVans{
   
    //Nos construye el array con todos los modelos
    //NSMutableArray *allVans = [@[] mutableCopy];
    
    NSArray *ptacsOne1Horse = @[@900,@1000,@1100,@1200,@1300,@1400];
    NSArray *ptacsOne2Horse = @[@1100,@1200,@1300,@1400,@1500,@1600,@1700,@1800,@1900,@2000];
    NSArray *ptacsOne2HorseBig = @[@1100,@1200,@1300,@1400,@1500,@1600,@1700,@1800,@1900,@2000,@2100,@2200,@2300,@2400,@2500,@2600];
    NSArray *ptacsOne3Horse = @[@1700,@1800,@1900,@2000,@2100,@2200,@2300,@2400,@2500,@2600,@2700,@2800,@2900,@3000];
    NSArray *ptacsOne4Horse = @[@2800,@2900,@3000,@3100,@3200,@3300,@3400,@3500];
    
    //Llenamos el modelo
    
    EQLmodeloVan *gt1 = [[EQLmodeloVan alloc]
                         initWithName:@"GT1"
                         photoURL: [NSURL URLWithString: @"gt1.jpeg"]
                         webURL:[NSURL URLWithString:@"http://www.equus-life.com/remolques/van-gt1-black"]
                         specs:@"Equipamiento basico:Barras traseras ajustables en dos posiciones 2 ventanas frontales con reja de protección Goma en la rampa y en el interior del VAN.Equipamiento opcional incluido:Cojines laterales"
                         horsesNum:1
                         price:@"3.633€"
                         ptacs:ptacsOne1Horse
                         weight:600];
    
    EQLmodeloVan *gt2 = [[EQLmodeloVan alloc]
                         initWithName:@"GT2"
                         photoURL: [NSURL URLWithString: @"gt2.jpeg"]
                         webURL:[NSURL URLWithString:@"http://www.equus-life.com/remolques/van-gt2-black"]
                         specs:@"Equipamiento basico:Barras traseras ajustables en dos posiciones 2 ventanas frontales con reja de protección Goma en la rampa y en el interior del VAN.Equipamiento opcional incluido:Cojines laterales"
                         horsesNum:2
                         price:@"3.931€"
                         ptacs:ptacsOne2Horse
                         weight:720];
    
    EQLmodeloVan *gold2 = [[EQLmodeloVan alloc]
                           initWithName:@"Gold 2"
                           photoURL: [NSURL URLWithString: @"gold2.jpeg"]
                           webURL:[NSURL URLWithString:@"http://www.equus-life.com/remolques/van-gold-2-guadarnes"]
                           specs:@"Equipamiento basico:Barras traseras ajustables en dos posiciones 2 ventanas frontales con reja de protección Goma en la rampa y en el interior del VAN.Equipamiento opcional incluido:Cojines laterales"
                           horsesNum:2
                           price:@"5.736€"
                           ptacs:ptacsOne2Horse
                           weight:850];
    
    EQLmodeloVan *goldxl = [[EQLmodeloVan alloc]
                            initWithName:@"Gold XL"
                            photoURL: [NSURL URLWithString: @"gold2.jpeg"]
                            webURL:[NSURL URLWithString:@"http://www.equus-life.com/remolques/van-gold-2-guadarnes"]
                            specs:@"Equipamiento basico:Barras traseras ajustables en dos posiciones 2 ventanas frontales con reja de protección Goma en la rampa y en el interior del VAN.Equipamiento opcional incluido:Cojines laterales"
                            horsesNum:2
                            price:@"8.150€"
                            ptacs:ptacsOne2HorseBig
                            weight:900];
    
    EQLmodeloVan *minimax = [[EQLmodeloVan alloc]
                             initWithName:@"Minimax"
                             photoURL: [NSURL URLWithString: @"minimax.jpeg"]
                             webURL:[NSURL URLWithString:@"http://www.equus-life.com/remolques/van-gold-2-guadarnes"]
                             specs:@"Equipamiento basico:Barras traseras ajustables en dos posiciones 2 ventanas frontales con reja de protección Goma en la rampa y en el interior del VAN.Equipamiento opcional incluido:Cojines laterales"
                             horsesNum:3
                             price:@"10.000€"
                             ptacs:ptacsOne3Horse
                             weight:1250];
    
    EQLmodeloVan *optimax = [[EQLmodeloVan alloc]
                             initWithName:@"Optimax"
                             photoURL: [NSURL URLWithString: @"optimax.jpeg"]
                             webURL:[NSURL URLWithString:@"http://www.equus-life.com/remolques/van-gold-2-guadarnes"]
                             specs:@"Equipamiento basico:Barras traseras ajustables en dos posiciones 2 ventanas frontales con reja de protección Goma en la rampa y en el interior del VAN.Equipamiento opcional incluido:Cojines laterales"
                             horsesNum:4
                             price:@"11.900€"
                             ptacs:ptacsOne4Horse
                             weight:1450];
    
        NSArray *allVans = @[gt1,gt2,gold2,goldxl,minimax,optimax];
    return allVans;
}

#pragma mark - Other

- (EQLmodeloVan *)oneHorseAtIndex:(NSUInteger)index
{
    return [self.oneHorseVans objectAtIndex:index];
}

- (EQLmodeloVan *)twoHorseAtIndex:(NSUInteger)index
{
    return [self.twoHorseVans objectAtIndex:index];
}

- (EQLmodeloVan *)threeHorseAtIndex:(NSUInteger)index
{
    return [self.threeHorseVans objectAtIndex:index];
}

- (EQLmodeloVan *)fourHorseAtIndex:(NSUInteger)index
{
    return [self.fourHorseVans objectAtIndex:index];
}

@end
