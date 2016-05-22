//
//  SwitchView.h
//  Configurable Demo
//
//  Created by sxc on 5/22/16.
//  Copyright © 2016 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

/* 栏目切换时，选中回调实用类,做相应界面切换操作* */
typedef void (^SwtichBlock)(NSUInteger selectIndex);

@interface SwitchView : UIView

@property (nonatomic,readonly) NSUInteger selectedIndex; //当前选中栏目索引，0...(栏目总数-1)
@property (nonatomic) float channelWidth; //单个栏目的显示宽度
@property (nonatomic, strong) NSArray<NSString *> *switchChannels; //需要切换的栏目
@property (nonatomic, copy) SwtichBlock doSelectBlock; //切换栏目的回调

@end
