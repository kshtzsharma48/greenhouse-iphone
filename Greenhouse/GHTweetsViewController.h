//
//  Copyright 2010-2012 the original author or authors.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//
//  GHTweetsViewController.h
//  Greenhouse
//
//  Created by Roy Clarkson on 7/26/10.
//

#import <UIKit/UIKit.h>
#import "GHTwitterController.h"
#import "GHTwitterProfileImageDownloader.h"
#import "GHPullRefreshTableViewController.h"
#import "GHTweetViewController.h"


@class GHTweetDetailsViewController;


@interface GHTweetsViewController : GHPullRefreshTableViewController <UITableViewDelegate, UITableViewDataSource, GHTwitterControllerDelegate, GHTwitterProfileImageDownloaderDelegate>
{ 
	
@private
	BOOL _isLoading;
	NSUInteger _currentPage;
	BOOL _isLastPage;
}

@property (nonatomic, strong) NSMutableArray *arrayTweets;
@property (nonatomic, strong) NSURL *tweetUrl;
@property (nonatomic, strong) NSURL *retweetUrl;
@property (nonatomic, strong) GHTweetViewController *tweetViewController;
@property (nonatomic, strong) GHTweetDetailsViewController *tweetDetailsViewController;
@property (nonatomic, assign) BOOL isLoading;

- (void)profileImageDidLoad:(NSIndexPath *)indexPath;

@end
