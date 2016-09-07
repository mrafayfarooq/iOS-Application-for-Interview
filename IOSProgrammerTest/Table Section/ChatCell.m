//
//  TableSectionTableViewCell.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "ChatCell.h"

@interface ChatCell ()
@property (nonatomic, strong) IBOutlet UILabel *usernameLabel;
@property (nonatomic, strong) IBOutlet UITextView *messageTextView;

@end

@implementation ChatCell

- (void)awakeFromNib
{
        //Create Dispatch Queue
        dispatch_async(dispatch_get_main_queue(), ^{
            //Updating UI
            [self.messageTextView setContentOffset:CGPointZero animated:NO];
            self.userImage.layer.cornerRadius = 25 ;
            self.userImage.clipsToBounds = YES;

    });
}
- (void)loadWithData:(ChatData *)chatData
{
    self.usernameLabel.text = chatData.username;
    self.messageTextView.text = chatData.message;
    
}
@end
