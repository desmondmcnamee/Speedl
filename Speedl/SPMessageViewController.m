//
//  SPMessageViewController.m
//  Speedle
//
//  Created by Desmond McNamee on 2015-03-15.
//  Copyright (c) 2015 Desmond McNamee. All rights reserved.
//

#import "SPMessageViewController.h"
#import "SPComposeViewController.h"
#import "SPMessageLabel.h"

@interface SPMessageViewController ()
@property (strong, nonatomic) IBOutlet SPMessageLabel *messageLabel;
@property (strong, nonatomic) IBOutlet SPMessageLabel *countDown;
@property (strong, nonatomic) IBOutlet UIButton *pauseButton;
@property (strong, nonatomic) IBOutlet UIButton *restartButton;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UILabel *messageFromLabel;
@property (strong, nonatomic) IBOutlet UILabel *fromLabel;

@end

@implementation SPMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_restartButton setHidden:YES];
    [_playButton setHidden:YES];
    [_messageLabel setHidden:YES];
    [_pauseButton setEnabled:NO];
    
    _messageLabel.messageText = @"TransitionKit is a small Cocoa library that provides an API for implementing a state machine.";
    _messageLabel.wordPerMin = 250;
    
    _countDown.messageText = @"3 2 1";
    _countDown.wordPerMin = 60;
    
    [_countDown playAnimationWithCompletionBlock:^{
        [_messageLabel setHidden:NO];
        [_messageLabel playAnimationWithCompletionBlock:^{
            [self handleMessageComplete];
        }];
        [_pauseButton setEnabled:YES];
        [_countDown setHidden:YES];
        [_messageFromLabel setHidden:YES];
        [_fromLabel setHidden:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onPlayPress:(id)sender {
    [_restartButton setHidden:YES];
    [_playButton setHidden:YES];
    [_messageLabel playAnimationWithCompletionBlock:^{
        [self handleMessageComplete];
    }];
}
- (IBAction)onPausePress:(id)sender {
    [_restartButton setHidden:NO];
    [_playButton setHidden:NO];
    [_messageLabel pauseAnination];
}
- (IBAction)onRestartPress:(id)sender {
    [_messageLabel restartAnimation];
}

- (void) handleMessageComplete {
    NSLog(@"Hiding Message!");
    [_messageLabel setHidden:YES];
    [_pauseButton setEnabled:NO];
    SPComposeViewController *composeViewController = [[SPComposeViewController alloc] init];
    
    // initialize the navigation controller and present it
    [self presentViewController:composeViewController animated:NO completion:nil];
}
@end
