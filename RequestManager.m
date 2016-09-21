//
//  RequestManager.m
//  WoofnRoof
//
//  Created by iOS Developer on 14/09/16.
//  Copyright © 2016 Prabh Kiran Kaur. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager

+(void)getFromServer:(NSString*)api parameters:(NSMutableDictionary*)parameters methodType:(NSString*)type completionHandler:(RequestManagerHandler)handler
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,api]];
    
//    NSArray *temp = [[NSArray alloc] init];
//    temp = [parameters allKeys];
//    NSString *paramterString=@"";
//    NSEnumerator *e = [temp objectEnumerator];
//    id object;
//    while (object = [e nextObject]) {
//        paramterString=[[[[paramterString stringByAppendingString:object] stringByAppendingString:@"="]stringByAppendingString:[parameters objectForKey:object]]stringByAppendingString:@"&"];
//    }
//    paramterString = [paramterString substringToIndex:paramterString.length-1];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:type];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSData* json = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    [urlRequest setHTTPBody:json];
    
//    [urlRequest setHTTPBody:[paramterString dataUsingEncoding:NSUTF8StringEncoding]];
    
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
