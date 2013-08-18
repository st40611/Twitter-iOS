//
//  TimelineVC.m
//  twitter
//
//  Created by Timothy Lee on 8/4/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TimelineVC.h"
#import "TweetCell.h"
#import "OptionCell.h"
#import "TweetView.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface TimelineVC ()

@property (nonatomic, strong) NSMutableArray *tweets;
@property (nonatomic, strong) User *currentUser;
@property (nonatomic, assign) NSInteger pos;

- (void)onSignOutButton;
- (void)compose;
- (void)reload;
- (void)reply;
- (void)favorite;
- (void)retweet;
- (void)getUserData;

@end

@implementation TimelineVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self reload];
        [self getUserData];
        self.title = @"Twitter";
        self.pos = -1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *tweetCellNib = [UINib nibWithNibName:@"TweetCell" bundle:nil];
    [self.tableView registerNib:tweetCellNib forCellReuseIdentifier:@"TweetCell"];
    
    UINib *optionCellNib = [UINib nibWithNibName:@"OptionCell" bundle:nil];
    [self.tableView registerNib:optionCellNib forCellReuseIdentifier:@"OptionCell"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onSignOutButton)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Compose" style:UIBarButtonItemStylePlain target:self action:@selector(compose)];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Tweet *tweet = self.tweets[indexPath.row];
    if ([tweet.type isEqualToString:@"option"]) {
        static NSString *CellIdentifier = @"OptionCell";
        OptionCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        UIButton *reply = [self getButton:@"Reply"];
        [reply addTarget:self action:@selector(reply) forControlEvents:UIControlEventTouchUpInside];
        reply.frame = CGRectMake(0, 0, 100, cell.contentView.frame.size.height);
        [cell.contentView addSubview:reply];
        
        UIButton *fav = [self getButton:@"Favorite"];
        [fav addTarget:self action:@selector(favorite) forControlEvents:UIControlEventTouchUpInside];
        fav.frame = CGRectMake(100, 0, 100, cell.contentView.frame.size.height);
        [cell.contentView addSubview:fav];
        
        UIButton *retweet = [self getButton:@"Retweet"];
        [retweet addTarget:self action:@selector(retweet) forControlEvents:UIControlEventTouchUpInside];
        retweet.frame = CGRectMake(200, 0, 100, cell.contentView.frame.size.height);
        [cell.contentView addSubview:retweet];
        
        cell.originalTweet = self.tweets[indexPath.row - 1];
        NSLog(@"%@", cell.originalTweet.name);
        return cell;
        } else {
            static NSString *CellIdentifier = @"TweetCell";
            TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            cell.message.text = tweet.text;
            cell.name.text = tweet.name;
            cell.screenname.text = tweet.screenname;
            [cell.image setImageWithURL:[NSURL URLWithString:tweet.image]
                placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
            return cell;
    }
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Tweet *tweet = self.tweets[indexPath.row];
    NSString *message = tweet.text;
    return 50;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.pos) {
        return ;
    }
    
    if (self.pos != - 1) {
        [self deleteOptionCell];
    }
    if (indexPath.row < self.pos || self.pos == -1) {
        self.pos = indexPath.row + 1;
    } else {
        self.pos = indexPath.row;
    }
    Tweet *tweet = [[Tweet alloc] init];
    tweet.type = @"option";
    [self.tweets insertObject:tweet atIndex:self.pos];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.pos inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

#pragma mark - Private methods

- (void)onSignOutButton {
    [User setCurrentUser:nil];
}

- (void)deleteOptionCell {
    if (self.pos != - 1) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.pos inSection:0]];
        if ([cell.contentView subviews]){
            for (UIView *subview in [cell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
        [self.tweets removeObjectAtIndex:self.pos];
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.pos inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (UIButton *) getButton:(NSString *) title {
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize: 14];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return button;
}

- (void)reply {
    Tweet *tweet = self.tweets[self.pos - 1];
    
    self.tweetView = [[TweetView alloc] initWithNibName:@"TweetView" bundle:nil];
    NSString *prefix = [[@"@" stringByAppendingString:tweet.screenname] stringByAppendingString:@" "];
    self.tweetView.replyId = tweet.id_str;
    self.tweetView.message = prefix;
    [self pushTweetView];
}

- (void)compose {
    self.tweetView = [[TweetView alloc] initWithNibName:@"TweetView" bundle:nil];
    self.tweetView.replyId = nil;
    self.tweetView.message = nil;
    [self pushTweetView];
}

- (void) pushTweetView {
    [self deleteOptionCell];
    self.tweetView.currentUser = self.currentUser;
    self.tweetView.name.text = self.currentUser.name;
    self.tweetView.screenname.text = self.currentUser.screenname;
    self.pos = -1;
    [self.navigationController pushViewController:self.tweetView animated:YES];
}

- (void)getUserData {
    [[TwitterClient instance] currentUserWithSuccess:^(AFHTTPRequestOperation *operation, id response) {
        self.currentUser = [[User alloc] initWithDictionary:response];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Do nothing
    }];
}

- (void)favorite {
    Tweet *tweet = self.tweets[self.pos -1];
    [[TwitterClient instance] favorite:tweet.id_str success:^(AFHTTPRequestOperation *operation, id response) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Favorite'd"
                                                          message:@"You have fav'd this tweet!"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
    }];
}

- (void)retweet {
    Tweet *tweet = self.tweets[self.pos -1];
    [[TwitterClient instance] retweet:tweet.id_str success:^(AFHTTPRequestOperation *operation, id response) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Retweet"
                                                          message:@"You have retweet'd this tweet!"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
    }];
}

- (void)reload {
    [[TwitterClient instance] homeTimelineWithCount:20 sinceId:0 maxId:0 success:^(AFHTTPRequestOperation *operation, id response) {
        self.tweets = [Tweet tweetsWithArray:response];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Do nothing
    }];
}

@end
