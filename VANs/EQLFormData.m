//
//  EQLFormData.m
//  VAN Selector
//
//  Created by Marc Humet on 3/10/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
// This singleton is used to encapsulate the form data that the user enters and is used across all view controllers.

#import "EQLFormData.h"
#import "EQLGarageModel.h"
#import "EQLmodeloVan.h"

#define CARNE_B     3500;
#define CARNE_B96   4250;
#define CARNE_ByE   7000;

@implementation EQLFormData

@synthesize mmaCar;
@synthesize mmrCar;
@synthesize licence;
@synthesize pesoCaballo;

#pragma mark Singleton Methods

//As seen in "Effective Objective C (Matt Galloway) - item 45 (making the singleton thread safe)
+(id) sharedForm{
    static EQLFormData *sharedForm = nil;
    @synchronized(self) {
        if (!sharedForm)
            sharedForm = [[self alloc] init];
    }
    return sharedForm;
}

- (id)init {
    if (self = [super init]) {
        /*
        mmaCar = 0;
        mmrCar = 0;
        licence = 0;
        pesoCaballo = 0;
         */
    
    }
    return self;
}

//Effective Objective C book: Item 17 Implement the description method
//- (NSString*) description{
//    return [NSString stringWithFormat:@"%ld %ld %ld %ld", (long)mmaCar,(long) _mmrCar, (long)licence, (long)pesoCaballo];
//}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

#pragma mark Utilities

- (NSArray *) calculateThingsWithModel:(EQLGarageModel *) model andForm:(EQLFormData *)form{
    //NSLog(@"Te habla en singleton");
    NSArray *resultsArray = @[[[NSMutableArray alloc]init], [[NSMutableArray alloc]init], [[NSMutableArray alloc]init],[[NSMutableArray alloc]init]];
//    NSArray *licences = @[@3500, @4250, @7000];
    
    int maximumPTAC = 0;
    //   int _pesoCaballo = 450;
    int pesoTotalCaballos = 0;
    int pesoDisponible= 0;
    int licenceWeight = -1;
    BOOL logs = false;
    BOOL canHavePtacBetweenBoundaries = true;
    int currentPTAC = 0;
    //BOOL notBrochureWeights = NO;
    NSString *lastObjectId =@"";
    NSString *textoExplicativo=@"";
    PFObject *lastAdded;
    EQLmodeloVan *modeloVan;
    NSMutableArray *failReasons = [[NSMutableArray alloc]init];
//    EQLFormData *sharedForm = [EQLFormData sharedForm];
    //Para poder hacer testing. Si es nil es que no estamos haciendo tests
    
    if (form != nil){ //Si estamos pasando algo que no es nil es que estamos haciendo testing de datos que metemos desde fuera
        mmaCar = form.mmaCar;
        mmrCar = form.mmrCar;
        licence = form.licence;
        pesoCaballo = form.pesoCaballo;
    }
    
    //There is a norm that says that cars weight (TARA) should bigger than the trailer PTAC. We assume that it will always be if the condition of MMR > Trailer PTAC is met
   // int tara = mmaCar * 0.75;
    
    //NSMutableArray *auxArray = [[NSMutableArray alloc]init];
    //NSLog (@"Licencia: %@", licences[0]);
    
    switch (licence){
        case 0:
            licenceWeight=CARNE_B;
            _licenceString = [NSString stringWithFormat: @"3.500Kg."];
            break;
        case 1:
            licenceWeight=CARNE_B96;
            _licenceString = [NSString stringWithFormat: @"4.250Kg."];
            break;
        case 2:
            licenceWeight=CARNE_ByE;
            _licenceString = [NSString stringWithFormat: @"7.000Kg."];
            break;
        default:
            break;
    }
    
   // for (int i=licence; i++ ; i=3){ //Iteramos en numeros enteros
        //Accedemos a objetos
        maximumPTAC = licenceWeight - (int)mmaCar; //In some countries like Spain, it´s possible to specify an exact weight.
        
        //  if (licenceWeight.intValue == licenceWeight){ //Solo haremos todo en el carne que tengamos seleccionado
        if (model != nil){
            if (logs) {NSLog(@"Se ha seleccionado el carne de %i Kg" ,licenceWeight);}
            if (logs) {NSLog(@"Peso Maximo: %d - %i = %i",licenceWeight, (int)mmaCar, maximumPTAC);NSLog(@"-----------------CARNE %d---------------",licenceWeight);}
            
            for (id van in model.allVans){ //Iteramos en objetos tipo PFObject en el array donde estan todos los vans
                if (logs) {NSLog(@"Estamos en la posición del array: %lu", (unsigned long)[model.allVans indexOfObject:van]);}
                //Aquesta merda comença amb index 1, no 0 .
                
                if (logs) { NSLog(@"\n\n--------------------------------------VAN %@---------------------------------------",van[@"Name"]);}
                
                if (canHavePtacBetweenBoundaries){
                    [van[@"ptacs"] addObject:[NSNumber numberWithInt:maximumPTAC]];
                }
                for (NSNumber *ptacAct in van[@"ptacs"]){ //Aqui ja estem en el punt on volem, no cal dir [[_vansArray objectAtIndex: van] ptacs]. Iteramos en numeros enteros
                    currentPTAC = ptacAct.intValue;
                    if (logs) { NSLog(@"\n---------------------------------------------------------------------MMA %@----------",ptacAct);
                    }
                    
                    //Si el coche permite arrastrar este PTAC y  la ptac del van que estamos mirando no es superior a la MMA del coche
                    if ((mmrCar >= currentPTAC) /*&& (tara >= currentPTAC)*/){
                        //Si el peso Maximo disponible es mayor al peso actual que estamos comprovando
                        
                        if (maximumPTAC >= currentPTAC) {
                            pesoTotalCaballos = (int)pesoCaballo * [van[@"horsesNum"] intValue];
                            pesoDisponible = currentPTAC - [van[@"weight"]intValue];
                            
                            if ( pesoTotalCaballos <= pesoDisponible) {
                                
                                if (logs) {NSLog(@"PUEDE LLEVAR con el carné de %d  el van %@ con la MMA %@\n",licenceWeight,van[@"Name"],ptacAct);
                                    NSLog(@"El peso total de el/los caballo(s) si cada pesa(n) %i es %i y el peso disponible es: %i",(int) pesoCaballo,pesoTotalCaballos,pesoDisponible);}
                                
                                textoExplicativo = [NSString stringWithFormat:@"Maxima carga que tenemos por carné:%i \nMMA a la que tenemos que poner el VAN:%@\n%@(MMA VAN) - %i  (CABALLO(S)) -%i(TARA)= %i Kg(que sobran)",maximumPTAC,ptacAct,ptacAct,pesoTotalCaballos,[van[@"weight"]intValue],(currentPTAC - pesoTotalCaballos - [van[@"weight"]intValue])];
                                
                                
                                //Añadimos van al array que toque segun en el numero de caballos que estemos
                                if ([van objectId] != lastObjectId) { //Si esta van no lo habiamos añadido ya, lo añadimos ahora
                                    if (logs) {NSLog(@"Añadimos un van nuevo %@ y el ultimo van guardado es: %@\n",van[@"Name"],lastAdded[@"Name"]);}
                                    
                                    //Creamos un EQLmodeloVan donde guardamos el PFObject y la informacion relativa al PTAC maximo y la explicación en texto.
                                    modeloVan = [EQLmodeloVan modeloVanWithPFVan:van calculationText:textoExplicativo maxPtacForClientsCar:currentPTAC];
                                    //Añadimos el objecto modeloVan que encapsula el PFObject que viene de Parse sin tocar con la info de PTAC maximo y la explicación de los calculos
                                    [resultsArray[[van[@"horsesNum"] intValue]-1] addObject:modeloVan];
                                }
                                //Sobreescribimos el peso maximo (Posicion 0 del array --> 1 caballo, posicion 1 -> 2 caballos, pos 2--> 3 cab., pos3 -->4 cab)
                                modeloVan = [resultsArray[[van[@"horsesNum"] intValue]-1] lastObject];
                                modeloVan.maxPtacForClientsCar =ptacAct.intValue;
                                modeloVan.calculationText = textoExplicativo;
                                
                                //[NSNumber numberWithLong:ptacAct.integerValue];
                                //auxArray[0] = [self.resultsArray[[van horsesNum]] lastObject];
                                //[auxArray[0] setMaxPtacForClientsCar:[ptacAct integerValue]];
                                lastObjectId = [van objectId];
                            }
                            
                        }else{ // ITERATING PTACs: The current PTAC we are checking is bigger thant the car´s MAX
                            if (logs) NSLog(@"NO PUEDES llevar %@ caballo(s) de %li Kg con el carné de %d en el van %@",van[@"horsesNum"],(long)pesoCaballo,licenceWeight,van[@"Name"]);
                            if ((maximumPTAC < [ptacAct integerValue])){
                                [failReasons addObject:[NSString stringWithFormat:@"ERROR: La MMA disponible con tu carne es %i, que es MENOR que la MMA que estamos evaluando %i", maximumPTAC, currentPTAC]];
                            } else if ((pesoTotalCaballos > (currentPTAC - [van[@"weight"]intValue]))){
                                [failReasons addObject:[NSString stringWithFormat:@"ERROR: El peso total de los caballos es %i y el peso disponible para carga es solo %i", pesoTotalCaballos,currentPTAC - [van[@"weight"]intValue]]];
                            }
                            
                            if (logs) NSLog(@"%@", [failReasons lastObject]);
                        }
                        
                    } else { // The VAN PTAC is lower than the MMA of the towing car OR... MMR is lower than te PTAC we are checking.
                        if (mmaCar < currentPTAC){
                            [failReasons addObject:[NSString stringWithFormat:@"ERROR: La MMA que estamos mirando es superior a la MMA del coche MMA coche: %li < MMA Van actual: %i",(long)mmaCar,currentPTAC]];
                        }
                        if (mmrCar < currentPTAC){
                            [failReasons addObject:[NSString stringWithFormat:@"ERROR: La MMA que estamos mirando es SUPERIOR a la MMR MAXIMA del coche. MMR: %li < MMM Van actual: %i",(long)mmrCar,currentPTAC]];
                        }
                        
                        if (logs) NSLog(@"%@", [failReasons lastObject]);
                    }
                    [failReasons removeAllObjects];
                } //Fin for PTACS
            } //Fin for Array todos los VANs
            //  } //Carné en el que estamos
            //  } //Fin for licences
        } else{
            if (logs){ NSLog(@"El modelo es nil cuando llega a Calculatethings");}
        }
   // } // End of licenses
    return  resultsArray;
}

@end
