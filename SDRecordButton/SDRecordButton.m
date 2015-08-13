//
//  SDRecordButton.m
//  SDRecordButton
//
//  Created by Sebastian Dobrincu on 13/08/15.
//  Copyright (c) 2015 Sebastian Dobrincu. All rights reserved.
//

#import "SDRecordButton.h"

@interface SDRecordButton(){
    UIColor *mainColor;
    UIColor *progColor;
    CGFloat currentProgress;
}
@end

@implementation SDRecordButton

-  (id)initWithFrame:(CGRect)aRect {
    self = [super initWithFrame:aRect];

    if (self) {
        [self addTarget:self action:@selector(didTouchDown) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(didTouchUp) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(didTouchUp) forControlEvents:UIControlEventTouchUpOutside];
        [self drawButton];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];

    if (self) {
        [self addTarget:self action:@selector(didTouchDown) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(didTouchUp) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(didTouchUp) forControlEvents:UIControlEventTouchUpOutside];
        [self drawButton];
    }
    
    return self;
}

-(void)setProgressColor:(UIColor *)prColor {
    
    progColor = prColor;
    
    UIColor *topColor = progColor;
    UIColor *bottomColor = progColor;
    _gradientMaskLayer.colors = @[(id)topColor.CGColor, (id)bottomColor.CGColor];
    
}

-(void)setButtonColor:(UIColor *)buttonColor{
    
    _circleLayer.backgroundColor = buttonColor.CGColor;
    _circleBorder.borderColor = buttonColor.CGColor;
    
    mainColor = buttonColor;
}

- (void)drawButton {
    
    currentProgress = 0;
    self.backgroundColor = [UIColor clearColor];
    
    // Get the root layer
    CALayer *layer = self.layer;

    if (!_circleLayer) {
        
        _circleLayer = [CALayer layer];
        _circleLayer.backgroundColor = mainColor.CGColor;
        
        CGFloat size = self.frame.size.width/1.5;
        _circleLayer.bounds = CGRectMake(0, 0, size, size);
        _circleLayer.anchorPoint = CGPointMake(0.5, 0.5);
        _circleLayer.position = (CGPoint){CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)};
        
        _circleLayer.cornerRadius = size/2;
        
        [layer insertSublayer:_circleLayer atIndex:0];
    }
    
    if (!_circleBorder) {
        
        _circleBorder = [CALayer layer];
        _circleBorder.backgroundColor = [UIColor clearColor].CGColor;
        _circleBorder.borderWidth = 1;
        _circleBorder.borderColor = mainColor.CGColor;
        
        _circleBorder.bounds = CGRectMake(0, 0, self.bounds.size.width-1.5f, self.bounds.size.height-1.5f);
        _circleBorder.anchorPoint = CGPointMake(0.5, 0.5);
        _circleBorder.position = (CGPoint){CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)};
        
        _circleBorder.cornerRadius = self.frame.size.width/2;

        [layer insertSublayer:_circleBorder atIndex:0];
    }
    
    if (!_progressLayer) {

        CGFloat startAngle = M_PI + M_PI_2;
        CGFloat endAngle = M_PI * 3 + M_PI_2;
        CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        
        _gradientMaskLayer = [self gradientMask];
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.path = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:self.frame.size.width/2-2 startAngle:startAngle endAngle:endAngle clockwise:YES].CGPath;
        _progressLayer.backgroundColor = [UIColor clearColor].CGColor;
        _progressLayer.fillColor = nil;
        _progressLayer.strokeColor = [UIColor blackColor].CGColor;
        _progressLayer.lineWidth = 4.0;
        _progressLayer.strokeStart = 0.0;
        _progressLayer.strokeEnd = 0.0;

        _gradientMaskLayer.mask = _progressLayer;
        [layer insertSublayer:_gradientMaskLayer atIndex:0];
    }
}

- (CAGradientLayer *)gradientMask {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.locations = @[@0.0, @1.0];
    
    if (!progColor)
        progColor = [UIColor blueColor];
    
    UIColor *topColor = progColor;
    UIColor *bottomColor = progColor;
    
    gradientLayer.colors = @[(id)topColor.CGColor, (id)bottomColor.CGColor];
    
    return gradientLayer;
}


- (void)layoutSubviews {

    _circleLayer.anchorPoint = CGPointMake(0.5, 0.5);
    _circleLayer.position = (CGPoint){CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)};

    _circleBorder.anchorPoint = CGPointMake(0.5, 0.5);
    _circleBorder.position = (CGPoint){CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)};
    
    [super layoutSubviews];
}

- (void)didTouchDown {
 
    CGFloat duration = 0.15;
    _circleLayer.contentsGravity = @"center";
    
    // Animate main circle
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.fromValue = @1.0;
    scale.toValue = @0.88;
    [scale setDuration:duration];
    scale.fillMode = kCAFillModeForwards;
    scale.removedOnCompletion = NO;
    CABasicAnimation *color = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    [color setDuration:duration];
    color.fillMode = kCAFillModeForwards;
    color.removedOnCompletion = NO;
    color.toValue = (id)progColor.CGColor;
    
    CAAnimationGroup *circleAnimations = [CAAnimationGroup animation];
    circleAnimations.removedOnCompletion = NO;
    circleAnimations.fillMode = kCAFillModeForwards;
    [circleAnimations setDuration:duration];
    [circleAnimations setAnimations:@[scale, color]];
    
    // Animate border
    CABasicAnimation *borderColor = [CABasicAnimation animationWithKeyPath:@"borderColor"];
    borderColor.duration = duration;
    borderColor.fillMode = kCAFillModeForwards;
    borderColor.removedOnCompletion = NO;
    borderColor.toValue = (id)[UIColor colorWithRed:0.83 green:0.86 blue:0.89 alpha:1].CGColor;
    CABasicAnimation *borderScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    borderScale.fromValue = [NSNumber numberWithFloat:[[_circleBorder.presentationLayer valueForKeyPath: @"transform.scale"] floatValue]];
    borderScale.toValue = @0.88;
    [borderScale setDuration:duration];
    borderScale.fillMode = kCAFillModeForwards;
    borderScale.removedOnCompletion = NO;
    
    CAAnimationGroup *borderAnimations = [CAAnimationGroup animation];
    borderAnimations.removedOnCompletion = NO;
    borderAnimations.fillMode = kCAFillModeForwards;
    [borderAnimations setDuration:duration];
    [borderAnimations setAnimations:@[borderColor, borderScale]];
    
    // Animate progress
    CABasicAnimation *fadeIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeIn.fromValue = @0.0;
    fadeIn.toValue = @1.0;
    fadeIn.duration = duration;
    fadeIn.fillMode = kCAFillModeForwards;
    fadeIn.removedOnCompletion = NO;
    
    [_progressLayer addAnimation:fadeIn forKey:@"fadeIn"];
    [_circleBorder addAnimation:borderAnimations forKey:@"borderAnimations"];
    [_circleLayer addAnimation:circleAnimations forKey:@"circleAnimations"];
}


- (void)didTouchUp {
    
    CGFloat duration = 0.15;
    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.fromValue = @0.88;
    scale.toValue =   @1.0;
    [scale setDuration:duration];
    scale.fillMode = kCAFillModeForwards;
    scale.removedOnCompletion = NO;
    CABasicAnimation *color = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    color.fillMode = kCAFillModeForwards;
    color.removedOnCompletion = NO;
    color.toValue = (id)mainColor.CGColor;
    
    CAAnimationGroup *animations = [CAAnimationGroup animation];
    animations.removedOnCompletion = NO;
    animations.fillMode = kCAFillModeForwards;
    [animations setDuration:duration]    ;
    [animations setAnimations:@[scale, color]];
    
    CABasicAnimation *borderColor = [CABasicAnimation animationWithKeyPath:@"borderColor"];
    borderColor.duration = duration;
    borderColor.fillMode = kCAFillModeForwards;
    borderColor.removedOnCompletion = NO;
    borderColor.toValue = (id)mainColor.CGColor;
    CABasicAnimation *borderScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    borderScale.fromValue = @0.88;
    borderScale.toValue = @1.0;
    [borderScale setDuration:duration];
    borderScale.fillMode = kCAFillModeForwards;
    borderScale.removedOnCompletion = NO;
    
    CAAnimationGroup *borderAnimations = [CAAnimationGroup animation];
    borderAnimations.removedOnCompletion = NO;
    borderAnimations.fillMode = kCAFillModeForwards;
    [borderAnimations setDuration:duration];
    [borderAnimations setAnimations:@[borderColor, borderScale]];
    
    
    // Animate progress
    CABasicAnimation *fadeOut = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeOut.fromValue = @1.0;
    fadeOut.toValue = @0.0;
    fadeOut.duration = duration*2;
    fadeOut.fillMode = kCAFillModeForwards;
    fadeOut.removedOnCompletion = NO;

    [_progressLayer addAnimation:fadeOut forKey:@"fadeOut"];
    [_circleBorder addAnimation:borderAnimations forKey:@"borderAnimations"];
    [_circleLayer addAnimation:animations forKey:@"circleAnimations"];
}

- (void)setProgress:(CGFloat)newProgress{
    _progressLayer.strokeEnd = newProgress;
    
}

@end
