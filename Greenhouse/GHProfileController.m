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
//  GHProfileController.m
//  Greenhouse
//
//  Created by Roy Clarkson on 9/7/10.
//

#import "GHProfileController.h"
#import "GHCoreDataManager.h"

@implementation GHProfileController


#pragma mark -
#pragma mark Instance methods

- (void)fetchProfileWithDelegate:(id<GHProfileControllerDelegate>)delegate
{
    Profile *profile = [self fetchProfileFromDataStore];
    if (profile)
    {
        [delegate fetchProfileDidFinishWithResults:profile];
    }
    else
    {
        [self sendRequestForProfileWithDelegate:delegate];
    }
}

- (Profile *)fetchProfileFromDataStore
{
    NSManagedObjectContext *context = [[GHCoreDataManager sharedInstance] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Profile" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    Profile *profile = nil;
    if (!error && fetchedObjects.count > 0)
    {
        profile = [fetchedObjects objectAtIndex:0];
    }
    
    return profile;
}

- (void)sendRequestForProfileWithDelegate:(id<GHProfileControllerDelegate>)delegate
{
	NSURL *url = [[NSURL alloc] initWithString:MEMBER_PROFILE_URL];
    NSMutableURLRequest *request = [[GHAuthorizedRequest alloc] initWithURL:url];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	DLog(@"%@", request);
	
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         if (data.length > 0 && error == nil)
         {
             DLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
             NSError *error;
             NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
             
             Profile *profile = nil;
             if (!error)
             {
                 DLog(@"%@", dictionary);
                 [self deleteProfile];
                 [self storeProfileWithJson:dictionary];
                 profile = [self fetchProfileFromDataStore];
             }
             [delegate fetchProfileDidFinishWithResults:profile];
         }
         else
         {
             [delegate fetchProfileDidFailWithError:error];
         }
     }];
}

- (void)storeProfileWithJson:(NSDictionary *)dictionary
{
    DLog(@"");
    NSManagedObjectContext *context = [[GHCoreDataManager sharedInstance] managedObjectContext];
    Profile *profile = [NSEntityDescription
                        insertNewObjectForEntityForName:@"Profile"
                        inManagedObjectContext:context];
    profile.accountId = [dictionary objectForKey:@"accountId"];
    profile.displayName = [dictionary stringByReplacingPercentEscapesForKey:@"displayName" usingEncoding:NSUTF8StringEncoding];
    profile.imageUrl = [dictionary objectForKey:@"pictureUrl"];
    NSError *error;
    [context save:&error];
    if (error)
    {
        DLog(@"%@", [error localizedDescription]);
    }
}

- (void)deleteProfile
{
    DLog(@"");
    NSManagedObjectContext *context = [[GHCoreDataManager sharedInstance] managedObjectContext];
    NSManagedObject *object = [self fetchProfileFromDataStore];
    if (object)
    {
        [context deleteObject:object];
        NSError *error;
        [context save:&error];
        if (error)
        {
            DLog(@"%@", [error localizedDescription]);
        }
    }
}

@end
