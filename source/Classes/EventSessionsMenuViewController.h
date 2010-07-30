//
//  EventSessionsMenuViewController.h
//  Greenhouse
//
//  Created by Roy Clarkson on 7/29/10.
//  Copyright 2010 VMware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"


@class EventSessionsCurrentViewController;
@class EventSessionsViewController;


@interface EventSessionsMenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{

}

@property (nonatomic, retain) Event *event;
@property (nonatomic, retain) IBOutlet UITableView *tableViewMenu;
@property (nonatomic, retain) EventSessionsCurrentViewController *sessionsCurrentViewController;
@property (nonatomic, retain) EventSessionsViewController *sessionsViewController;

@end
