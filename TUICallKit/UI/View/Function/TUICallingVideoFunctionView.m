//
//  TUICallingVideoFunctionView.m
//  TUICalling
//
//  Created by noah on 2022/5/16.
//  Copyright © 2022 Tencent. All rights reserved
//

#import "TUICallingVideoFunctionView.h"
#import "Masonry.h"
#import "CustomButton.h"
#import <Lottie/Lottie-Swift.h>
#import <XTUICallKit/XTUICallKit-Swift.h>
@interface TUICallingVideoFunctionView ()

@property (nonatomic, strong) TUICallingControlButton *muteBtn;
@property (nonatomic, strong) TUICallingControlButton *handsfreeBtn;
@property (nonatomic, strong) TUICallingControlButton *closeCameraBtn;
@property (nonatomic, strong) CustomButton1 *hangupBtn;
@property (nonatomic, strong) TUICallingControlButton *switchCameraBtn;
@property (nonatomic, strong) TUICallingControlButton *rechargeBtn;
@property (nonatomic, strong) UIButton *giftBtn;
@property (nonatomic,strong) AnimationView *aniView;
@property (nonatomic,assign) BOOL porn;
@end

@implementation TUICallingVideoFunctionView

@synthesize localPreView = _localPreView;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.muteBtn];
        [self addSubview:self.handsfreeBtn];
        [self addSubview:self.closeCameraBtn];
        [self addSubview:self.hangupBtn];
      [self addSubview:self.rechargeBtn];
      [self addSubview:self.giftBtn];
      [self addSubview:self.aniView];
      
        [self addSubview:self.switchCameraBtn];
        
        [self makeConstraints];
    }
    return self;
}

- (void)makeConstraints {
  [self.hangupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(16);
    make.top.mas_equalTo(10);
    make.width.mas_equalTo(100);
    make.height.mas_equalTo(40);
  }];
  [self.closeCameraBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(16);
    make.bottom.mas_equalTo(0);
    make.width.mas_equalTo(40);
    make.height.mas_equalTo(60);
  }];
  [self.muteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(self.closeCameraBtn.mas_right).mas_offset(20);
    make.top.width.height.mas_equalTo(self.closeCameraBtn);
  }];
  [self.handsfreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(self.muteBtn.mas_right).mas_offset(20);
    make.top.width.height.mas_equalTo(self.muteBtn);
  }];
  [self.switchCameraBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(self.handsfreeBtn.mas_right).mas_offset(20);
    make.top.width.height.mas_equalTo(self.muteBtn);
  }];
  [self.rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.width.height.mas_equalTo(self.muteBtn);
    make.right.mas_equalTo(self.giftBtn.mas_left).mas_offset(-20);
  }];
  [self.giftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.mas_equalTo(-22);
    make.bottom.mas_equalTo(self.muteBtn);
    make.width.height.mas_equalTo(50);
  }];
  [self.aniView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(self.giftBtn);
    make.bottom.mas_equalTo(self.giftBtn.mas_top).mas_offset(-10);
    make.width.mas_equalTo(40);
    make.height.mas_equalTo(73);
  }];
  
//
//
//    [self.switchCameraBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.hangupBtn);
//        make.left.equalTo(self.hangupBtn.mas_right).offset(20);
//        make.size.equalTo(@(CGSizeMake(36, 36)));
//    }];
}

#pragma mark - TUICallingFunctionViewProtocol
- (void)updateChargeStatus:(BOOL)normal{
  [self.rechargeBtn updateImage:[UIImage imageNamed:normal ? @"func_recharge_n" : @"func_recharge"]];
}
- (void)updateTextColor:(UIColor *)textColor {
//    [self.muteBtn updateTitleColor:textColor];
//    [self.handsfreeBtn updateTitleColor:textColor];
//    [self.closeCameraBtn updateTitleColor:textColor];
//    [self.hangupBtn updateTitleColor:textColor];
}

- (void)updateCameraOpenStatus {
    NSString *imageName = [TUICallingStatusManager shareInstance].isCloseCamera ? @"func_camera_off" : @"func_camera_on";
    [self.closeCameraBtn updateImage:[TUICallingCommon getBundleImageWithName:imageName]];
}

- (void)updateHandsFreeStatus {
    NSString *imageName = @"func_handsfree_open";
    if ([TUICallingStatusManager shareInstance].audioPlaybackDevice == TUIAudioPlaybackDeviceEarpiece) {
        imageName = @"func_handsfree_close";
    }
    [self.handsfreeBtn updateImage:[TUICallingCommon getBundleImageWithName:imageName]];
}

- (void)updateMicMuteStatus {
    NSString *imageName = [TUICallingStatusManager shareInstance].isMicMute ? @"func_mic_open" : @"func_mic_close";
    [self.muteBtn updateImage:[TUICallingCommon getBundleImageWithName:imageName]];
}

#pragma mark - Action Event

- (void)muteTouchEvent:(UIButton *)sender {
    if ([TUICallingStatusManager shareInstance].isMicMute) {
        [TUICallingAction closeMicrophone];
    } else {
        [TUICallingAction openMicrophone];
    }
}
- (void)updatePorn:(BOOL)porn{
  self.porn = porn;
  if (porn){
    [TUICallingAction closeCamera];
  }else{
    if (_localPreView){
      [TUICallingAction openCamera:[TUICallingStatusManager shareInstance].camera videoView:_localPreView];
    }
  }
}
- (void)closeCameraTouchEvent:(UIButton *)sender {
    if (![TUICallingStatusManager shareInstance].isCloseCamera) {
        [TUICallingAction closeCamera];
    } else {
      if (!self.porn){
        [TUICallingAction openCamera:[TUICallingStatusManager shareInstance].camera videoView:_localPreView];
      }
    }
}

- (void)hangsfreeTouchEvent:(UIButton *)sender {
    [TUICallingAction selectAudioPlaybackDevice];
}

- (void)hangupTouchEvent:(UIButton *)sender {
  if (TUICallingStatusManager.shareInstance.delegate1 && [TUICallingStatusManager.shareInstance.delegate1 respondsToSelector:@selector(endCall)]){
    [TUICallingStatusManager.shareInstance.delegate1 endCall];
  }
//    [TUICallingAction hangup];
}

- (void)switchCameraTouchEvent:(UIButton *)sender {
    [TUICallingAction switchCamera];
}
- (void)giftEvent{
  [NSNotificationCenter.defaultCenter postNotificationName:@"flutterCallBack" object:@{@"func":@"gift",@"param":@(true)}];
}

#pragma mark - Lazy

- (TUICallingControlButton *)muteBtn {
    if (!_muteBtn) {
        __weak typeof(self) weakSelf = self;
      _muteBtn = [TUICallingControlButton createWithFrame:CGRectZero titleText:@"麦克风" buttonAction:^(UIButton * _Nonnull sender) {
        [weakSelf muteTouchEvent:sender];
      } imageSize:CGSizeMake(36, 36)];
      [_muteBtn updateImage:[UIImage imageNamed:@"func_mic_open"]];
      [_muteBtn updateTitleColor:[UIColor.whiteColor colorWithAlphaComponent:0.4]];
      [_muteBtn updateFont:[UIFont systemFontOfSize:9]];
    }
    return _muteBtn;
}

- (TUICallingControlButton *)closeCameraBtn {
    if (!_closeCameraBtn) {
        __weak typeof(self) weakSelf = self;
      _closeCameraBtn = [TUICallingControlButton createWithFrame:CGRectZero titleText:@"镜头" buttonAction:^(UIButton * _Nonnull sender) {
        [weakSelf closeCameraTouchEvent:sender];
      } imageSize:CGSizeMake(36, 36)];
      [_closeCameraBtn updateImage:[UIImage imageNamed:@"func_camera_on"]];
      [_closeCameraBtn updateTitleColor:[UIColor.whiteColor colorWithAlphaComponent:0.4]];
      [_closeCameraBtn updateFont:[UIFont systemFontOfSize:9]];
    }
    return _closeCameraBtn;
}

- (TUICallingControlButton *)handsfreeBtn {
    if (!_handsfreeBtn) {
        __weak typeof(self) weakSelf = self;
      _handsfreeBtn = [TUICallingControlButton createWithFrame:CGRectZero titleText:@"扬声器" buttonAction:^(UIButton * _Nonnull sender) {
        [weakSelf hangsfreeTouchEvent:sender];
      } imageSize:CGSizeMake(36, 36)];
      [_handsfreeBtn updateImage:[UIImage imageNamed:@"func_handsfree_open"]];
      [_handsfreeBtn updateTitleColor:[UIColor.whiteColor colorWithAlphaComponent:0.4]];
      [_handsfreeBtn updateFont:[UIFont systemFontOfSize:9]];
    }
    return _handsfreeBtn;
}

- (CustomButton1 *)hangupBtn {
    if (!_hangupBtn) {
      _hangupBtn = [[CustomButton1 alloc] initWithImage:@"ic_hangup_small" title:@"挂断" color:UIColor.whiteColor];
      _hangupBtn.backgroundColor = [UIColor t_colorWithHexString:@"#F23D78"];
      _hangupBtn.layer.cornerRadius = 20;
      _hangupBtn.clipsToBounds = true;
      [_hangupBtn updateFont:[UIFont systemFontOfSize:12]];
      [_hangupBtn addTarget:self action:@selector(hangupTouchEvent:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _hangupBtn;
}

- (TUICallingControlButton *)switchCameraBtn {
    if (!_switchCameraBtn) {
        __weak typeof(self) weakSelf = self;
      _switchCameraBtn = [TUICallingControlButton createWithFrame:CGRectZero titleText:@"镜头" buttonAction:^(UIButton * _Nonnull sender) {
        [weakSelf switchCameraTouchEvent:sender];
      } imageSize:CGSizeMake(36, 36)];
      [_switchCameraBtn updateImage:[UIImage imageNamed:@"镜头"]];
      [_switchCameraBtn updateTitleColor:[UIColor.whiteColor colorWithAlphaComponent:0.4]];
      [_switchCameraBtn updateFont:[UIFont systemFontOfSize:9]];
    }
    return _switchCameraBtn;
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
