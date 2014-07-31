//
//  ViewController.m
//  SMLAnimatedBars
//
//  Created by Ivan Blagajić on 30/07/14.
//  Copyright (c) 2014 Simple Things. All rights reserved.
//

#import "ViewController.h"
#import "SMLAnimatedBarsView.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet SMLAnimatedBarsView *animatedBarsView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)animateBars:(id)sender {
    [self.animatedBarsView animate];
}

- (IBAction)stop:(id)sender {
    [self.animatedBarsView stop];
}

- (IBAction)percentageMoved:(id)sender {
    
    UISlider *percentageSlider = (UISlider*)sender;
    [self.animatedBarsView updateBarsToPercentage:percentageSlider.value];
}

@end
