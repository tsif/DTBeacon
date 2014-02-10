/*
 *  DTBeacon.h
 */

#import <Foundation/Foundation.h>

@interface DTBeacon : NSObject<CBPeripheralManagerDelegate>

+ (DTBeacon*)sharedInstance;

/* Beacon */
- (void)initBeacon;
- (void)transmitBeacon;

/* Reagion */
- (void)initRegion;

@end
