//
//  BMInforTableViewCell.m
//  test
//
//  Created by tdem on 2021/12/28.
//  Copyright © 2021 tdem. All rights reserved.
//

#import "BMInforTableViewCell.h"

@implementation BMInforTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

@end
