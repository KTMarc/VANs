//
//  VanStyleKit.h
//  VAN Selector
//
//  Created by Marc Humet on 16/10/14.
//  Copyright (c) 2014 EQUUS LIFE SL. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface VanStyleKit : NSObject

// Colors
+ (UIColor*)lletraEquus;
+ (UIColor*)vermellEquus;
+ (UIColor*)blancCavall;
+ (UIColor*)negre;

// Drawing Methods
+ (void)drawLogoEquusHoritzontalWithFrame: (CGRect)frame;
+ (void)drawLogoEquusVerticalWithFrame: (CGRect)frame;
+ (void)drawLogoChevalWithFrame: (CGRect)frame;
+ (void)drawCarWithFrame: (CGRect)frame;
+ (void)drawTrailerWithFrame: (CGRect)frame;
+ (void)drawHorseWithFrame: (CGRect)frame;
+ (void)drawEquusHorseWithFrame: (CGRect)frame;
+ (void)drawLicenceIconWithFrame: (CGRect)frame;
+ (void)drawLicenceMenuIcon;
+ (void)drawMap;
+ (void)drawCalculationResults1WithMmaVan: (NSString*)mmaVan mmaCar: (NSString*)mmaCar numHorses: (NSString*)numHorses licence: (NSString*)licence;
+ (void)drawFichaB5;
+ (void)drawFichaA4;
+ (void)drawMenuBackgroundWithFrame: (CGRect)frame;
+ (void)drawCanvas1;

@end
