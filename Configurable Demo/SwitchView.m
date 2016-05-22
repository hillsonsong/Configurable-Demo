//
//  SwitchView.m
//  Configurable Demo
//
//  Created by sxc on 5/22/16.
//  Copyright © 2016 Tencent. All rights reserved.
//

#import "SwitchView.h"

@interface SwitchView ()

@property (nonatomic) NSUInteger selectedIndex; //当前选中栏目索引，0...(栏目总数-1)
@property (nonatomic, strong) NSMutableArray<UIButton *> *buttonsArray;
@property (nonatomic, strong) UIScrollView *scroll;

@end

@implementation SwitchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        [self addSubview:self.scroll];
        //set defaul channelWidth
        self.channelWidth = 44.f;
        //init button array
        self.buttonsArray = [NSMutableArray array];
        //add observe
        [self addObserver:self
               forKeyPath:@"frame"
                  options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
                  context:nil];
    }
    return self;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"frame"];
}

#pragma mark - get&set

- (void)setChannelWidth:(float)channelWidth {
    //illegal
    if (channelWidth <= 0) {
        return;
    }
    _channelWidth = channelWidth;
}

- (void)setSwitchChannels:(NSArray *)switchChannels {
    //illegel
    if ([_switchChannels isEqualToArray:switchChannels] || switchChannels.count == 0) {
        return;
    }
    
    //set switchChannels
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (NSString *Channel in switchChannels) { //filter non-string item
        if ([Channel isKindOfClass:[NSString class]]) {
            [tmpArray addObject:Channel];
        }
        
    }
    _switchChannels = [tmpArray copy];
    
    //reset
    for (UIButton *_btn in self.buttonsArray) {
        if (_btn.superview) {
            [_btn removeFromSuperview];
        }
    }
    
    //adjust UI
    CGFloat totalWidth = MAX(self.channelWidth*_switchChannels.count, CGRectGetWidth(self.scroll.frame));
    CGFloat height = CGRectGetHeight(self.scroll.frame);
    self.scroll.contentSize = CGSizeMake(totalWidth,height);
    
    //add new button in scroll
    for (NSString *title in _switchChannels) {
        UIButton *newBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        newBtn.frame = CGRectMake(_channelWidth*[_switchChannels indexOfObject:title], 0, _channelWidth, height);
        [newBtn setTitle:title forState:UIControlStateNormal];
        [newBtn addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [_scroll addSubview:newBtn];
        [self.buttonsArray addObject:newBtn];
    }
}

#pragma mark -

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary *)change context:(nullable void *)context
{
    if ([keyPath isEqualToString:@"frame"]) {
        //observe changed-frame
        CGRect newFrame = [change[NSKeyValueChangeNewKey] CGRectValue];
        //adjust scroll
        self.scroll.frame = CGRectMake(0, 0, CGRectGetWidth(newFrame), CGRectGetHeight(newFrame));
        CGFloat totalWidth = self.channelWidth*_switchChannels.count;
        self.scroll.contentSize = CGSizeMake(MAX(totalWidth, CGRectGetWidth(self.scroll.frame)),CGRectGetHeight(self.scroll.frame));
        //adjust scroll's buttons
        [self adjustButtonsInScroll:self.subviews withScollFrame:newFrame];
    }
}

- (void)didClickButton:(UIButton *)btn {
    NSString *title = btn.titleLabel.text;
    if ([_switchChannels containsObject:title]) {
        if (self.doSelectBlock) {
            self.doSelectBlock([_switchChannels indexOfObject:title]);
        }
    }
}

- (void)adjustButtonsInScroll:(NSArray<UIView *> *)buttons withScollFrame:(CGRect)newFrame {
    for (UIButton *btn in self.buttonsArray) {
        NSString *title = btn.titleLabel.text;
        if ([_switchChannels containsObject:title]) {
            btn.frame = CGRectMake(_channelWidth*[_switchChannels indexOfObject:title], 0, _channelWidth, CGRectGetHeight(newFrame));
        }
    }
}

@end
