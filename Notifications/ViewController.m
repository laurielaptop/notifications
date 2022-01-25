//
//  ViewController.m
//  Notifications
//
//  Created by Laurie Laptop on 19/01/2022.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSThread isMainThread] ? @"*MAIN*" : @"*BACKGROUND*");
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMessage:) name:@"didReceiveMessage" object:nil];
}

- (void)dealloc {
    NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSThread isMainThread] ? @"*MAIN*" : @"*BACKGROUND*");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMessage:(NSNotification *)notification {
    NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSThread isMainThread] ? @"*MAIN*" : @"*BACKGROUND*");
    self.message1Label.text = @"";
    self.message2TextField.text = @"";
    [UIView animateWithDuration:0.25 animations:^{
        self.view.backgroundColor = UIColor.systemBlueColor;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.backgroundColor = UIColor.systemBackgroundColor;
        } completion:^(BOOL finished) {
            self.message1Label.text = (NSString*)notification.userInfo[@"message1"];
            self.message2TextField.text = (NSString*)notification.userInfo[@"message2"];
        }];
    }];
}

@end
