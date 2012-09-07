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
//  GHEvent.h
//  Greenhouse
//
//  Created by Roy Clarkson on 7/8/10.
//

#import <Foundation/Foundation.h>

@interface GHEvent : NSObject

@property (nonatomic, copy) NSString *eventId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSDate *endTime;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *hashtag;
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, strong) NSArray *venues;

- (id)initWithEventId:(NSString *)eventId title:(NSString *)title startTime:(NSDate *)startTime entTime:(NSDate *)endTime location:(NSString *)location description:(NSString *)description name:(NSString *)name hashtag:(NSString *)hashtag groupName:(NSString *)groupName venues:(NSArray *)venues;

@end
