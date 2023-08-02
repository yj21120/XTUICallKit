//
//  CustomButton.m
//  TUICallKit
//
//  Created by Yuj on 2023/4/18.
//

#import "CustomButton.h"
#import "Masonry.h"
@interface CustomButton1()
@property (nonatomic,copy) NSString *named;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) UIColor *color;
@property (nonatomic,strong) UIStackView *stackView;
@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *titleLB;
@end
@implementation CustomButton1

- (instancetype)initWithImage:(NSString *)named title:(NSString *)title{
  if (self = [super init]){
    self.named = named;
    
    self.title = title;
    self.color = UIColor.blackColor;
    [self initUI];
  }
  return self;
}
- (instancetype)initWithImage:(NSString *)named title:(NSString *)title color:(UIColor *)color{
  if (self = [super init]){
    self.named = named;
    self.title = title;
    self.color = color;
    [self initUI];
  }
  return self;
}
- (void)updateImage:(UIImage *)image{
  self.iconView.image = image;
}
- (void)updateTitle:(NSString *)title{
  self.titleLB.text = title;
}
- (void)updateFont:(UIFont *)font{
  self.titleLB.font = font;
}
- (void)initUI{
  self.titleLB.textColor = self.color;
  self.iconView.image = [UIImage imageNamed:self.named];
  self.titleLB.text = self.title;
  [self addSubview:self.stackView];
  [self.stackView addArrangedSubview:self.iconView];
  [self.stackView addArrangedSubview:self.titleLB];
  [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.mas_equalTo(self);
  }];
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
- (UIImageView *)iconView{
  if (!_iconView){
    _iconView = [UIImageView new];
  }
  return _iconView;
}

- (UILabel *)titleLB{
  if (!_titleLB){
    _titleLB = [UILabel new];
    _titleLB.font = [UIFont systemFontOfSize:16];
  }
  return _titleLB;
}
- (UIColor *)color{
  if (!_color){
    _color = UIColor.blackColor;
  }
  return _color;
}
@end
@interface CustomButton()
@property (nonatomic,copy) NSString *named;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) UIColor *color;
@property (nonatomic,strong) UIColor *bgColor;
@property (nonatomic,strong) UIStackView *stackView;
@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *titleLB;
@end
@implementation CustomButton

- (instancetype)initWithImage:(NSString *)named title:(NSString *)title{
  if (self = [super init]){
    self.named = named;
    
    self.title = title;
    self.color = UIColor.blackColor;
    [self initUI];
  }
  return self;
}
- (instancetype)initWithImage:(NSString *)named title:(NSString *)title color:(UIColor *)color bgColor:(UIColor *)bgColor{
  if (self = [super init]){
    self.named = named;
    self.title = title;
    self.color = color;
    self.bgColor = bgColor;
    [self initUI];
  }
  return self;
}
- (void)updateImage:(UIImage *)image{
  self.iconView.image = image;
}
- (void)updateTitle:(NSString *)title{
  self.titleLB.text = title;
}
- (void)updateFont:(UIFont *)font{
  self.titleLB.font = font;
}
- (void)initUI{
  self.titleLB.textColor = self.color;
  self.iconView.image = [UIImage imageNamed:self.named];
  self.titleLB.text = self.title;
  self.bgView.backgroundColor = self.bgColor;
  [self addSubview:self.stackView];
  [self.stackView addArrangedSubview:self.bgView];
  [self.stackView addArrangedSubview:self.titleLB];
  [self.bgView addSubview:self.iconView];
  
  [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.centerX.bottom.mas_equalTo(self);
    make.width.mas_lessThanOrEqualTo(self);
  }];
  [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.width.height.mas_equalTo(64);
  }];
  [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.width.height.mas_equalTo(34);
    make.center.mas_equalTo(0);
  }];
}
- (UIStackView *)stackView{
  if (!_stackView){
    _stackView = [UIStackView new];
    _stackView.userInteractionEnabled = false;
    _stackView.alignment = UIStackViewAlignmentCenter;
    _stackView.axis = UILayoutConstraintAxisVertical;
    _stackView.distribution = UIStackViewDistributionEqualSpacing;
    _stackView.spacing = 15;
  }
  return _stackView;
}
- (UIImageView *)iconView{
  if (!_iconView){
    _iconView = [UIImageView new];
  }
  return _iconView;
}
- (UIView *)bgView{
  if (!_bgView){
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
    _bgView.layer.cornerRadius = 32;
    _bgView.clipsToBounds = true;
  }
  return _bgView;
}
- (UILabel *)titleLB{
  if (!_titleLB){
    _titleLB = [UILabel new];
    _titleLB.font = [UIFont systemFontOfSize:16];
  }
  return _titleLB;
}
- (UIColor *)color{
  if (!_color){
    _color = UIColor.blackColor;
  }
  return _color;
}
@end
