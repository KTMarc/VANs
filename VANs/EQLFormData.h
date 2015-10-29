//
//  EQLFormData.h
//  VAN Selector
//
//  Created by Marc Humet on 3/10/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EQLGarageModel;
@interface EQLFormData : NSObject

//No se la diferencia entre retain, readwrite
@property (nonatomic, readwrite) NSInteger mmaCar;
@property (nonatomic, readwrite) NSInteger mmrCar;
@property (nonatomic, readwrite) NSInteger pesoCaballo;
@property (nonatomic, readwrite) NSInteger licence;
@property (nonatomic, readwrite) NSInteger firstTimeLoad;

//Those variables are here for convinience and to have them somewhere globally.
@property (nonatomic, readwrite) NSInteger trailerWeight;
@property (nonatomic, readwrite) NSInteger numHorses;
@property (nonatomic, readwrite) NSInteger mmaVan;

//Todo esto se genera al calcular la tableview de resultados de vans y solo se hace para tenerlo disponible en EQLCalculationsCondition
@property (nonatomic, strong) NSString* mmaVanString;
@property (nonatomic, strong) NSString* licenceString;
@property (nonatomic, strong) NSString* numHorsesString;

//Navigation track: Para saber desde que boton nos han hecho click y hacer una pequeña animación para que el usuario sepa de donde viene.
@property (strong, nonatomic) UIView* lastButtonPressed;


+ (id) sharedForm;

- (NSArray *) calculateThingsWithModel: (EQLGarageModel *) model andForm: (EQLFormData *)form;


@end
