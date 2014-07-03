//
//  HexColorToUIColor.h
//  schudio
//
//  Created by ignis2 on 07/01/14.
//  Copyright (c) 2014 ignis2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HexColorToUIColor : NSObject
- (UIImage *)imageWithColor:(UIColor *)color;
- (UIColor *)colorFromHexString:(NSString *)hexString alpha:(float)alpha;
@end
