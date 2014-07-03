//
//  HexColorToUIColor.m
//  schudio
//
//  Created by ignis2 on 07/01/14.
//  Copyright (c) 2014 ignis2. All rights reserved.
//

#import "HexColorToUIColor.h"

@implementation HexColorToUIColor
- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
- (UIColor *)colorFromHexString:(NSString *)hexString alpha:(float)alpha
{
    // Hex strings may optionally start with a #
    NSString *strippedString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:strippedString];
    unsigned int rgbValue = 0;
    [scanner scanHexInt:&rgbValue];
    
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:alpha];
}
@end
