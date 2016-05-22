//
//  BaseTableViewCell.h
//  Configurable Demo
//
//  Created by sxc on 5/22/16.
//  Copyright © 2016 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

/**
 *  返回cell示例
 *
 *  @return 实例对象
 */
+ (instancetype)cellFromNib;

/**
 *  根据内容计算cell高度
 *
 *  @param cellInfo cell的填充内容
 *
 *  @return cell适配高度
 */
+ (CGFloat)cellHeightForInfo:(id)cellInfo;

/**
 *  根据内容绘制cell
 *
 *  @param cellInfo cell的填充内容
 */
- (void)setCellInfo:(id)cellInfo;


@end
