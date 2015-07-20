//
//  VanStyleKit.h
//  VAN Selector
//
//  Created by Marc Humet on 20/7/15.
//  Copyright (c) 2015 EQUUS LIFE SL. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface VanStyleKit : NSObject

// iOS Controls Customization Outlets
@property(strong, nonatomic) IBOutletCollection(NSObject) NSArray* fichaB5Targets;
@property(strong, nonatomic) IBOutletCollection(NSObject) NSArray* fichaA4Targets;

// Colors
+ (UIColor*)lletraEquus;
+ (UIColor*)vermellEquus;
+ (UIColor*)blancCavall;
+ (UIColor*)negre;
+ (UIColor*)oKCalculation;

// Drawing Methods
+ (void)drawLogoEquusHoritzontalWithFrame: (CGRect)frame;
+ (void)drawLogoEquusVerticalWithFrame: (CGRect)frame;
+ (void)drawLogoChevalWithFrame: (CGRect)frame;
+ (void)drawCarNavIconWithStrokeColorParameter: (UIColor*)strokeColorParameter;
+ (void)drawTrailerWithColorParameter: (UIColor*)colorParameter scale: (CGFloat)scale alpha: (CGFloat)alpha;
+ (void)drawHorseWithFrame: (CGRect)frame;
+ (void)drawEquusHorseWithColorParameter: (UIColor*)colorParameter scale: (CGFloat)scale;
+ (void)drawLicenceIconWithColorParameter: (UIColor*)colorParameter scale: (CGFloat)scale;
+ (void)drawIconoLicenceSoloWithFrame: (CGRect)frame colorParameter: (UIColor*)colorParameter;
+ (void)drawMap;
+ (void)drawCalculationResults1WithFrame: (CGRect)frame mmaVan: (NSString*)mmaVan mmaCar: (NSString*)mmaCar numHorses: (NSString*)numHorses licence: (NSString*)licence sumaMMAs: (NSString*)sumaMMAs;
+ (void)drawEquusHorseNavBar;
+ (void)drawTrailerMaxPtac;
+ (void)drawLicenceNavIcon;
+ (void)drawCarWithScale: (CGFloat)scale strokeWidth: (CGFloat)strokeWidth;
+ (void)drawCalculationResults2WithFrame: (CGRect)frame mmaVan: (NSString*)mmaVan numHorses: (NSString*)numHorses weightHorse: (NSString*)weightHorse weightHorses: (NSString*)weightHorses weightTrailer: (NSString*)weightTrailer weightTrailerAndHorses: (NSString*)weightTrailerAndHorses;
+ (void)drawIconoLicenceSolo2;
+ (void)drawHelpIconWithButtonText: (NSString*)buttonText;
+ (void)drawBotonEquusWithButtonText: (NSString*)buttonText pressed: (BOOL)pressed;
+ (void)drawLicencesHelpWithFrame: (CGRect)frame;
+ (void)drawCarAndTrailerSymbol;
+ (void)drawAuricular6;
+ (void)drawCallButton;
+ (void)drawMailButton;
+ (void)drawVisibility1;
+ (void)drawMoreInfoButton;
+ (void)drawLogoDistribuidores;
+ (void)drawLogoChevalColorEquusWithButtonPressed: (CGFloat)buttonPressed;
+ (void)drawLogoDistribuidores2;
+ (void)drawTrailerShadowWithScale: (CGFloat)scale alpha: (CGFloat)alpha;
+ (void)drawCarShadowWithScale: (CGFloat)scale;
+ (void)drawLicenceShadowWithScale: (CGFloat)scale;
+ (void)drawEquusShadowWithScale: (CGFloat)scale;
+ (void)drawTrailerMaxPtac2;
+ (void)drawTrailer2WithScale: (CGFloat)scale alpha: (CGFloat)alpha;
+ (void)drawCarStrokeWithColorParameter: (UIColor*)colorParameter scale: (CGFloat)scale;
+ (void)drawCarEditableWithFrame: (CGRect)frame colorParameter: (UIColor*)colorParameter strokeColorParameter: (UIColor*)strokeColorParameter strokeWidth: (CGFloat)strokeWidth;
+ (void)drawTrailerMaxPtac3WithFrame: (CGRect)frame;
+ (void)drawCarPeopleLuggageWithFrame: (CGRect)frame;
+ (void)drawPeopleIcon;
+ (void)drawLuggage;
+ (void)drawLicenceMenuButtonWithFrame: (CGRect)frame;
+ (void)drawCatalogMenuButtonWithFrame: (CGRect)frame;
+ (void)drawMapMenuButtonWithFrame: (CGRect)frame;
+ (void)drawFichaB5;
+ (void)drawFichaA4;
+ (void)drawGaugeWithStrokeColorParameter: (UIColor*)strokeColorParameter pressure: (CGFloat)pressure maxWeight: (NSString*)maxWeight passOrFail: (NSString*)passOrFail;
+ (void)drawNumHorsesTableViewWithNumHorses: (NSString*)numHorses;
+ (void)drawPriceLabelWithButtonText: (NSString*)buttonText;
+ (void)drawSueloaluminioWithVisible: (BOOL)visible;
+ (void)drawSuspensionLogo;
+ (void)drawSuspensionPullmanWithVisibleSuspension: (BOOL)visibleSuspension;
+ (void)drawVisto;
+ (void)drawDiagramasCaballosEnVanCopy;
+ (void)drawOneAndHalf;
+ (void)drawThreePlaces;
+ (void)drawFourHorse;
+ (void)drawCanvas1;
+ (void)drawAppIcon;

// Generated Images
+ (UIImage*)imageOfHelpIconWithButtonText: (NSString*)buttonText;
+ (UIImage*)imageOfFichaB5;
+ (UIImage*)imageOfFichaA4;

@end



@interface UIColor (PaintCodeAdditions)

- (UIColor*)blendedColorWithFraction: (CGFloat)fraction ofColor: (UIColor*)color;

@end
