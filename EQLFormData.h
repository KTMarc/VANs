//
//  EQLFormData.h
//  VAN Selector
//
//  Created by Marc Humet on 3/10/14.
//  Copyright (c) 2014 EQUUS-LIFE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EQLGarageModel.h"

@class EQLGarageModel;
@interface EQLFormData : NSObject

//No se la diferencia entre retain, readwrite
@property (nonatomic, readwrite) NSInteger mmaCar;
@property (nonatomic, readwrite) NSInteger mmrCar;
@property (nonatomic, readwrite) NSInteger pesoCaballo;
@property (nonatomic, readwrite) NSInteger licence;

//Todo esto es solo para tenerlo disponible en EQLCalculationsCondition
@property (nonatomic, strong) NSString* mmaVanString;
@property (nonatomic, strong) NSString* licenceString;
@property (nonatomic, strong) NSString* numHorsesString;


+ (id) sharedForm;

- (NSArray *) calculateThingsWithModel: (EQLGarageModel *) model;


@end
