//
//  Utils.h
//
//  Created by Bart
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (NSString*) formatDate:(NSDate*)date format:(NSString*)format;
+ (NSString*) relativeDateTimeString:(NSDate*)time now:(NSDate*)now;

@end
