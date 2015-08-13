//
//  SDRecordButton.h
//  SDRecordButton
//
//  Created by Sebastian Dobrincu on 13/08/15.
//  Copyright (c) 2015 Sebastian Dobrincu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDRecordButton : UIButton

@property (nonatomic, strong) IBInspectable UIColor *buttonColor;
@property (nonatomic, strong) IBInspectable UIColor *progressColor;
@property (nonatomic, strong) CALayer *circleLayer;
@property (nonatomic, strong) CALayer *circleBorder;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CAGradientLayer *gradientMaskLayer;

- (void)setProgress:(CGFloat)newProgress;

@end
