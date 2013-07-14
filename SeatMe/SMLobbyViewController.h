//
//  SMLobbyViewController.h
//  SeatMe
//
//  Created by Martin Skow Røed on 28.06.13.
//  Copyright (c) 2013 Martin Skow Røed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SMLobbyViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic) NSString *name;
@property (weak, nonatomic) IBOutlet UITextView *topTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *flightNumberField;
@property (weak, nonatomic) IBOutlet UITextField *seatField;

@end
