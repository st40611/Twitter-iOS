//
//  TweetView.h
//  twitter
//
//  Created by Ben Lin on 8/14/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetView : UIViewController <UITextFieldDelegate>
{
    IBOutlet UITextField *messageField;
}

@property (nonatomic, weak) IBOutlet UITextField *messageField;
@property (nonatomic, weak) IBOutlet UILabel *charLimit;
@property (nonatomic, weak) IBOutlet UILabel *name;
@property (nonatomic, weak) IBOutlet UILabel *screenname;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *replyId;
@property (nonatomic, strong) User *currentUser;

-(IBAction)editingChanged:(UITextField *)sender;

@end
