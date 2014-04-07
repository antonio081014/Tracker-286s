//
//  MAnnotation.m
//  Tracke 286s
//
//  Created by Antonio081014 on 4/7/14.
//  Copyright (c) 2014 Antonio081014.com. All rights reserved.
//

#import "MAnnotation.h"

@implementation MAnnotation

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;

- (id)initWithLocation:(CLLocationCoordinate2D)coord andAngle:(CGFloat)angle
{
    self = [super init];
    if (self) {
        self.coordinate = coord;
        self.angle = [NSNumber numberWithDouble:angle];
    }
    return self;
}

#define epsilon 0.005f
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    if ((fabs(_coordinate.latitude - newCoordinate.latitude) > epsilon || fabs(_coordinate.longitude - newCoordinate.longitude) > epsilon)) {
        [self willChangeValueForKey:@"coordinate"];
        _coordinate = newCoordinate;
        [self didChangeValueForKey:@"coordinate"];
    }
}

- (CLLocationCoordinate2D)coordinate
{
    return _coordinate;
}

- (void)setTitle:(NSString *)title
{
    if (_title != title) {
        [self willChangeValueForKey:@"title"];
        _title = title;
        [self didChangeValueForKey:@"title"];
    }
}

- (NSString *)title
{
    if (_title) {
        return _title;
    }
    return _title = [NSString stringWithFormat:@"%.6f", [self.angle doubleValue]];
}

- (NSString *)subtitle
{
    if (_subtitle) {
        return _subtitle;
    }
    return _subtitle = [NSString stringWithFormat:@"(%.5f, %.5f)", self.coordinate.longitude, self.coordinate.latitude];
}

- (void)setSubtitle:(NSString *)subtitle
{
    if (_subtitle != subtitle) {
        [self willChangeValueForKey:@"subtitle"];
        _subtitle = subtitle;
        [self didChangeValueForKey:@"subtitle"];
    }
}
@end
