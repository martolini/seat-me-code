//
//  ViewController.m
//  SeatMe
//
//  Created by Martin Skow Røed on 27.06.13.
//  Copyright (c) 2013 Martin Skow Røed. All rights reserved.
//

#import "SMWelcomeViewController.h"
#import "SMLoginViewController.h"

@interface SMWelcomeViewController ()

@end

@implementation SMWelcomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated {
    if (![PFUser currentUser]) {
        SMLoginViewController *login = [[SMLoginViewController alloc] init];
        login.delegate = self;
        [self presentViewController:login animated:NO completion:nil];
    }
    else {
        [self performSegueWithIdentifier:@"WelcomeToLobby" sender:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PFLoginViewController

- (void) logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:NO completion:nil];
    [self performSegueWithIdentifier:@"WelcomeToLobby" sender:nil];
}

@end
