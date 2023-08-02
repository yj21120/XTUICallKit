//
//  TUICallingVideoInviteFunctionView.m
//  TUICalling
//
//  Created by noah on 2022/5/16.
//  Copyright © 2022 Tencent. All rights reserved
//

#import "TUICallingVideoInviteFunctionView.h"
#import "Masonry.h"
#import "CustomButton.h"
@interface TUICallingVideoInviteFunctionView ()

@property (nonatomic, strong) CustomButton *hangupBtn;
@property (nonatomic, strong) CustomButton *switchCameraBtn;

@end

@implementation TUICallingVideoInviteFunctionView
@synthesize localPreView = _localPreView;
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.hangupBtn];
//        [self addSubview:self.switchCameraBtn];
        
        [self makeConstraints];
    }
    return self;
}

- (void)makeConstraints {
    [self.hangupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.centerX.bottom.mas_equalTo(0);
    }];
//    [self.switchCameraBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.hangupBtn);
//        make.right.equalTo(self.hangupBtn.mas_left).offset(-10);
//        make.size.equalTo(@(kHandleBtnSize));
//    }];
}

#pragma mark - TUICallingFunctionViewProtocol

- (void)updateTextColor:(UIColor *)textColor {
//    [self.hangupBtn updateTitleColor:textColor];
}
- (void)updateChargeStatus:(BOOL)normal{
  
}
#pragma mark - Action Event

- (void)hangupTouchEvent:(UIButton *)sender {
    [TUICallingAction hangup];
}

- (void)switchCameraTouchEvent:(UIButton *)sender {
    if (![TUICallingStatusManager shareInstance].isCloseCamera) {
        [TUICallingAction closeCamera];
      [self.switchCameraBtn updateImage:[UIImage imageNamed:@"camera_close"]];
    } else {
        [TUICallingAction openCamera:[TUICallingStatusManager shareInstance].camera videoView:_localPreView];
      [self.switchCameraBtn updateImage:[UIImage imageNamed:@"camera_open"]];
    }
}

#pragma mark - Lazy

- (CustomButton *)hangupBtn {
    if (!_hangupBtn) {
        __weak typeof(self) weakSelf = self;
      _hangupBtn = [[CustomButton alloc] initWithImage:@"ic_hangup" title:@"取消" color:UIColor.whiteColor bgColor:[UIColor t_colorWithHexString:@"#F23D78"]];
      [_hangupBtn addTarget:self action:@selector(hangupTouchEvent:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _hangupBtn;
}

- (CustomButton *)switchCameraBtn {
    if (!_switchCameraBtn) {
      _switchCameraBtn = [[CustomButton alloc] initWithImage:@"camera_open" title:@"镜头开启"];
      _switchCameraBtn.backgroundColor = [UIColor t_colorWithHexString:@"#ffffff"];
      _switchCameraBtn.layer.cornerRadius = 30;
      _switchCameraBtn.clipsToBounds = true;
//        [_switchCameraBtn setBackgroundImage:[TUICallingCommon getBundleImageWithName:@"switch_camera"] forState:UIControlStateNormal];
        [_switchCameraBtn addTarget:self action:@selector(switchCameraTouchEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchCameraBtn;
}

@end
