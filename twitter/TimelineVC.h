//
//  TimelineVC.h
//  twitter
//
//  Created by Timothy Lee on 8/4/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TweetView;

@interface TimelineVC : UITableViewController

@property (nonatomic, strong) TweetView *tweetView;

@end
