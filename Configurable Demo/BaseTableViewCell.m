//
//  BaseTableViewCell.m
//  Configurable Demo
//
//  Created by sxc on 5/22/16.
//  Copyright © 2016 Tencent. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellFromNib {
    return nil;
}

+ (CGFloat)cellHeightForInfo:(id)cellInfo {
    return 44.0;
}

- (void)setCellInfo:(id)cellInfo {
    //TODO
}
@end
