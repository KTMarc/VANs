//
//  EQLViewController.m
//  VANs
//
//  Created by Marc Humet on 24/07/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLLicenceFormViewController.h"
#import "EQLmodeloVan.h"

@interface EQLLicenceFormViewController ()

@end

#define CARNE_B     3500;
#define CARNE_B96   4250;
#define CARNE_ByE   7000;

@implementation EQLLicenceFormViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Esto es para que desaparezca el teclado numerico cada vez que piquemos fuera de él
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [tapRecognizer setDelegate:self];
    [tapRecognizer setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapRecognizer];
    
    //self.navigationController.navigationBar.translucent = YES;
	// Do any additional setup after loading the view, typically from a nib.
    //_result.hidden = true;
    //_availableWeights = [[NSArray alloc] init];

    //self.vansArray = @[gt1,gt2,gold2,goldxl,minimax,optimax];
    // NSLog (@"Modelo: %@", [self.vansArray[0] Name]);
    // NSLog (@"PTACS: %@", [[self.vansArray[0] ptacs] objectAtIndex:0]); //Puta mierda de Objective C
    //NSLog (@"PTACS: %@", self.vansArray[0].ptacs[0]);

    /*
     if (maximumPTAC < _horseWeight.text.intValue){
     NSLog(@"No puede llevar ningun remolque con su carné, le queda un peso para cargar caballos de solamente %i y su(s) caballo(s) pesan %i", maximumPTAC, _horseWeight.text.intValue );
     }
     */
    [self.view endEditing:YES];
    // _result.hidden = false;

}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)technicalSheetButton:(UIButton *)sender {

}

- (IBAction)calculateWeight:(UIButton *)sender {

    NSArray *licences = @[@3500, @4250, @7000];
    
    
    int ptacCar = _ptacCarTextField.text.intValue;
    int mmrCar = _mmrCarTextField.text.intValue;
    int pesoCaballo = self.horseWeight.text.intValue;
    
    int maximumPTAC = 0;
//    int pesoCaballo = 450;
    int pesoTotalCaballos = 0;
    int pesoDisponible= 0;
    int aux = -1;
    BOOL logs = true;
    int ptacActual = 0;
    NSString *lastObjectId =@"";
    NSString *textoExplicativo=@"";
    PFObject *lastAdded;
    EQLmodeloVan *modeloVan;

    
    self.resultsArray = @[[[NSMutableArray alloc]init], [[NSMutableArray alloc]init], [[NSMutableArray alloc]init],[[NSMutableArray alloc]init]];
    
    //NSMutableArray *auxArray = [[NSMutableArray alloc]init];
    //NSLog (@"Licencia: %@", licences[0]);
    
    switch (self.licenceSegmentedControl.selectedSegmentIndex){
        case 0:
            aux=CARNE_B;
            break;
        case 1:
            aux=CARNE_B96;
            break;
        case 2:
            aux=CARNE_ByE;
            break;
        default:
            break;
            
    }
    
    for (NSNumber *each in licences){ //Iteramos en numeros enteros
        //Accedemos a objetos
        maximumPTAC = each.intValue - ptacCar;
        if (each.intValue == aux){ //Solo haremos todo en el carne que tengamos seleccionado
            if (logs) {NSLog(@"Entramos en el carne de %i Kg" ,aux);}
            if (logs) {NSLog(@"Peso Maximo: %@ - %i = %i",each, ptacCar, maximumPTAC);NSLog(@"-----------------CARNE %@---------------",each);}
            
            for (id van in _allVans){ //Iteramos en objetos tipo PFObject en el array donde estan todos los vans
                if (logs) {NSLog(@"Estamos en la posición del array: %lu", (unsigned long)[_allVans indexOfObject:van]);}
                //Aquesta merda comença amb index 1, no 0 .
                if (logs) { NSLog(@"\n\n--------------------------------------VAN %@---------------------------------------",van[@"Name"]);}
                
                for (NSNumber *ptacAct in van[@"ptacs"]){ //Aqui ja estem en el punt on volem, no cal dir [[_vansArray objectAtIndex: van] ptacs]. Iteramos en numeros enteros
                    ptacActual = ptacAct.intValue;
                    if (logs) { NSLog(@"\n---------------------------------------------------------------------MMA %@----------",ptacAct);
                    }
                    
                    //Si el coche permite arrastrar este PTAC y que la ptac del van que estamos mirando no es superior a la MMA del coche
                    if ((mmrCar >= ptacActual) && (ptacCar >= ptacActual)){
                        //Si el peso Maximo disponible es mayor al peso actual que estamos comprovando
                        if (maximumPTAC > [ptacAct integerValue]) {
                            pesoTotalCaballos = pesoCaballo * [van[@"horsesNum"] intValue];
                            pesoDisponible = ptacActual - [van[@"weight"]intValue];
                            
                            if ( pesoTotalCaballos <= pesoDisponible) {
                                
                                if (logs) {NSLog(@"PUEDE LLEVAR con el carné de %@  el van %@ con la MMA %@\n",each,van[@"Name"],ptacAct);
                                    NSLog(@"El peso total de el/los caballo(s) si cada pesa(n) %i es %i y el peso disponible es: %i", pesoCaballo,pesoTotalCaballos,pesoDisponible);}
                                
                                textoExplicativo = [NSString stringWithFormat:@"Maxima carga que tenemos por carné:%i \nMMA a la que tenemos que poner el VAN:%@\n%@(MMA VAN) - %i  (CABALLO(S)) -%i(TARA)= %i Kg(que sobran)",maximumPTAC,ptacAct,ptacAct,pesoTotalCaballos,[van[@"weight"]intValue],(ptacActual - pesoTotalCaballos - [van[@"weight"]intValue])];
                                
                                //Añadimos van al array que toque segun en el numero de caballos que estemos
                                if ([van objectId] != lastObjectId) { //Si esta van no lo habiamos añadido ya, lo añadimos ahora
                                    if (logs) {NSLog(@"Añadimos un van nuevo %@ y el ultimo van guardado es: %@\n",van[@"Name"],lastAdded[@"Name"]);}
                                    
                                    //Creamos un EQLmodeloVan donde guardamos el PFObject y la informacion relativa al PTAC maximo y la explicación en texto.
                                    modeloVan = [EQLmodeloVan modeloVanWithPFVan:van calculationText:textoExplicativo maxPtacForClientsCar:ptacActual];
                                    //Añadimos el objecto modeloVan que encapsula el PFObject que viene de Parse sin tocar con la info de PTAC maximo y la explicación de los calculos
                                    [self.resultsArray[[van[@"horsesNum"] intValue]-1] addObject:modeloVan];
                                }
                                //Sobreescribimos el peso maximo (Posicion 0 del array --> 1 caballo, posicion 1 -> 2 caballos, pos 2--> 3 cab., pos3 -->4 cab)
                                modeloVan = [self.resultsArray[[van[@"horsesNum"] intValue]-1] lastObject];
                                modeloVan.maxPtacForClientsCar =ptacAct.intValue;
                                modeloVan.calculationText = textoExplicativo;
                                
                                //[NSNumber numberWithLong:ptacAct.integerValue];
                                //auxArray[0] = [self.resultsArray[[van horsesNum]] lastObject];
                                //[auxArray[0] setMaxPtacForClientsCar:[ptacAct integerValue]];
                                lastObjectId = [van objectId];
                            }
                            
                        }else{
                            if (logs) {
                                NSLog(@"NO PUEDES llevar %@ caballo(s) de %i Kg con el carné de %@ en el van %@",van[@"horsesNum"],pesoCaballo,each,van[@"Name"]);
                                if ((maximumPTAC < [ptacAct integerValue])){
                                    NSLog(@"La MMA disponible con tu carne es %i, que es MENOR que la MMA que estamos evaluando %i", maximumPTAC, ptacActual);
                                } else if ((pesoTotalCaballos > ptacActual - [van[@"weight"]intValue])){
                                    NSLog(@"El peso total de los caballos es %i y el peso disponible para carga es solo %i", pesoTotalCaballos,ptacActual - [van[@"weight"]intValue]);
                                }
                               
                            }
                        }
                    } else {
                        if (ptacCar < ptacActual){   NSLog(@"ERROR: La MMA que estamos mirando es superior a la MMA del coche");}
                        
                        if (mmrCar < ptacActual){    NSLog(@"ERROR: La MMA que estamos mirando es INFERIOR a la MMR MAXIMA del coche");}
                    }
                } //Fin for PTACS
            } //Fin for Array todos los VANs
        } //Carné en el que estamos
    } //Fin for licences

}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass:[UIButton class]]){
        if ([segue.destinationViewController isKindOfClass:[EQLCarResultsTableViewController class]]){
            EQLCarResultsTableViewController *nextViewController = segue.destinationViewController;
            nextViewController.resultsArray = self.resultsArray;
        }
    }
    
}



@end
