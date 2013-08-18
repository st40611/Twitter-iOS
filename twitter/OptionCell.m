//
//  OptionCell.m
//  twitter
//
//  Created by Ben Lin on 8/17/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "OptionCell.h"
#import "TweetView.h"

@implementation OptionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
