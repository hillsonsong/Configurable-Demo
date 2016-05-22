//
//  ViewController.m
//  Configurable Demo
//
//  Created by ; on 5/22/16.
//  Copyright © 2016 Tencent. All rights reserved.
//

#import "ViewController.h"
#import "SwitchView.h"

@interface ViewController ()

@property (nonatomic,strong)UIView *a;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    SwitchView *_switch = [[SwitchView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 50.f)];
    _switch.channelWidth = 100;
    _switch.switchChannels = @[@"aa",@"bb",@"cc",@"dd",@"ee"];
    _switch.doSelectBlock = ^(NSUInteger index) {
        NSLog(@"select index:%lu",(unsigned long)index);
    };
    [self.view addSubview:_switch];
    _a = _switch;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)a:(id)sender {
    _a.frame = CGRectMake(50, 50, 200, 50.f);
}

@end
