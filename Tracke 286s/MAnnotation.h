//
//  MAnnotation.h
//  Tracke 286s
//
//  Created by Antonio081014 on 4/7/14.
//  Copyright (c) 2014 Antonio081014.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface MAnnotation : NSObject <MKAnnotation>

@property (nonatomic, strong) NSNumber *angle;

- (id)initWithLocation:(CLLocationCoordinate2D)coord andAngle:(CGFloat) angle;

@end
