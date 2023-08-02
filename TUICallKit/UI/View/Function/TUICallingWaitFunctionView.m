//
//  TUICallingWaitFunctionView.m
//  TUICalling
//
//  Created by noah on 2021/8/30.
//  Copyright © 2021 Tencent. All rights reserved
//

#import "TUICallingWaitFunctionView.h"
#import "Masonry.h"
#import "CustomButton.h"
@interface TUICallingWaitFunctionView ()

@property (nonatomic, strong) CustomButton *rejectBtn;
@property (nonatomic, strong) CustomButton *acceptBtn;

@end

@implementation TUICallingWaitFunctionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.rejectBtn];
        [self addSubview:self.acceptBtn];
        [self makeConstraints];
    }
    return self;
}

- (void)makeConstraints {
    
    [self.rejectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
      make.bottom.mas_equalTo(0);
      make.width.mas_equalTo(100);
      make.centerX.mas_equalTo(-kWidth/4);
    }];
    [self.acceptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
      make.bottom.mas_equalTo(self.rejectBtn);
      make.width.mas_equalTo(self.rejectBtn);
      make.centerX.mas_equalTo(kWidth/4);
    }];
  
}

#pragma mark - TUICallingFunctionViewProtocol

- (void)updateTextColor:(UIColor *)textColor {
//    [self.rejectBtn updateTitleColor:textColor];
//    [self.acceptBtn updateTitleColor:textColor];
}

#pragma mark - Event Action

- (void)rejectTouchEvent:(UIButton *)sender {
//    [TUICallingAction reject];
  if (TUICallingStatusManager.shareInstance.delegate1 && [TUICallingStatusManager.shareInstance.delegate1 respondsToSelector:@selector(answerCall:)]){
    [TUICallingStatusManager.shareInstance.delegate1 answerCall:false];
  }
}

- (void)acceptTouchEvent:(UIButton *)sender {
//    [TUICallingAction accept];
  if (TUICallingStatusManager.shareInstance.delegate1 && [TUICallingStatusManager.shareInstance.delegate1 respondsToSelector:@selector(answerCall:)]){
    [TUICallingStatusManager.shareInstance.delegate1 answerCall:true];
  }
}
- (void)updateChargeStatus:(BOOL)normal{
  
}
#pragma mark - Lazy

- (CustomButton *)acceptBtn {
    if (!_acceptBtn) {
      _acceptBtn = [[CustomButton alloc] initWithImage:@"ic_accept" title:@"接听" color:UIColor.whiteColor bgColor:[UIColor t_colorWithHexString:@"#36E07A"]];
      [_acceptBtn addTarget:self action:@selector(acceptTouchEvent:) forControlEvents:(UIControlEventTouchUpInside)];    }
    return _acceptBtn;
}

- (CustomButton *)rejectBtn {
    if (!_rejectBtn) {
        
      _rejectBtn = [[CustomButton alloc] initWithImage:@"ic_hangup" title:@"挂断" color:UIColor.whiteColor bgColor:[UIColor t_colorWithHexString:@"#F23D78"]];
      [_rejectBtn addTarget:self action:@selector(rejectTouchEvent:) forControlEvents:(UIControlEventTouchUpInside)];

    }
    
    return _rejectBtn;
}

@end
