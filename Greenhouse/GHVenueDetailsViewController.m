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
//  GHVenueDetailsViewController.m
//  Greenhouse
//
//  Created by Roy Clarkson on 10/4/10.
//

#import "GHVenueDetailsViewController.h"
#import "GHVenue.h"


@implementation GHVenueDetailsViewController

@synthesize venue;
@synthesize labelName;
@synthesize labelLocationHint;
@synthesize labelAddress;
@synthesize buttonDirections;

- (IBAction)actionGetDirections:(id)sender
{
	NSString *encodedAddress = [venue.postalAddress stringByURLEncoding];
	NSString *urlString = [[NSString alloc] initWithFormat:@"http://maps.google.com/maps?q=%@", encodedAddress];
	NSURL *url = [NSURL URLWithString:urlString];	
	[[UIApplication sharedApplication] openURL:url];
}


#pragma mark -
#pragma mark DataViewController methods

- (void)refreshView
{
	if (venue)
	{
		labelName.text = venue.name;
		labelLocationHint.text = venue.locationHint;
		labelAddress.text = venue.postalAddress;
	}
}


#pragma mark -
#pragma mark UIViewController methods

- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	self.title = @"Venue";
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
	
	self.venue = nil;
	self.labelName = nil;
	self.labelLocationHint = nil;
	self.labelAddress = nil;
	self.buttonDirections = nil;
}

@end
