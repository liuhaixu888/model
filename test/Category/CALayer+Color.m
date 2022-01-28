//
//  CALayer+Color.m
//  test
//
//  Created by tdem on 2022/1/28.
//  Copyright © 2022 tdem. All rights reserved.
//

#import "CALayer+Color.h"

@implementation CALayer (Color)

- (void)setBorderUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}
@end
