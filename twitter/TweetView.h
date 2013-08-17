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
@property (nonatomic, strong) NSString *message;

-(IBAction)editingChanged:(UITextField *)sender;

@end
