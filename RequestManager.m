//
//  RequestManager.m
//  WoofnRoof
//
//  Created by iOS Developer on 14/09/16.
//  Copyright © 2016 Prabh Kiran Kaur. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager

+(void)getFromServer:(NSString*)api parameters:(NSMutableDictionary*)parameters methodType:(NSString*)type withToken:(BOOL)present completionHandler:(RequestManagerHandler)handler
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,api]];

    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:type];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if (present) {
        NSString *str = [NSString stringWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"logged_token"]];
        [urlRequest setValue:str forHTTPHeaderField:@"Authorization"];
    }
    
    
    NSData* json = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    [urlRequest setHTTPBody:json];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           NSLog(@"Response:%@ and error :: %@\n", response, error);
                                                           if(error == nil)
                                                           {
                                                               dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                                                   NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                                   NSLog(@"Parsed");
                                                                   dispatch_async(dispatch_get_main_queue(), ^{
                                                                       if(handler != nil && responseDict != nil)
                                                                           handler(responseDict);
                                                                       NSLog(@"Parse and send");
                                                                   });
                                                               });
                                                           }
                                                           else
                                                           {
                                                               NSLog(@"Connection Error :- %@", [error description]);
                                                               
                                                           }
                                                           
                                                       }];
    [dataTask resume];
    
}
@end
