/*
 *  DTBeacon.m
 */

#import "DTBeacon.h"

static DTBeacon *_defaultManager = NULL;

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

#pragma mark - SINGLETON OVERRIDES

/* Retain does nothing you just return the same object */
- (id)retain {
    return self;
}

/* denotes an object that cannot be released */
- (NSUInteger)retainCount {
    return NSUIntegerMax;
}

/* Release does nothing */
- (oneway void)release {
}

/* Autorelease does nothing */
- (id)autorelease {
    return self;
}

@end
