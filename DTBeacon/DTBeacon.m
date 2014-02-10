/*
 *  DTBeacon.m
 */


#import "DTBeacon.h"

NSString *const   kBeaconPeripheralManagerStateNotification = @"kBeaconPeripheralManagerStateNotification";
NSString *const   kBeaconPeripheralManagerStateKey          = @"kBeaconPeripheralManagerStateKey";

NSString *const   kBeaconEnteredRegionNotification          = @"kBeaconEnteredRegionNotification";
NSString *const   kBeaconExiteRegionNotification            = @"kBeaconExiteRegionNotification";

NSString *const   kBeaconProximityNotification              = @"kBeaconProximityNotification";
NSString *const   kBeaconProximityKey                       = @"kBeaconProximityKey";

NSString *const   kBeaconUUID                               = @"7bf9c270-9258-11e3-baa8-0800200c9a66";
static   DTBeacon *_defaultManager                          = NULL;

@interface DTBeacon() {
	
    CLBeaconRegion      *_beaconRegion;
    CLLocationManager   *_locationManager;
    CBPeripheralManager *_peripheralManager;
    NSDictionary        *_beaconPeripheralData;
}

@end

@implementation DTBeacon

#pragma mark - LIFECYCLE

/* Access to singleton */
+ (DTBeacon*)sharedInstance {
    
	@synchronized (self) {
		if (_defaultManager == nil) {
			_defaultManager = [[DTBeacon alloc] init];
		}
	}
    return _defaultManager;
}

- (id)init {
    
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)initBeacon {
	
    NSUUID *uuid  = [[NSUUID alloc] initWithUUIDString:kBeaconUUID];
    _beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                major:1
                                                                minor:1
                                                           identifier:@"com.sprimp.DTBeaconExample"];
    
    return;
}

- (void)initRegion {
    
    NSUUID *uuid  = [[NSUUID alloc] initWithUUIDString:kBeaconUUID];
    _beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"com.devfright.myRegion"];
    
    [_locationManager startMonitoringForRegion:_beaconRegion];
}

#pragma mark - TRANSMIT

- (void)transmitBeacon {
    
    _beaconPeripheralData = [_beaconRegion peripheralDataWithMeasuredPower:nil];
    _peripheralManager    = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                    queue:nil
                                                                  options:nil];
}

#pragma mark - TRASMIT DELEGATE

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    
    if(peripheral.state == CBPeripheralManagerStatePoweredOn) {
        [_peripheralManager startAdvertising:_beaconPeripheralData];
        
    } else if(peripheral.state == CBPeripheralManagerStatePoweredOff) {
        
        [_peripheralManager stopAdvertising];
    }
    
    /* notify observers */
    [[NSNotificationCenter defaultCenter] postNotificationName:kBeaconPeripheralManagerStateNotification
                                                        object:nil
                                                      userInfo:@{kBeaconPeripheralManagerStateKey : @(peripheral.state)}];
}

#pragma mark - REGION DELEGATE

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    
    CLBeacon *beacon = [[CLBeacon alloc] init];
    beacon           = [beacons lastObject];
    
    /* notify observers */
    [[NSNotificationCenter defaultCenter] postNotificationName:kBeaconProximityNotification
                                                        object:nil
                                                      userInfo:@{kBeaconProximityKey : @(beacon.proximity)}];
    
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    
    [_locationManager startRangingBeaconsInRegion:_beaconRegion];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kBeaconEnteredRegionNotification
                                                        object:nil];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    
    [_locationManager stopRangingBeaconsInRegion:_beaconRegion];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kBeaconExiteRegionNotification
                                                        object:nil];
}

@end
