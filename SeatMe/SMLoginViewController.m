//
//  SMLoginViewController.m
//  SeatMe
//
//  Created by Martin Skow Røed on 27.06.13.
//  Copyright (c) 2013 Martin Skow Røed. All rights reserved.
//

#import "SMLoginViewController.h"

@interface SMLoginViewController ()

@end

@implementation SMLoginViewController

- (id) init {
    if (self = [super init]) {
        self.fields = PFLogInFieldsFacebook;
        self.facebookPermissions = @[@"user_about_me"];
    }
    return self;
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect fbFrame = self.logInView.facebookButton.frame;
    fbFrame.origin.y = 350;
    [self.logInView.facebookButton setFrame:fbFrame];
    [self.logInView setLogo:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Login delegate

- (void) logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
}

@end
