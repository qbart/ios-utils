//
//  I18n.h
//
//  Created by Bart
//

#import <Foundation/Foundation.h>

@interface I18n : NSObject

+ (NSString*) t:(NSString*)key;
+ (NSString*) t:(NSString*)key count:(long long)count;
+ (NSString*) t:(NSString*)key dict:(NSDictionary*)dict;
+ (NSString*) t:(NSString*)key count:(long long)count dict:(NSDictionary*)dict;

@end