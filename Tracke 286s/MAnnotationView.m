//
//  MAnnotationView.m
//  Tracke 286s
//
//  Created by Antonio081014 on 4/7/14.
//  Copyright (c) 2014 Antonio081014.com. All rights reserved.
//

#import "MAnnotationView.h"
#import "MAnnotation.h"

@implementation MAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        // Set the frame size to the appropriate values.
        CGRect cFrame = self.frame;
        cFrame.size.width = 40;
        cFrame.size.height = 40;
        self.frame = cFrame;
        
        self.contentMode = UIViewContentModeRedraw;
        
        // The opaque property is YES by default. Setting it to
        // NO allows map content to show through any unrendered parts of your view.
        
        self.opaque = NO;
    }
    return self;
}

// This function is critical, the comment is very important.
// Whenever you assign an annotation to this view, the view will be redraw.
- (void)setAnnotation:(id <MKAnnotation>)annotation
{
    [super setAnnotation:annotation];
    
    // this annotation view has custom drawing code.  So when we reuse an annotation view
    // (through MapView's delegate "dequeueReusableAnnoationViewWithIdentifier" which returns non-nil)
    // we need to have it redraw the new annotation data.
    //
    // for any other custom annotation view which has just contains a simple image, this won't be needed
    //
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
// This function simply draw a triangle, then rotate in proper angle.
- (void)drawRect:(CGRect)rect
{
    CGFloat angle = 0.f;
    if ([self.annotation isKindOfClass:[MAnnotation class]]) {
        MAnnotation *annotation = (MAnnotation *)self.annotation;
        angle = [annotation.angle doubleValue];
    }
    
    CGFloat size = MIN(self.bounds.size.width, self.bounds.size.height) / 2.f;
    CGPoint center = CGPointMake(self.bounds.size.width / 2.f, self.bounds.size.height / 2.f);
    
    // Draw the Path.
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(center.x + 0.f, center.y - size)];
    [path addLineToPoint:CGPointMake(center.x - size / 2.f, center.y + size / 2.f * sqrt(3.f))];
    [path addLineToPoint:CGPointMake(center.x + size / 2.f, center.y + size / 2.f * sqrt(3.f))];
    [path closePath];
    
    // Rotate to the right angle.
    CGAffineTransform transform = CGAffineTransformIdentity;
//    [path applyTransform:transform];
    transform = CGAffineTransformTranslate(transform, center.x, center.y);
    transform = CGAffineTransformRotate(transform, angle / 180.f * M_PI);
    transform = CGAffineTransformTranslate(transform, -center.x, -center.y);
    [path applyTransform:transform];
    
    // Fill and Stroke with right color.
    [[UIColor redColor] setFill];
    [[UIColor blackColor] setStroke];
    [path fill];
    [path stroke];
}


@end
