//
//  CustomUserInfoView.m
//  TUICallKit
//
//  Created by Yuj on 2023/4/20.
//
#import "TUICallingStatusManager.h"
#import "CustomUserInfoView.h"
#import "UIColor+TUICallingHex.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
@interface CustomUserInfoView()
@property (nonatomic,strong) UIImageView *avatar;
@property (nonatomic,strong) UILabel *name;
@property (nonatomic,strong) UILabel *tip;
@property (nonatomic,strong) UIStackView *stackView;
@end
@implementation CustomUserInfoView

- (instancetype)initWithFrame:(CGRect)frame{
  if (self = [super initWithFrame:frame]){
    [self configUI];
  }
  return self;
}
- (void)clean:(BOOL)all{
  if (all){
    self.avatar.image = nil;
    self.avatar.hidden = true;
    self.name.text = @"";
  }
  [self updateTips:@""];
  for (UIView *view in self.stackView.arrangedSubviews) {
    [self.stackView removeArrangedSubview:view];
    [view removeFromSuperview];
  }
}

- (void)updateTips:(NSString *)tip{
  self.tip.text = tip;
}
- (void)updateIcons:(NSDictionary *)dic{
  if (!dic || [dic[@"is_free"] boolValue]){
    return;
  }
  if (!dic[@"bean"]){
    return;
  }
  for (UIView *view in self.stackView.arrangedSubviews) {
    [self.stackView removeArrangedSubview:view];
    [view removeFromSuperview];
  }
  if (TUICallingStatusManager.shareInstance.callStatus == TUICallStatusAccept){
    return;
  }
  
  NSArray *arr = dic[@"bean"][@"content"];
  for (int i = 0; i < arr.count; i ++) {
    NSString *url = arr[i][@"pic"];
    NSString *name = arr[i][@"name"];
    
    if (i > 0){
      UIImageView *add = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 11, 11)];
      add.image = [UIImage imageNamed:@"add"];
      [self.stackView addArrangedSubview:add];
      [add mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(11);
      }];
    }
    
    UIView *view = [self getIconView:url withName:name];
    [self.stackView addArrangedSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
      make.width.height.mas_equalTo(64);
    }];
  }
}
- (UIView *)getIconView:(NSString *)url withName:(NSString *)name{
  NSLog(@"%@",url);
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 62, 64)];
  view.backgroundColor = [[UIColor t_colorWithHexString:@"#e9d5e0"] colorWithAlphaComponent:0.4];
  view.layer.cornerRadius = 10;
  view.clipsToBounds = true;
  UIView *bg = [[UIView alloc] init];
  bg.backgroundColor = [UIColor t_colorWithHexString:@"#F6B7D1"];
  [view addSubview:bg];
  [bg mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.width.bottom.mas_equalTo(view);
    make.height.mas_equalTo(20);
  }];
  UILabel *lb = [UILabel new];
  lb.font = [UIFont boldSystemFontOfSize:12];
  lb.text = name;
  lb.textColor = UIColor.whiteColor;
  [bg addSubview:lb];
  [lb mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.mas_equalTo(0);
  }];
  UIImageView *icon = [UIImageView new];
  icon.contentMode = UIViewContentModeScaleAspectFill;
  icon.clipsToBounds = true;
  [icon sd_setImageWithURL:[NSURL URLWithString:url]];
  [view addSubview:icon];
  [icon mas_makeConstraints:^(MASConstraintMaker *make) {
    make.width.height.mas_equalTo(50);
    make.centerX.mas_equalTo(0);
    make.top.mas_equalTo(2);
  }];
  return view;
}
- (void)updateInfo:(NSDictionary *)json{
  if (!json){
    [self clean:true];
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
  [self addSubview:self.stackView];
  
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
  }];
  [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(self.tip.mas_bottom).mas_offset(23);
    make.centerX.mas_equalTo(0);
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

- (UIStackView *)stackView{
  if (!_stackView){
    _stackView = [UIStackView new];
    _stackView.userInteractionEnabled = false;
    _stackView.alignment = UIStackViewAlignmentCenter;
    _stackView.axis = UILayoutConstraintAxisHorizontal;
    _stackView.distribution = UIStackViewDistributionEqualSpacing;
    _stackView.spacing = 10;
  }
  return _stackView;
}

@end
