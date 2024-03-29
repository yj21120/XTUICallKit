//
//  TUICallingAudioFunctionView.m
//  TUICalling
//
//  Created by noah on 2022/5/16.
//  Copyright © 2022 Tencent. All rights reserved
//

#import "TUICallingAudioFunctionView.h"
#import "TUICallingAction.h"
#import "Masonry.h"
#import "CustomButton.h"
#import <Lottie/Lottie-Swift.h>
#import <XTUICallKit/XTUICallKit-Swift.h>
@interface TUICallingAudioFunctionView ()

@property (nonatomic, strong) CustomButton *muteBtn;
@property (nonatomic, strong) CustomButton *hangupBtn;
@property (nonatomic, strong) CustomButton1 *hangupBtn1;

@property (nonatomic, strong) TUICallingControlButton *micBtn;
@property (nonatomic, strong) TUICallingControlButton *handsfreeBtn;
@property (nonatomic, strong) TUICallingControlButton *rechargeBtn;
@property (nonatomic, strong) UIButton *giftBtn;
@property (nonatomic,strong) AnimationView *aniView;

@end

@implementation TUICallingAudioFunctionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        [self addSubview:self.muteBtn];
        [self addSubview:self.hangupBtn];
//        [self addSubview:self.handsfreeBtn];
        [self makeConstraints];
    }
    return self;
}
- (void)updateBeginStatus{
  [self.muteBtn removeFromSuperview];
  [self.hangupBtn removeFromSuperview];
  [self addSubview:self.hangupBtn1];
  [self addSubview:self.micBtn];
  [self addSubview:self.handsfreeBtn];
  [self addSubview:self.rechargeBtn];
  [self addSubview:self.giftBtn];
  [self addSubview:self.aniView];
  [self.hangupBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(16);
    make.top.mas_equalTo(10);
    make.width.mas_equalTo(100);
    make.height.mas_equalTo(40);
  }];
  [self.micBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(16);
    make.bottom.mas_equalTo(0);
    make.width.mas_equalTo(40);
    make.height.mas_equalTo(60);
  }];
  [self.handsfreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(self.micBtn.mas_right).mas_offset(20);
    make.top.width.height.mas_equalTo(self.micBtn);
  }];
  [self.rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.width.height.mas_equalTo(self.micBtn);
    make.right.mas_equalTo(self.giftBtn.mas_left).mas_offset(-20);
  }];
  [self.giftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.mas_equalTo(-22);
    make.bottom.mas_equalTo(self.micBtn);
    make.width.height.mas_equalTo(50);
  }];
  [self.aniView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(self.giftBtn);
    make.bottom.mas_equalTo(self.giftBtn.mas_top).mas_offset(-10);
    make.width.mas_equalTo(40);
    make.height.mas_equalTo(73);
  }];
}
- (void)updateChargeStatus:(BOOL)normal{
  [self.rechargeBtn updateImage:[UIImage imageNamed:normal ? @"func_recharge_n" : @"func_recharge"]];
}
- (void)makeConstraints {
  
//    [self.muteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.hangupBtn.mas_left).mas_offset(-10);
//        make.centerY.equalTo(self.hangupBtn);
//        make.size.equalTo(@(kHandleBtnSize));
//    }];
    [self.hangupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.mas_equalTo(0);
        make.width.mas_equalTo(100);
    }];
//    [self.handsfreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.hangupBtn.mas_right).offset(5);
//        make.centerY.equalTo(self.hangupBtn);
//        make.size.equalTo(@(kControlBtnSize));
//    }];
}

#pragma mark - TUICallingFunctionViewProtocol

- (void)updateTextColor:(UIColor *)textColor {
//    [self.muteBtn updateTitleColor:textColor];
//    [self.handsfreeBtn updateTitleColor:textColor];
//    [self.hangupBtn updateTitleColor:textColor];
}

- (void)updateHandsFreeStatus {
    NSString *imageName = @"func_handsfree_open";
    if ([TUICallingStatusManager shareInstance].audioPlaybackDevice == TUIAudioPlaybackDeviceEarpiece) {
        imageName = @"func_handsfree_close";
    }
    [self.handsfreeBtn updateImage:[TUICallingCommon getBundleImageWithName:imageName]];
}

- (void)updateMicMuteStatus {
  BOOL isMute = TUICallingStatusManager.shareInstance.isMicMute;
    NSString *imageName = isMute ? @"mic_off" : @"mic_on";
  [self.muteBtn updateImage:[TUICallingCommon getBundleImageWithName:imageName]];
  [self.muteBtn updateTitle:isMute ? @"麦克风开启" : @"麦克风关闭"];
  [self.micBtn updateImage:isMute ? [UIImage imageNamed:@"func_mic_open"] : [UIImage imageNamed:@"func_mic_close"]];
}

#pragma mark - Action Event

- (void)muteTouchEvent:(UIButton *)sender {
    if ([TUICallingStatusManager shareInstance].isMicMute) {
        [TUICallingAction closeMicrophone];
    } else {
        [TUICallingAction openMicrophone];
    }
}

- (void)hangupTouchEvent:(UIButton *)sender {
    [TUICallingAction hangup];
}

- (void)hangsfreeTouchEvent:(UIButton *)sender {
    [TUICallingAction selectAudioPlaybackDevice];
}
- (void)giftEvent{
  [NSNotificationCenter.defaultCenter postNotificationName:@"flutterCallBack" object:@{@"func":@"gift",@"param":@(true)}];
}

#pragma mark - Lazy

- (CustomButton *)muteBtn {
    if (!_muteBtn) {
        
      _muteBtn = [[CustomButton alloc] initWithImage:@"mic_off" title:@"麦克风关闭"];
      [_muteBtn addTarget:self action:@selector(muteTouchEvent:) forControlEvents:(UIControlEventTouchUpInside)];
//        _muteBtn = [TUICallingControlButton createWithFrame:CGRectZero
//                                                  titleText:TUICallingLocalize(@"Demo.TRTC.Calling.mic")
//                                               buttonAction:^(UIButton * _Nonnull sender) {
//            [weakSelf muteTouchEvent:sender];
//        } imageSize:kBtnSmallSize];
//        [_muteBtn updateImage:[TUICallingCommon getBundleImageWithName:@"ic_mute"]];
    }
    return _muteBtn;
}
- (CustomButton1 *)hangupBtn1 {
    if (!_hangupBtn1) {
        
      _hangupBtn1 = [[CustomButton1 alloc] initWithImage:@"ic_hangup" title:@"挂断" color:UIColor.whiteColor];
      _hangupBtn1.backgroundColor = [UIColor t_colorWithHexString:@"#F23D78"];
      _hangupBtn1.layer.cornerRadius = 20;
      _hangupBtn1.clipsToBounds = true;
      [_hangupBtn1 addTarget:self action:@selector(hangupTouchEvent:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _hangupBtn1;
}
- (CustomButton *)hangupBtn {
    if (!_hangupBtn) {
        
      _hangupBtn = [[CustomButton alloc] initWithImage:@"ic_hangup" title:@"取消" color:UIColor.whiteColor bgColor:[UIColor t_colorWithHexString:@"#F23D78"]];
      [_hangupBtn addTarget:self action:@selector(hangupTouchEvent:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _hangupBtn;
}
- (TUICallingControlButton *)micBtn{
  if (!_micBtn){
    __weak typeof(self) weakSelf = self;
    _micBtn = [TUICallingControlButton createWithFrame:CGRectZero titleText:@"麦克风" buttonAction:^(UIButton * _Nonnull sender) {
      [weakSelf muteTouchEvent:sender];
    } imageSize:CGSizeMake(36, 36)];
    [_micBtn updateImage:[UIImage imageNamed:@"func_mic_open"]];
    [_micBtn updateTitleColor:[UIColor.whiteColor colorWithAlphaComponent:0.4]];
    [_micBtn updateFont:[UIFont systemFontOfSize:9]];
  }
  return _micBtn;
}
- (TUICallingControlButton *)handsfreeBtn {
    if (!_handsfreeBtn) {
        __weak typeof(self) weakSelf = self;
        _handsfreeBtn = [TUICallingControlButton createWithFrame:CGRectZero
                                                       titleText:@"扬声器"
                                                    buttonAction:^(UIButton * _Nonnull sender) {
            [weakSelf hangsfreeTouchEvent:sender];
        } imageSize:CGSizeMake(36, 36)];
        [_handsfreeBtn updateImage:[TUICallingCommon getBundleImageWithName:@"func_handsfree_open"]];
        [_handsfreeBtn updateTitleColor:[UIColor t_colorWithHexString:@"#FFFFFF"]];
      [_handsfreeBtn updateFont:[UIFont systemFontOfSize:9]];
    }
    return _handsfreeBtn;
}
- (TUICallingControlButton *)rechargeBtn{
  if (!_rechargeBtn){
    __weak typeof(self) weakSelf = self;
    _rechargeBtn = [TUICallingControlButton createWithFrame:CGRectZero titleText:@"充值" buttonAction:^(UIButton * _Nonnull sender) {
      [NSNotificationCenter.defaultCenter postNotificationName:@"flutterCallBack" object:@{@"func":@"recharge",@"param":@(true)}];
    } imageSize:CGSizeMake(36, 36)];
    [_rechargeBtn updateImage:[UIImage imageNamed:@"func_recharge_n"]];
    [_rechargeBtn updateTitleColor:[UIColor.whiteColor colorWithAlphaComponent:0.4]];
    [_rechargeBtn updateFont:[UIFont systemFontOfSize:9]];
  }
  return _rechargeBtn;
}
- (UIButton *)giftBtn{
  if (!_giftBtn){
    __weak typeof(self) weakSelf = self;
    _giftBtn = [UIButton new];
    [_giftBtn setBackgroundImage:[UIImage imageNamed:@"func_gift"] forState:(UIControlStateNormal)];
    [_giftBtn addTarget:self action:@selector(giftEvent) forControlEvents:(UIControlEventTouchUpInside)];

  }
  return _giftBtn;
}
- (AnimationView *)aniView{
  if (!_aniView){
    _aniView = [LottieManager.shared loadLocalAnimationViewWithName:@"飘爱心"];
  }
  return _aniView;
}
@end
