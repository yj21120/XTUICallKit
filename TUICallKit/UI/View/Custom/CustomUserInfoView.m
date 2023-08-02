//
//  CustomUserInfoView.m
//  TUICallKit
//
//  Created by Yuj on 2023/4/20.
//

#import "CustomUserInfoView.h"
#import "UIColor+TUICallingHex.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
@interface CustomUserInfoView()
@property (nonatomic,strong) UIImageView *avatar;
@property (nonatomic,strong) UILabel *name;
@property (nonatomic,strong) UILabel *tip;
@end
@implementation CustomUserInfoView

- (instancetype)initWithFrame:(CGRect)frame{
  if (self = [super initWithFrame:frame]){
    [self configUI];
  }
  return self;
}
- (void)clean{
  self.avatar.image = nil;
  self.avatar.hidden = true;
  self.name.text = @"";
  [self updateTips:@""];
}

- (void)updateTips:(NSString *)tip{
  self.tip.text = tip;
}
- (void)updateInfo:(NSDictionary *)json{
  if (!json){
    [self clean];
    return;
  }
  NSString *path = json[@"avatar"][@"url"];
  NSString *name = json[@"name"];
  if (!path || [path isKindOfClass:NSNull.class] || [path isEqualToString:@"<null>"]){
    path = @"";
  }
  NSURL *url = [NSURL URLWithString:path];
  [self.avatar sd_setImageWithURL:url];
  self.avatar.hidden = false;
  self.name.text = name;
}
- (void)configUI{
  [self addSubview:self.avatar];
  [self addSubview:self.name];
  [self addSubview:self.tip];
  
  [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
    make.width.height.mas_equalTo(120);
    make.centerX.mas_equalTo(0);
    make.top.mas_equalTo(110);
  }];
  [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(0);
    make.top.mas_equalTo(self.avatar.mas_bottom).mas_offset(23);
  }];
  [self.tip mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(0);
    make.top.mas_equalTo(self.name.mas_bottom).mas_offset(23);
    make.bottom.mas_equalTo(-23);
  }];
  
}

- (UIImageView *)avatar{
  if (!_avatar){
    _avatar = [UIImageView new];
    _avatar.contentMode = UIViewContentModeScaleAspectFill;
    _avatar.clipsToBounds = true;
    _avatar.layer.cornerRadius = 60;
    _avatar.layer.borderColor = UIColor.whiteColor.CGColor;
    _avatar.layer.borderWidth = 1;
  }
  return _avatar;
}
- (UILabel *)name{
  if (!_name){
    _name = [UILabel new];
    _name.font = [UIFont boldSystemFontOfSize:24];
    _name.textColor = UIColor.whiteColor;
  }
  return _name;
}
- (UILabel *)tip{
  if (!_tip){
    _tip = [UILabel new];
    _tip.font = [UIFont systemFontOfSize:14 weight:(UIFontWeightMedium)];
    _tip.textColor = UIColor.whiteColor;
  }
  return _tip;
}



@end
