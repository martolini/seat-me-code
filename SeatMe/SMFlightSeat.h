//
//  SMFlightSeat.h
//  SeatMe
//
//  Created by Martin Skow Røed on 13.07.13.
//  Copyright (c) 2013 Martin Skow Røed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMFlightSeat : UIButton

@property (weak, nonatomic) NSString *seat;
@property (nonatomic) int row;
@property (nonatomic) float xcoord;
@property (nonatomic) float ycoord;

- (id) initWithJSON:(NSDictionary *)JSON andMinX:(int)x_min andMaxX:(int)x_max andMinY:(int)y_min;
- (void) setSize:(CGSize)size;



@end
