//
//  APISectionViewController.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "LoginSectionViewController.h"
#import "MainMenuViewController.h"
#import "AFHTTPSessionManager.h"
//Macro for changing Hex Color Value to UIColor
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface LoginSectionViewController ()
- (IBAction)logInBtnPressed:(id)sender;

@end

@implementation LoginSectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.userName.delegate = self;
    self.password.delegate = self;
    UIColor *color = UIColorFromRGB(0x898989);
    self.userName.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"username"
                                    attributes:@{
                                                 NSForegroundColorAttributeName: color,
                                                 NSFontAttributeName : [UIFont fontWithName:@"Machinato" size:18.0]
                                                 }
     ];
    self.password.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"password"
                                    attributes:@{
                                                 NSForegroundColorAttributeName: color,
                                                 NSFontAttributeName : [UIFont fontWithName:@"Machinato" size:18.0]
                                                 }
     ];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSData *)makeParameter {
    
    NSDictionary *parameters  = @{@"username": self.userName.text,
                             @"password": self.password.text};
    NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:parameters];
    return myData;
}
- (NSString *)makeResponse:(NSDictionary*)responseObject endTime:(CFTimeInterval)elapsedTime {
    
    NSString *response = [NSString stringWithFormat:@"Code:%@ \n Response:%@ \n Time %f ms",[responseObject objectForKey:@"code"],[responseObject objectForKey:@"message"],elapsedTime];

    return response;
}
- (void)handleRequest{
    
    
    NSURL * url = [NSURL URLWithString:@"http://dev.apppartner.com/AppPartnerProgrammerTest/scripts/login.php"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:[self makeParameter] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"Data:%@",data);
            NSLog(@"Response:%@",response);
            NSLog(@"This is Background Thread");
            NSLog(@"Error:%@",error);
    }];
    
    [uploadTask resume];
    NSLog(@"This is Main Thread");
   /* AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //Added because server was returning text/html format
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    //Note Start Time
    CFTimeInterval startTime = CACurrentMediaTime();
    
    //Make Assync Request
    [manager POST:@"http://dev.apppartner.com/AppPartnerProgrammerTest/scripts/login.php"  parameters:[self makeParameter] progress:^(NSProgress * _Nonnull uploadProgress) {}
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              //Note End Time
              CFTimeInterval elapsedTime = ((CACurrentMediaTime() - startTime)*1000);
              [self showAlert:[self makeResponse:responseObject endTime:elapsedTime]];
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {}
     ];*/
    
}
#pragma mark - Alert View

- (void)showAlert:(NSString *)response {
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Response"
                                  message:response
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             [self backAction:nil];
                             
                         }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    
}
#pragma mark - UIButton Actions


- (IBAction)backAction:(id)sender
{
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] init];
    [self.navigationController pushViewController:mainMenuViewController animated:YES];
}

- (IBAction)logInBtnPressed:(id)sender {
    [self handleRequest];
}
#pragma mark - UITextField delegates

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == self.userName){
        [textField resignFirstResponder];
        textField = self.password;
        [textField becomeFirstResponder];
    }
    else if (textField == self.password)
        [textField resignFirstResponder];
    return YES;
}

@end
