//
//  I18n.m
//
//  Created by Bart
//

#import "I18n.h"

@implementation I18n

+ (NSString*) t:(NSString*)key
{
    return NSLocalizedString(key, nil);
}

+ (NSString*) t:(NSString*)key count:(long long)count
{
    NSString *realKey = key;
    
    if (count == 1)
    {
        realKey = [NSString stringWithFormat:@"%@%@", key, @"-one"];
    }
    else
    {
        realKey = [NSString stringWithFormat:@"%@%@", key, @"-other"];
    }
    
    return NSLocalizedString(realKey, nil);
}

+ (NSString*) t:(NSString*)key dict:(NSDictionary*)dict
{
    return [I18n _t:key count:0 dict:dict usePluralDetermination:NO];
}

+ (NSString*) t:(NSString*)key count:(long long)count dict:(NSDictionary*)dict
{
    return [I18n _t:key count:count dict:dict usePluralDetermination:YES];
}

+ (NSString*) _t:(NSString*)key count:(long long)count dict:(NSDictionary*)dict usePluralDetermination:(BOOL)usePluralDetermination
{
    NSString *value = (usePluralDetermination == YES) ? [I18n t:key count:count] : [I18n t:key];
    
    NSMutableString *interpolatedValue = [[NSMutableString alloc] initWithString:value];
    
    for (id dictKey in dict)
    {
        id val = [dict objectForKey:dictKey];
        
        NSString *finalVal = @"";
        if (val != nil)
        {
            if ([val isKindOfClass:[NSString class]])
                finalVal = val;
            else
                finalVal = @"{{???}}";
        }
        
        NSString *variable = [NSString stringWithFormat:@"{{%@}}", dictKey];
        int len = [interpolatedValue length];
        NSRange range = {0, len};
        [interpolatedValue replaceOccurrencesOfString:variable withString:finalVal options:NSCaseInsensitiveSearch range:range];
    }
    
    return interpolatedValue;
}

@end
