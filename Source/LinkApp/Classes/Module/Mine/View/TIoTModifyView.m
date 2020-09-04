//
//  TIoTModifyView.m
//  LinkApp
//
//  Created by ccharlesren on 2020/7/31.
//  Copyright © 2020 Winext. All rights reserved.
//

#import "TIoTModifyView.h"

@interface TIoTModifyView ()
@property (nonatomic, strong) UIView        *contentView;
@end

@implementation TIoTModifyView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat kSpace = 15;
    CGFloat kPadding = 30;
    CGFloat kHeight = 50;
    
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [self.contentView addSubview:self.phoneOrEmailTF];
    [self.phoneOrEmailTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kSpace * kScreenAllHeightScale);
        make.leading.equalTo(self.contentView.mas_leading).offset(kPadding);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-kPadding);
        make.height.mas_equalTo(kHeight * kScreenAllHeightScale);
    }];
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
    [self.contentView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.phoneOrEmailTF.mas_leading);
        make.trailing.equalTo(self.phoneOrEmailTF.mas_trailing);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(self.phoneOrEmailTF.mas_bottom);
    }];
    
    [self.contentView addSubview:self.verificationButton];
    [self.verificationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-kPadding);
        make.top.equalTo(line1.mas_bottom).offset(kSpace);
        make.height.mas_equalTo(kHeight * kScreenAllHeightScale);
    }];
    
    [self.contentView addSubview:self.verificationCodeTF];
    [self.verificationCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verificationButton.mas_top);
       make.leading.equalTo(self.phoneOrEmailTF.mas_leading);
       make.trailing.equalTo(self.verificationButton.mas_leading);
       make.height.mas_equalTo(kHeight * kScreenAllHeightScale);
    }];
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
    [self.contentView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.phoneOrEmailTF.mas_leading);
        make.trailing.equalTo(self.phoneOrEmailTF.mas_trailing);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(self.verificationCodeTF.mas_bottom);
    }];
    
    [self.contentView addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).offset(60 * kScreenAllHeightScale);
        make.leading.equalTo(self.contentView.mas_leading).offset(kPadding);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-kPadding);
        make.height.mas_equalTo(48);
    }];
}

-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    NSString *placeHoldString = @"";
    if (self.modifyAccoutType == ModifyAccountPhoneType) {
        placeHoldString = @"请输入手机号";
        _phoneOrEmailTF.keyboardType = UIKeyboardTypeNumberPad;
    }else if (self.modifyAccoutType == ModifyAccountEmailType) {
        placeHoldString = @"请输入邮箱";
        _phoneOrEmailTF.keyboardType = UIKeyboardTypeEmailAddress;
    }
    NSAttributedString *attriStr = [[NSAttributedString alloc] initWithString:placeHoldString attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#cccccc"],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    self.phoneOrEmailTF.attributedPlaceholder = attriStr;
    
}

#pragma mark - setter and getter

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor whiteColor];
        
    }
    return _contentView;
}

- (UITextField *)phoneOrEmailTF {
    if (!_phoneOrEmailTF) {
        _phoneOrEmailTF = [[UITextField alloc]init];
        _phoneOrEmailTF.textColor = [UIColor blackColor];
        _phoneOrEmailTF.font = [UIFont wcPfRegularFontOfSize:16];
        _phoneOrEmailTF.keyboardType = UIKeyboardTypeNumberPad;
        NSAttributedString *ap = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#cccccc"],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        _phoneOrEmailTF.attributedPlaceholder = ap;
        _phoneOrEmailTF.clearButtonMode = UITextFieldViewModeAlways;
        [_phoneOrEmailTF addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
    }
    return _phoneOrEmailTF;
  
}

- (UIButton *)verificationButton {
    if (!_verificationButton) {
        _verificationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_verificationButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_verificationButton setTitleColor:kMainColor forState:UIControlStateNormal];
        _verificationButton.titleLabel.font = [UIFont wcPfRegularFontOfSize:16];
        [_verificationButton addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _verificationButton;
}

- (UITextField *)verificationCodeTF {
    if (!_verificationCodeTF) {
        _verificationCodeTF = [[UITextField alloc]init];
        _verificationCodeTF.keyboardType = UIKeyboardTypeNumberPad;
        _verificationCodeTF.textColor = [UIColor blackColor];
        _verificationCodeTF.font = [UIFont wcPfRegularFontOfSize:16];
        NSAttributedString *apVerification = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#cccccc"],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        _verificationCodeTF.attributedPlaceholder = apVerification;
        _verificationCodeTF.clearButtonMode = UITextFieldViewModeAlways;
        [_verificationCodeTF addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
    }
    return _verificationCodeTF;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"确认修改" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton setBackgroundColor:kMainColorDisable];
        _confirmButton.enabled = NO;
        _confirmButton.titleLabel.font = [UIFont wcPfRegularFontOfSize:20];
        [_confirmButton addTarget:self action:@selector(confirmClickButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (void)confirmClickButton {
    if (self.delegate && [self.delegate respondsToSelector:@selector(modifyAccountConfirmClickButtonWithAccountType:)]) {
        [self.delegate modifyAccountConfirmClickButtonWithAccountType:self.modifyAccoutType];
    }
}

-(void)changedTextField:(UITextField *)textField {

    if (self.delegate && [self.delegate respondsToSelector:@selector(modifyAccountChangedTextFieldWithAccountType:)]) {
        [self.delegate modifyAccountChangedTextFieldWithAccountType:self.modifyAccoutType];
    }
}

- (void)sendCode:(UIButton *)button {

    if (self.delegate && [self.delegate respondsToSelector:@selector(modifyAccountSendCodeWithAccountType:)]) {
        [self.delegate modifyAccountSendCodeWithAccountType:self.modifyAccoutType];
    }
    
}
@end