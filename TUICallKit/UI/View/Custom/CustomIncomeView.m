//
//  CustomIncomeView.m
//  TUICallKit
//
//  Created by Yuj on 2023/4/27.
//

#import "CustomIncomeView.h"
#import "UIColor+TUICallingHex.h"
#import "Masonry.h"
@interface CustomIncomeView()
@property (nonatomic,strong) UIView *container;
@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UILabel *incomeLB;
@property (nonatomic,strong) UILabel *aniLB;
@property (nonatomic,assign) NSInteger income;

@property (nonatomic,strong) UIView *container1;//余额
@property (nonatomic,strong) UIImageView *icon1;
@property (nonatomic,strong) UILabel *incomeLB1;
@property (nonatomic,strong) UILabel *aniLB1;
@property (nonatomic,assign) NSInteger income1;

@property (nonatomic,strong) UIView *container2;
@property (nonatomic,strong) UIImageView *icon2;
@property (nonatomic,strong) UILabel *incomeLB2;
@property (nonatomic,strong) UILabel *aniLB2;
@property (nonatomic,assign) NSInteger income2;
@end

@implementation CustomIncomeView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self initUI];
    self.clipsToBounds = false;
    self.container.hidden = true;
    self.container1.hidden = true;
    self.container2.hidden = true;
  }
  return self;
}
- (void)updateIncome:(NSDictionary *)param{
  if (!param || [param[@"is_free"] boolValue]){
    self.container1.hidden = true;
    self.container2.hidden = true;
    self.container.hidden = true;
    return;
  }
  if (!param || [param[@"show_fee_type"] intValue] != 2){
    //扣费方
    NSInteger total = [param[@"total_fee"] integerValue];
    NSInteger balance = [param[@"goldBean"] integerValue];
    self.incomeLB1.text = [NSString stringWithFormat:@"消耗：%ld",total];
    self.incomeLB2.text = [NSString stringWithFormat:@"余额：%ld",balance];
    self.container1.hidden = false;
    self.container2.hidden = false;
//    if (total <= 0){
//      self.income2 = 0;
//    }else{
//      NSInteger add = total - self.income;
//      if (add == 0){
//        return;
//      }
//      self.income = total;
//      self.aniLB.hidden = false;
//      self.aniLB.alpha = 1;
//      self.aniLB.text = [NSString stringWithFormat:@"+%ld",add];
//      [self.aniLB mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self.container.mas_top).mas_offset(10);
//      }];
//      [self layoutIfNeeded];
//      [UIView animateWithDuration:1 animations:^{
//        self.aniLB.alpha = 0;
//        [self.aniLB mas_updateConstraints:^(MASConstraintMaker *make) {
//          make.bottom.mas_equalTo(self.container.mas_top).mas_offset(0);
//        }];
//        [self layoutIfNeeded];
//      } completion:^(BOOL finished) {
//        self.aniLB.hidden = true;
//      }];
//    }
    return;
  }
  self.container1.hidden = true;
  self.container2.hidden = true;
  NSInteger total = [param[@"total_fee"] integerValue];
  self.container.hidden = total <= 0;
  self.incomeLB.text = [NSString stringWithFormat:@"收益：%ld",total];
  if (total <= 0){
    self.income = 0;
  }else{
    NSInteger add = total - self.income;
    if (add == 0){
      return;
    }
    self.income = total;
    self.aniLB.hidden = false;
    self.aniLB.alpha = 1;
    self.aniLB.text = [NSString stringWithFormat:@"+%ld",add];
    [self.aniLB mas_updateConstraints:^(MASConstraintMaker *make) {
      make.bottom.mas_equalTo(self.container.mas_top).mas_offset(10);
    }];
    [self layoutIfNeeded];
    [UIView animateWithDuration:1 animations:^{
      self.aniLB.alpha = 0;
      [self.aniLB mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.container.mas_top).mas_offset(0);
      }];
      [self layoutIfNeeded];
    } completion:^(BOOL finished) {
      self.aniLB.hidden = true;
    }];
  }
}
- (void)initUI{
  [self addSubview:self.container];
  [self.container addSubview:self.icon];
  [self.container addSubview:self.incomeLB];
  [self addSubview:self.aniLB];
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.bottom.mas_equalTo(0);
    make.height.mas_equalTo(24);
  }];
  [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(10);
    make.width.height.mas_equalTo(12);
    make.centerY.mas_equalTo(self.container);
  }];
  [self.incomeLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(self.icon.mas_right).mas_offset(6);
    make.centerY.mas_equalTo(0);
    make.right.mas_equalTo(-10);
  }];
  [self.aniLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.mas_equalTo(self.container).mas_offset(-10);
    make.bottom.mas_equalTo(self.container.mas_top).mas_offset(0);
  }];
  
  [self addSubview:self.container1];
  [self.container1 addSubview:self.icon1];
  [self.container1 addSubview:self.incomeLB1];
  [self addSubview:self.aniLB1];
  [self.container1 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.mas_equalTo(0);
    make.height.mas_equalTo(24);
  }];
  [self.icon1 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(10);
    make.width.height.mas_equalTo(12);
    make.centerY.mas_equalTo(self.container1);
  }];
  [self.incomeLB1 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(self.icon1.mas_right).mas_offset(6);
    make.centerY.mas_equalTo(0);
    make.right.mas_equalTo(-10);
  }];
  [self.aniLB1 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.mas_equalTo(self.container1).mas_offset(-10);
    make.bottom.mas_equalTo(self.container1.mas_top).mas_offset(0);
  }];
  
  [self addSubview:self.container2];
  [self.container2 addSubview:self.icon2];
  [self.container2 addSubview:self.incomeLB2];
  [self addSubview:self.aniLB2];
  [self.container2 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.bottom.mas_equalTo(0);
    make.top.mas_equalTo(self.container1.mas_bottom).mas_offset(5);
    make.height.mas_equalTo(24);
  }];
  [self.icon2 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(10);
    make.width.height.mas_equalTo(12);
    make.centerY.mas_equalTo(self.container2);
  }];
  [self.incomeLB2 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(self.icon2.mas_right).mas_offset(6);
    make.centerY.mas_equalTo(0);
    make.right.mas_equalTo(-10);
  }];
  [self.aniLB2 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.mas_equalTo(self.container2).mas_offset(-10);
    make.bottom.mas_equalTo(self.container2.mas_top).mas_offset(0);
  }];
  [self.container layoutIfNeeded];
  [self.container1 layoutIfNeeded];
  [self.container2 layoutIfNeeded];
}
- (UIView *)container{
  if (!_container){
    _container = [UIView new];
    _container.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.4];
    _container.layer.cornerRadius = 12;
  }
  return _container;
}
- (UIImageView *)icon{
  if (!_icon){
    _icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"income_bean"]];
  }
  return _icon;
}
- (UILabel *)incomeLB{
  if (!_incomeLB){
    _incomeLB = [UILabel new];
    _incomeLB.font = [UIFont systemFontOfSize:12];
    _incomeLB.textColor = UIColor.whiteColor;
  }
  return _incomeLB;
}
- (UILabel *)aniLB{
  if (!_aniLB){
    _aniLB = [UILabel new];
    _aniLB.font = [UIFont systemFontOfSize:10];
    _aniLB.textColor = [UIColor t_colorWithHexString:@"#F83466"];
  }
  return _aniLB;
}

- (UIView *)container1{
  if (!_container1){
    _container1 = [UIView new];
    _container1.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.4];
    _container1.layer.cornerRadius = 12;
  }
  return _container1;
}
- (UIImageView *)icon1{
  if (!_icon1){
    _icon1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coinIcon"]];
  }
  return _icon1;
}
- (UILabel *)incomeLB1{
  if (!_incomeLB1){
    _incomeLB1 = [UILabel new];
    _incomeLB1.font = [UIFont systemFontOfSize:12];
    _incomeLB1.textColor = UIColor.whiteColor;
  }
  return _incomeLB1;
}
- (UILabel *)aniLB1{
  if (!_aniLB1){
    _aniLB1 = [UILabel new];
    _aniLB1.font = [UIFont systemFontOfSize:10];
    _aniLB1.textColor = [UIColor t_colorWithHexString:@"#F83466"];
  }
  return _aniLB1;
}

- (UIView *)container2{
  if (!_container2){
    _container2 = [UIView new];
    _container2.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.4];
    _container2.layer.cornerRadius = 12;
  }
  return _container2;
}
- (UIImageView *)icon2{
  if (!_icon2){
    _icon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coinIcon"]];
  }
  return _icon2;
}
- (UILabel *)incomeLB2{
  if (!_incomeLB2){
    _incomeLB2 = [UILabel new];
    _incomeLB2.font = [UIFont systemFontOfSize:12];
    _incomeLB2.textColor = UIColor.whiteColor;
  }
  return _incomeLB2;
}
- (UILabel *)aniLB2{
  if (!_aniLB2){
    _aniLB2 = [UILabel new];
    _aniLB2.font = [UIFont systemFontOfSize:10];
    _aniLB2.textColor = [UIColor t_colorWithHexString:@"#F83466"];
  }
  return _aniLB2;
}
@end
