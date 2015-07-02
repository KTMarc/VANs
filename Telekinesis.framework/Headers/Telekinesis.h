//
//  Telekinesis.framework
//  Copyright © 2015 PixelCut. All rights reserved.
//
//  Compatible with PaintCode 2.4
//

#import <Foundation/Foundation.h>


/*! How to integrate:
 *  1. Add this framework to the project.
 *  2. Remove it from all targets.
 *  3. Add “-ObjC” and “-framework Telekinesis” to Other Linker Flags under Debug configuration.
 *  4. Framework will print a message after it’s launched.
 *
 *  Important: Never submit Telekinesis to the App Store. If you import this framework, wrap it in `#if DEBUG` scope.
 */

//! Listen for this notification if you need to do custom changes after your StyleKit is changed via Telekinesis.
extern NSString* TelekinesisDidChangeStyleKitNotification;



#pragma mark - Framework Version

FOUNDATION_EXPORT double TelekinesisFrameworkVersionNumber;
FOUNDATION_EXPORT const unsigned char TelekinesisFrameworkVersionString[];


