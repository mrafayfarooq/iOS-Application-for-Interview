//
//  AnimationSectionViewController.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "AnimationSectionViewController.h"
#import "MainMenuViewController.h"
#import <AudioToolbox/AudioServices.h>


@interface AnimationSectionViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
- (IBAction)spingButton:(id)sender;

@end

@implementation AnimationSectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//Method for PAN gesture
- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint translation = [gestureRecognizer translationInView:self.view];
    self.logoImage.center = CGPointMake(self.logoImage.center.x + translation.x,
                                         self.logoImage.center.y + translation.y);
    [gestureRecognizer setTranslation:CGPointMake(0, 0) inView:self.view];
}
- (IBAction)backAction:(id)sender
{
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] init];
    [self.navigationController pushViewController:mainMenuViewController animated:YES];
}

- (IBAction)spingButton:(id)sender {
    //Set Audio Path
    NSString *path  = [[NSBundle mainBundle] pathForResource:@"Wheel Spin" ofType:@"mp3"];
    NSURL *pathURL = [NSURL fileURLWithPath : path];
    
    SystemSoundID audioEffect;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &audioEffect);
    
  
    [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        //Start sound
        AudioServicesPlaySystemSound(audioEffect);
        //First Block Moves the image to 180 Degrees
        [self.logoImage setTransform:CGAffineTransformRotate(self.logoImage.transform, M_PI)];
    } completion:^(BOOL finished) {
        if (finished && !CGAffineTransformEqualToTransform(self.logoImage.transform, CGAffineTransformIdentity)) {
            [self logoImage];
            //Second block Moves the image to 180 Degrees
            [UIView animateWithDuration:2.8 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                [self.logoImage setTransform:CGAffineTransformRotate(self.logoImage.transform, M_PI)];
            } completion:^(BOOL finished) {
                if (finished && !CGAffineTransformEqualToTransform(self.logoImage.transform, CGAffineTransformIdentity)){
                    [self logoImage];
                    AudioServicesDisposeSystemSoundID(audioEffect);
                    }
                }];
            }
        }];
    }
@end
