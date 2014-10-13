//
//  EQLFormData.m
//  VAN Selector
//
//  Created by Marc Humet on 3/10/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLFormData.h"

#define CARNE_B     3500;
#define CARNE_B96   4250;
#define CARNE_ByE   7000;

@implementation EQLFormData

@synthesize mmaCar;
@synthesize mmrCar;
@synthesize licence;
@synthesize pesoCaballo;

#pragma mark Singleton Methods

+(id) sharedForm{
    static EQLFormData *sharedFormData = nil;
    @synchronized(self) {
        if (sharedFormData == nil)
            sharedFormData = [[self alloc] init];
    }
    return sharedFormData;
}

- (id)init {
    if (self = [super init]) {
        mmaCar = 0;
        mmrCar = 0;
        licence = 0;
        pesoCaballo = 0;
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

#pragma mark Utilities

- (NSArray *) calculateThingsWithModel:(EQLGarageModel *) model {
    //NSLog(@"Te habla en singleton");
    NSArray *resultsArray = @[[[NSMutableArray alloc]init], [[NSMutableArray alloc]init], [[NSMutableArray alloc]init],[[NSMutableArray alloc]init]];
//    NSArray *licences = @[@3500, @4250, @7000];
    

    int maximumPTAC = 0;
    //   int _pesoCaballo = 450;
    int pesoTotalCaballos = 0;
    int pesoDisponible= 0;
    int licenceWeight = -1;
    BOOL logs = false;
    int mmaVanActual = 0;
    NSString *lastObjectId =@"";
    NSString *textoExplicativo=@"";
    PFObject *lastAdded;
    EQLmodeloVan *modeloVan;
    
    //NSMutableArray *auxArray = [[NSMutableArray alloc]init];
    //NSLog (@"Licencia: %@", licences[0]);
    
    switch (licence){
        case 0:
            licenceWeight=CARNE_B;
            break;
        case 1:
            licenceWeight=CARNE_B96;
            break;
        case 2:
            licenceWeight=CARNE_ByE;
            break;
        default:
            break;
    }
    
  //  for (NSNumber *each in licences){ //Iteramos en numeros enteros
        //Accedemos a objetos
        maximumPTAC = licenceWeight - (int)mmaCar;
      //  if (licenceWeight.intValue == licenceWeight){ //Solo haremos todo en el carne que tengamos seleccionado
            if (logs) {NSLog(@"Se ha seleccionado el carne de %i Kg" ,licenceWeight);}
            if (logs) {NSLog(@"Peso Maximo: %d - %i = %i",licenceWeight, (int)mmaCar, maximumPTAC);NSLog(@"-----------------CARNE %d---------------",licenceWeight);}
            
            for (id van in model.allVans){ //Iteramos en objetos tipo PFObject en el array donde estan todos los vans
                if (logs) {NSLog(@"Estamos en la posición del array: %lu", (unsigned long)[model.allVans indexOfObject:van]);}
                //Aquesta merda comença amb index 1, no 0 .
                if (logs) { NSLog(@"\n\n--------------------------------------VAN %@---------------------------------------",van[@"Name"]);}
                
                for (NSNumber *ptacAct in van[@"ptacs"]){ //Aqui ja estem en el punt on volem, no cal dir [[_vansArray objectAtIndex: van] ptacs]. Iteramos en numeros enteros
                    mmaVanActual = ptacAct.intValue;
                    if (logs) { NSLog(@"\n---------------------------------------------------------------------MMA %@----------",ptacAct);
                    }
                    
                    //Si el coche permite arrastrar este PTAC y que la ptac del van que estamos mirando no es superior a la MMA del coche
                    if ((mmrCar >= mmaVanActual) && (mmaCar >= mmaVanActual)){
                        //Si el peso Maximo disponible es mayor al peso actual que estamos comprovando
                        if (maximumPTAC >= mmaVanActual) {
                            pesoTotalCaballos = (int)pesoCaballo * [van[@"horsesNum"] intValue];
                            pesoDisponible = mmaVanActual - [van[@"weight"]intValue];
                            
                            if ( pesoTotalCaballos <= pesoDisponible) {
                                
                                if (logs) {NSLog(@"PUEDE LLEVAR con el carné de %d  el van %@ con la MMA %@\n",licenceWeight,van[@"Name"],ptacAct);
                                    NSLog(@"El peso total de el/los caballo(s) si cada pesa(n) %i es %i y el peso disponible es: %i",(int) pesoCaballo,pesoTotalCaballos,pesoDisponible);}
                                
                                textoExplicativo = [NSString stringWithFormat:@"Maxima carga que tenemos por carné:%i \nMMA a la que tenemos que poner el VAN:%@\n%@(MMA VAN) - %i  (CABALLO(S)) -%i(TARA)= %i Kg(que sobran)",maximumPTAC,ptacAct,ptacAct,pesoTotalCaballos,[van[@"weight"]intValue],(mmaVanActual - pesoTotalCaballos - [van[@"weight"]intValue])];
                                
                                //Añadimos van al array que toque segun en el numero de caballos que estemos
                                if ([van objectId] != lastObjectId) { //Si esta van no lo habiamos añadido ya, lo añadimos ahora
                                    if (logs) {NSLog(@"Añadimos un van nuevo %@ y el ultimo van guardado es: %@\n",van[@"Name"],lastAdded[@"Name"]);}
                                    
                                    //Creamos un EQLmodeloVan donde guardamos el PFObject y la informacion relativa al PTAC maximo y la explicación en texto.
                                    modeloVan = [EQLmodeloVan modeloVanWithPFVan:van calculationText:textoExplicativo maxPtacForClientsCar:mmaVanActual];
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
                            
                        }else{
                            if (logs) {
                                NSLog(@"NO PUEDES llevar %@ caballo(s) de %li Kg con el carné de %d en el van %@",van[@"horsesNum"],(long)pesoCaballo,licenceWeight,van[@"Name"]);
                                if ((maximumPTAC < [ptacAct integerValue])){
                                    NSLog(@"La MMA disponible con tu carne es %i, que es MENOR que la MMA que estamos evaluando %i", maximumPTAC, mmaVanActual);
                                } else if ((pesoTotalCaballos > (mmaVanActual - [van[@"weight"]intValue]))){
                                    NSLog(@"El peso total de los caballos es %i y el peso disponible para carga es solo %i", pesoTotalCaballos,mmaVanActual - [van[@"weight"]intValue]);
                                }
                                
                            }
                        }
                    } else {
                        if (logs) {
                            if (mmaCar < mmaVanActual){   NSLog(@"ERROR: La MMA que estamos mirando es superior a la MMA del coche MMA coche: %i < MMA Van actual: %i",mmaCar,mmaVanActual);}
                            if (mmrCar < mmaVanActual){    NSLog(@"ERROR: La MMA que estamos mirando es SUPERIOR a la MMR MAXIMA del coche. MMR: %i < MMM Van actual: %i",mmrCar,mmaVanActual);}
                        }
                    }
                } //Fin for PTACS
            } //Fin for Array todos los VANs
      //  } //Carné en el que estamos
  //  } //Fin for licences
    
    return  resultsArray;
}




@end
