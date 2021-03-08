/********* JitsiVCall.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "ConferenceViewController.h"

@import JitsiMeet;

@interface JitsiVCall : CDVPlugin<jitsiconferecedelgeteMethods> {
  // Member variables go here.
}
@property (nonatomic) CDVInvokedUrlCommand *commandURL;
- (void)coolMethod:(CDVInvokedUrlCommand*)command;
- (void)startconfig:(CDVInvokedUrlCommand*)cmd;
@end

@implementation JitsiVCall

- (void)coolMethod:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];

    if (echo != nil && [echo length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)startconfig:(CDVInvokedUrlCommand*)cmd
{
    NSString* roomname = [cmd.arguments objectAtIndex:0];
    NSLog(@"recoved Roomname: %@",roomname);
    if(roomname == nil)
    {
        roomname = @"Swetha";
    }
    _commandURL = cmd;
    // Initialize default options for joining conferences.
    JitsiMeetConferenceOptions *defaultOptions
        = [JitsiMeetConferenceOptions fromBuilder:^(JitsiMeetConferenceOptionsBuilder *builder) {
            builder.serverURL = [NSURL URLWithString:@"https://jitsimeet.tutoroot.com"];
            builder.welcomePageEnabled = NO;
            // = false;
        }];
    [JitsiMeet sharedInstance].defaultConferenceOptions = defaultOptions;
    
    ConferenceViewController *vc = [[ConferenceViewController alloc]init];
    vc.room = roomname;
    vc.dataMethods = self;
    [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:vc animated:YES completion:^{
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Ok"];
        [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
    }];
    
}

- (void)EndCallNotification:(NSObject *)obj {
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"END"];
    [self.commandDelegate sendPluginResult:result callbackId:_commandURL.callbackId];
}

- (void)StartcallNotification:(NSObject *)obj {
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Join"];
    [self.commandDelegate sendPluginResult:result callbackId:_commandURL.callbackId];
}
@end
