//
//  ViewController.m
//  fallSnowDemo
//
//  Created by YaoKaige on 16/5/23.
//  Copyright © 2016年 Beijing Gan Servant Software Co., Ltd. All rights reserved.
//

#import "ViewController.h"
#define mainScreenWidth     [UIScreen mainScreen].bounds.size.width
#define mainScreenHeight    [UIScreen mainScreen].bounds.size.height


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:1 green:0.5 blue:0.5 alpha:1.0];
    // load our flake image we will use the same image over and over
//   self.flakeImage = [UIImage imageNamed:@"Rain.png"];
    self.flakeImage = [UIImage imageNamed:@"flake"];
    // start a timet that will fire 20 times per second
    [NSTimer scheduledTimerWithTimeInterval:(0.05) target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
}

-(void)onTimer{
    // build a view from our flake image
    UIImageView* flakeView = [[UIImageView alloc] initWithImage:_flakeImage];
    // use the random() function to randomize up our flake attributes
    int startX = round(random() % (int)mainScreenWidth);
    int endX = round(random() % (int)mainScreenWidth);
    double scale = 1 / round(random() % 100) + 1.0;
    double speed = 1 / round(random() % 100) + 1.0;
    
    // set the flake start position
    flakeView.frame = CGRectMake(startX,-100, 25.0 * scale, 25.0 * scale);
//    CGSize size = _flakeImage.size;
//    flakeView.frame = CGRectMake(startX,-100,size.width*scale, size.height * scale);
    flakeView.alpha = 0.5;
    
    // put the flake in our main view
    [self.view addSubview:flakeView];
    
    [UIView beginAnimations:nil context:(__bridge void * _Nullable)(flakeView)];
    // set up how fast the flake will fall
    double duration = (random()%15+1)*speed;
    [UIView setAnimationDuration:duration];
    
    // set the postion where flake will move to
    flakeView.frame = CGRectMake(endX, mainScreenHeight+100, 25.0 * scale, 25.0 * scale);
    
    // set a stop callback so we can cleanup the flake when it reaches the
    // end of its animation
    [UIView setAnimationDidStopSelector:@selector(onAnimationComplete:finished:context:)];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

- (void)onAnimationComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    UIImageView *flakeView = (__bridge UIImageView *)(context);
    [flakeView removeFromSuperview];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
