//
//  TweetView.m
//  twitter
//
//  Created by Ben Lin on 8/14/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TweetView.h"

@interface TweetView ()

-(void) tweet;

@end

@implementation TweetView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.messageField.delegate = self;
    if ([self.message length] == 0) {
        self.messageField.placeholder = @"What's on your mind today?";
    } else {
        self.messageField.text = self.message;
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(tweet)];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

-(IBAction)editingChanged:(UITextField *)textField {
    NSString *count = [NSString stringWithFormat: @"%d", (160 - textField.text.length)];
    [self.charLimit setTextColor:[UIColor darkGrayColor]];
    self.charLimit.text = count;
}

#pragma mark - private methods 

- (void)tweet {
    
}

@end
