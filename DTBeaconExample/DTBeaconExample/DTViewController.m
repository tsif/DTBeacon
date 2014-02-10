//
//  DTViewController.m
//  DTBeaconExample
//

#import "DTBeacon.h"

#import "DTViewController.h"

@interface DTViewController()

- (void)_proximityNotification:(NSNotification*)notification;

@end

@implementation DTViewController

#pragma mark - LIFECYCLE

- (void)viewDidLoad {
    
    /* subscribe to the proximity notification */
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_proximityNotification:)
                                                 name:kBeaconProximityNotification
                                               object:nil];
    
    /* initialise region detection */
    [[DTBeacon alloc] initRegion];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - NOTIFICATION

- (void)_proximityNotification:(NSNotification*)notification {
    
    NSLog(@"_proximityNotification: %@", [notification userInfo]);
}

@end
