/*
 *  DTBeacon.h
 */


#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <Foundation/Foundation.h>

/* Notification names */
extern NSString *const kBeaconPeripheralManagerStateNotification;
extern NSString *const kBeaconPeripheralManagerStateKey;

extern NSString *const kBeaconEnteredRegionNotification;
extern NSString *const kBeaconExiteRegionNotification;

extern NSString *const kBeaconProximityNotification;
extern NSString *const kBeaconProximityKey;

@interface DTBeacon : NSObject<CBPeripheralManagerDelegate>

+ (DTBeacon*)sharedInstance;

/* Beacon */
- (void)initBeacon;
- (void)transmitBeacon;

/* Reagion */
- (void)initRegion;

@end
