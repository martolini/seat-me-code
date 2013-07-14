//
//  SMFlightSeat.m
//  SeatMe
//
//  Created by Martin Skow Røed on 13.07.13.
//  Copyright (c) 2013 Martin Skow Røed. All rights reserved.
//

#import "SMFlightSeat.h"

#define X_OFFSET 10
#define Y_OFFSET 20
#define DELTA_X 10
@implementation SMFlightSeat
@synthesize xcoord, ycoord, row, seat;

- (id) initWithJSON:(NSDictionary *)JSON andMinX:(int)x_min andMaxX:(int)x_max andMinY:(int)y_min{
    if (self = [super initWithFrame:CGRectMake(0, 0, 100, 100)]) {
        self.xcoord = ([[JSON objectForKey:@"x1"] intValue] - x_min)/(float)(x_max-x_min)*280+X_OFFSET;
        self.ycoord = ([[JSON objectForKey:@"y1"] intValue] - y_min)/(float)(x_max-x_min)*280+Y_OFFSET;
        self.row = [[JSON objectForKey:@"row"] intValue];
        self.seat = [JSON objectForKey:@"seat"];
    }
    return self;
}

- (void) setSize:(CGSize)size {
    CGRect frame = CGRectMake(self.xcoord, self.ycoord, size.width, size.height);
    [super setFrame:frame];
}



@end
