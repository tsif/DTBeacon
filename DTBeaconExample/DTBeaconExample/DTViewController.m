//
//  DTViewController.m
//  DTBeaconExample
//

#import "DTBeacon.h"

#import "DTViewController.h"

@interface DTViewController()

- (void)_proximityNotification:(NSNotification*)notification;

@property(nonatomic, strong) IBOutlet UILabel *proximityLabel;

@end

@implementation DTViewController

@synthesize proximityLabel;

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
    
    NSDictionary *d        = [notification userInfo];
    NSInteger    proximity = [[d objectForKey:kBeaconProximityKey] integerValue];
    
    if(proximity == CLProximityUnknown) {
        self.proximityLabel.text = @"Unknown Proximity";
        
    } else if(proximity == CLProximityImmediate) {
        self.proximityLabel.text = @"Immediate";
    
    } else if(proximity == CLProximityNear) {
        self.proximityLabel.text = @"Near";
    
    } else if(proximity == CLProximityFar) {
    
        self.proximityLabel.text = @"Far";
    }
}

@end
