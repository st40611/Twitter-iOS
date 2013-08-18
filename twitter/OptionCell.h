//
//  OptionCell.h
//  twitter
//
//  Created by Ben Lin on 8/17/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TweetView;

@interface OptionCell : UITableViewCell

@property (nonatomic, strong) Tweet *originalTweet;
@property (nonatomic, strong) TweetView *tweetView;

@end
