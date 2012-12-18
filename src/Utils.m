//
//  Utils.m
//
//  Created by Bart
//

#import "Utils.h"
#import "I18n.h"

static const long long SECOND_IN_MILLIS = 1000LL;
static const long long MINUTE_IN_MILLIS = SECOND_IN_MILLIS * 60LL;
static const long long HOUR_IN_MILLIS = MINUTE_IN_MILLIS * 60LL;
static const long long DAY_IN_MILLIS = HOUR_IN_MILLIS * 24LL;
static const long long WEEK_IN_MILLIS = DAY_IN_MILLIS * 7LL;
static const long long minResolution = MINUTE_IN_MILLIS; //set minResolution to specify time accuracy (in secs, minutes, ...)

@implementation Utils

+ (NSString*) formatDate:(NSDate*)date format:(NSString*)format
{
    if (date == nil)
        return @"";
    
    NSDateFormatter *formatter;
    formatter = [[NSDateFormatter alloc] init];
    
    if (format != nil)
        [formatter setDateFormat:format];
    else
        [formatter setDateFormat:@"dd-MM-yyyy"];
    
    return [formatter stringFromDate:date];
}

// similar to Android version
+ (NSString*) relativeDateTimeString:(NSDate*)time now:(NSDate*)now
{
    long long dNowMillis = [now timeIntervalSince1970] * SECOND_IN_MILLIS;
    long long dTimeMillis = [time timeIntervalSince1970] * SECOND_IN_MILLIS;
    double diff = dNowMillis - dTimeMillis;
    
    BOOL past = (diff >= 0);
    long long duration = fabs(diff);
    long long count;
    NSString* resId;

    if (duration < MINUTE_IN_MILLIS && minResolution < MINUTE_IN_MILLIS) {
        count = duration / SECOND_IN_MILLIS;
        if (past) {
            resId = @"date.num_seconds_ago";
        } else {
            resId = @"date.in_num_seconds";
        }
    } else if (duration < HOUR_IN_MILLIS && minResolution < HOUR_IN_MILLIS) {
        count = duration / MINUTE_IN_MILLIS;
        if (past) {
            resId = @"date.num_minutes_ago";
        } else {
            resId = @"date.in_num_minutes";
        }
    } else if (duration < DAY_IN_MILLIS && minResolution < DAY_IN_MILLIS) {
        count = duration / HOUR_IN_MILLIS;
        if (past) {
            resId = @"date.num_hours_ago";
        } else {
            resId = @"date.in_num_hours";
        }
    } else if (duration < WEEK_IN_MILLIS && minResolution < WEEK_IN_MILLIS) {
        count = duration / DAY_IN_MILLIS;
        if (past) {
            resId = @"date.num_days_ago";
        } else {
            resId = @"date.in_num_days";
        }
    } else {
        return [Utils formatDate:time format:@"dd MMM yyyy"]; //date format can be customized
    }

    NSString *countStringified = [NSString stringWithFormat:@"%lld", count];
    return [I18n t:resId count:count dict:@{@"count": countStringified}];
}

@end
