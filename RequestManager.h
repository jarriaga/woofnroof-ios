//
//  RequestManager.h
//  WoofnRoof
//
//  Created by iOS Developer on 14/09/16.
//  Copyright © 2016 Prabh Kiran Kaur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface RequestManager : NSObject

typedef void (^RequestManagerHandler)(NSDictionary* responseDict);

+(void)getFromServer:(NSString*)api parameters:(NSMutableDictionary*)parameters methodType:(NSString*)type completionHandler:(RequestManagerHandler)handler;

@end
