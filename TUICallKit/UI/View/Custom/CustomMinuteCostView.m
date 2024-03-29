//
//  CustomMinuteCostView.m
//  TUICallKit
//
//  Created by Yuj on 2023/4/27.
//

#import "CustomMinuteCostView.h"
#import "Masonry.h"
#import "UIColor+TUICallingHex.h"

@interface CustomMinuteCostView()
@property (nonatomic,strong) UIStackView *stackView;
@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UILabel *priceO; //原价格
@property (nonatomic,strong) UILabel *priceC; //现价格
@end
@implementation CustomMinuteCostView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self initUI];
  }
  return self;
}

- (void)initUI{
  [self addSubview:self.stackView];
  [self.stackView addArrangedSubview:self.icon];
  [self.stackView addArrangedSubview:self.priceO];
  [self.stackView addArrangedSubview:self.priceC];
  
  [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.mas_equalTo(0);
  }];
}
- (void)updateTimeInfo:(NSDictionary *)info{
  if (!info || [info[@"is_free"] boolValue]){
    self.icon.hidden = true;
    self.priceO.hidden = true;
    self.priceC.hidden = true;
    return;
  }
  NSDictionary *bean = info[@"bean"];
  if (!bean){
    return;
  }
  NSString *oStr = bean[@"originalStr"];
  
  self.priceO.hidden = false;
  
  NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:oStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:UIColor.whiteColor}];
  self.priceO.attributedText = att;
}
- (UIStackView *)stackView{
  if (!_stackView){
    _stackView = [[UIStackView alloc] init];
    _stackView.axis = UILayoutConstraintAxisHorizontal;
    _stackView.alignment = UIStackViewAlignmentCenter;
    _stackView.spacing = 5;
    _stackView.distribution = UIStackViewDistributionEqualSpacing;
  }
  return _stackView;
}
- (UIImageView *)icon{
  if (!_icon){
    _icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newUser"]];
    _icon.hidden = true;
  }
  return _icon;
}
- (UILabel *)priceO{
  if (!_priceO){
    _priceO = [UILabel new];
  }
  return _priceO;
}
- (UILabel *)priceC{
  if (!_priceC){
    _priceC = [UILabel new];
    _priceC.font = [UIFont systemFontOfSize:14];
    _priceC.textColor = [UIColor t_colorWithHexString:@"#57EAE6"];
  }
  return _priceC;
}
@end
