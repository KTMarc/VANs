//
//  EQLViewController.m
//  VANs
//
//  Created by Marc Humet on 24/07/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import "EQLLicenceFormViewController.h"

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
    
    int maximumPTAC = 0;
    int pesoCaballo = self.horseWeight.text.intValue;
    int pesoTotalCaballos = 0;
    int pesoDisponible= 0;
    int aux = -1;
    BOOL logs = false;
    NSString *lastName =@"";
    
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
        maximumPTAC = each.intValue - _ptacCarTextField.text.intValue;
        if (each.intValue == aux){ //Solo haremos todo en el carne que tengamos seleccionado
            if (logs) {NSLog(@"Entramos en el carne de %i Kg" ,aux);}
            
            
            if (logs) {NSLog(@"Peso Maximo: %@ - %i = %i",each, _ptacCarTextField.text.intValue, maximumPTAC);NSLog(@"-----------------CARNE %@---------------",each);}
            
            
            for (id van in _vansArray){ //Iteramos en objetos
                if (logs) {NSLog(@"Estamos en el indice del array: %i", [van horsesNum]);}
                //Aquesta merda comença amb index 1, no 0 .
                
                if (logs) { NSLog(@"--------------VAN %@------------",[van Name]);}
                
                for (NSNumber *ptacAct in [van ptacs]){ //Aqui ja estem en el punt on volem, no cal dir [[_vansArray objectAtIndex: van] ptacs]. Iteramos en numeros enteros
                    if (logs) { //NSLog(@"------------MMA %@----------",ptacAct);
                    }
                    
                    if (maximumPTAC > [ptacAct integerValue]) {
                        pesoTotalCaballos = pesoCaballo * ([van horsesNum]-1);
                        pesoDisponible = ptacAct.intValue - [van weight];
                        
                        if ( pesoTotalCaballos <= pesoDisponible) {
                            
                            if (logs) {NSLog(@"Con el carné de %@ puedes llevar el van %@ con la MMA %@",each,[van Name],ptacAct);
                                NSLog(@"El peso total de los caballos si cada uno pesa %i es %i y el peso disponible es: %i", pesoCaballo,pesoTotalCaballos,pesoDisponible);}
                            
                            //Añadimos van al array que toque segun en el numero de caballos que estemos
                            
                            if ([van Name] != lastName.description) { //Si esta van no lo habiamos añadido ya, lo añadimos ahora
                                if (logs) {NSLog(@"Añadimos un van nuevo %@ y el ultimo van guardado es: %@",[van Name],lastName);}
                                [self.resultsArray[[van horsesNum]-1] addObject:van];
                                
                            }
                            //Sobreescribimos el peso maximo
                            [[self.resultsArray[[van horsesNum]-1] lastObject] setMaxPtacForClientsCar:[ptacAct intValue]];
                            
                            //auxArray[0] = [self.resultsArray[[van horsesNum]] lastObject];
                            //[auxArray[0] setMaxPtacForClientsCar:[ptacAct integerValue]];
                            lastName = [van Name];
                            
                        }
                        
                    }else{
                        if (logs) {
                            /*
                             if (logs) {NSLog(@"No puedes llevar %i caballo(s) de %i Kg con el carné de %@ en el van %@",[van horsesNum],pesoCaballo,each,[van Name]);
                             NSLog(@"El peso total de los caballos es %i y el peso disponible para carga es solo %i", pesoTotalCaballos,pesoDisponible);}
                             */
                        }
                    }
                }
                
            }
        }
    }

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
