//
//  Tweet.m
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (NSString *)text {
    return [self.data valueOrNilForKeyPath:@"text"];
}

- (NSString *)id_str {
    return [self.data valueOrNilForKeyPath:@"id_str"];
}

- (NSString *)screenname {
    return [self.data valueOrNilForKeyPath:@"user.screen_name"];
}

- (NSString *)name {
    return [self.data valueOrNilForKeyPath:@"user.name"];
}

- (NSString *) image {
    return [self.data valueOrNilForKeyPath:@"user.profile_image_url"];
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:params];
        tweet.type = @"tweet";
        [tweets addObject:tweet];
    }
    return tweets;
}

@end
