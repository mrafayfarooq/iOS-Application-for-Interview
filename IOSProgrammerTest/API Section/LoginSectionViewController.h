//
//  APISectionViewController.h
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginSectionViewController : UIViewController <UIAlertViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end
