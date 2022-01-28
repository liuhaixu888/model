//
//  SUPConditionView.m
//  test
//
//  Created by tdem on 2022/1/25.
//  Copyright © 2022 tdem. All rights reserved.
//

#import "SUPConditionView.h"

@implementation SUPConditionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"SUPConditionView" owner:nil options:nil]firstObject];
    }
    return self;
}


@end
