//
//  ZBTime.m
//  ZBShopManager
//
//  Created by teacher on 15-11-20.
//  Copyright (c) 2015年 teacher. All rights reserved.
//

#import "ZBTime.h"

@implementation ZBTime

+ (NSString *)intervalSinceNow: (NSString *) theDate
{
    NSArray *timeArray=[theDate componentsSeparatedByString:@"."];
    theDate=[timeArray objectAtIndex:0];
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate date];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=now-late;
    NSLog(@"%ld",(long)cha);
    
    if (cha<60)
    {
        timeString=[NSString stringWithFormat:@"刚刚"];
    }
    if (cha>=60 && cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分钟之前", timeString];
    }
    if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f",cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时之前", timeString];
    }
     if (cha/86400>1)
    {
        timeString = [NSString stringWithFormat:@"%f",cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天之前", timeString];
        
    }
 
    
    return timeString;
}

@end
