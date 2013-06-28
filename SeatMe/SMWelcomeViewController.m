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
    SMLoginViewController *login = [[SMLoginViewController alloc] init];
    [self presentViewController:login animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
