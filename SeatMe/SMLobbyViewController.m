//
//  SMLobbyViewController.m
//  SeatMe
//
//  Created by Martin Skow Røed on 28.06.13.
//  Copyright (c) 2013 Martin Skow Røed. All rights reserved.
//

#import "SMLobbyViewController.h"
#import "MBProgressHUD.h"


@interface SMLobbyViewController ()

@end

@implementation SMLobbyViewController
@synthesize flightNumberField, seatField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController.viewControllers.count == 2) {
        [self.navigationController setViewControllers:@[self]];
    }
}

- (void) viewDidAppear:(BOOL)animated {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [super viewDidAppear:animated];
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            NSDictionary *userData = (NSDictionary *)result;
            self.name = userData[@"name"];
            [self.topTextView setText:[NSString stringWithFormat:@"Welcome, %@! Where are you flying today?", userData[@"name"]]];
        }
        else {
            self.name = @"";
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

@end
