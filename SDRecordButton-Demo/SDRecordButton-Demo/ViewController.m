//
//  ViewController.m
//  SDRecordButton-Demo
//
//  Created by Sebastian Dobrincu on 13/08/15.
//  Copyright (c) 2017 Sebastian Dobrincu. All rights reserved.
//

#import "ViewController.h"
#import "SDRecordButton.h"

const int videoDuration  = 5;

@interface ViewController ()
@property (nonatomic, strong) IBOutlet SDRecordButton *recordButton;
@property (nonatomic, strong)          NSTimer        *progressTimer;
@property (nonatomic)                  CGFloat        progress;
@end

@implementation ViewController

#pragma mark - SDRecordButton

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self randomColorTapped:nil];
}

- (void)configureButtonWithColor:(UIColor*)color progressColor:(UIColor *)progressColor {
	
	// Configure colors
	self.recordButton.buttonColor = color;
	self.recordButton.progressColor = progressColor;
	
	// Add Targets
	[self.recordButton addTarget:self action:@selector(recording) forControlEvents:UIControlEventTouchDown];
	[self.recordButton addTarget:self action:@selector(pausedRecording) forControlEvents:UIControlEventTouchUpInside];
	[self.recordButton addTarget:self action:@selector(pausedRecording) forControlEvents:UIControlEventTouchUpOutside];
	
}

- (void)recording {
	NSLog(@"Started recording");
	self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
}

- (void)pausedRecording {
	NSLog(@"Paused recording");
	[self.progressTimer invalidate];
}

- (void)updateProgress {
	self.progress += 0.05/videoDuration;
	[self.recordButton setProgress:self.progress];
	if (self.progress >= 1)
		[self.progressTimer invalidate];
}

#pragma mark - User Interaction

- (IBAction)resetProgressTapped:(id)sender {
	self.progress = 0;
	[self.recordButton setProgress:self.progress];
}

- (IBAction)randomColorTapped:(id)sender {
	
	CGFloat hue1 = ( arc4random() % 256 / 256.0 );
	CGFloat hue2 = ( arc4random() % 256 / 256.0 );
	UIColor *buttonColor = [UIColor colorWithHue:hue1 saturation:0.95f brightness:0.89f alpha:1];
	UIColor *progressColor = [UIColor colorWithHue:hue2 saturation:0.95f brightness:0.89f alpha:1];
	
	SDRecordButton *btnCopy = [[SDRecordButton alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame)-65/2, CGRectGetMidY(self.view.frame)-65/2, 65, 65)];
	[self.recordButton removeFromSuperview];
	self.recordButton = btnCopy;
	[self configureButtonWithColor:buttonColor progressColor:progressColor];
	[self.view addSubview:self.recordButton];
	
}

@end
