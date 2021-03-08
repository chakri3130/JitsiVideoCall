
#import "ConferenceViewController.h"

@interface ConferenceViewController ()

@end

@implementation ConferenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.room == nil) {
        NSLog(@"Room is nul!");

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });

        return;
    }

    // Attach this controller as the delegate.
    JitsiMeetView *jitsiView = (JitsiMeetView*)self.view;
    jitsiView.delegate = self;
    //jitsiView.setInviteButon = false;
    // Join the room.
    JitsiMeetConferenceOptions *options
        = [JitsiMeetConferenceOptions fromBuilder:^(JitsiMeetConferenceOptionsBuilder *builder) {
            builder.room = self.room;
            [builder setFeatureFlag:@"recording.enabled" withBoolean:NO];
            [builder setFeatureFlag:@"invite.enabled" withBoolean:NO];
            [builder setFeatureFlag:@"chat.enabled" withBoolean:NO];
            builder.token = @"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb250ZXh0Ijp7InVzZXIiOnt9fSwiYXVkIjoiaml0c2ltZWV0LnR1dG9yb290LmNvbSIsImlzcyI6Ik1lZERvY01hc3RlckFwcElEIiwic3ViIjoiaml0c2ltZWV0LnR1dG9yb290LmNvbSIsInJvb20iOiIqIn0.zKkYnDh99CdxVcVIZqYpvnLgGFiQj_r38HI4WQyK7Po";
           // builder.featureFlags.setInviteButton = false;
        }];
    [jitsiView join:options];
}

- (void)conferenceWillJoin:(NSDictionary *)data
{
    [self.dataMethods StartcallNotification:data];
    NSLog(@"About to join conference %@", self.room);
}

- (void)conferenceJoined:(NSDictionary *)data
{
    NSLog(@"Conference %@ joined", self.room);
}

- (void)conferenceTerminated:(NSDictionary *)data
{
    NSLog(@"Conference %@ terminated", self.room);
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.dataMethods EndCallNotification:data];
}

@end
