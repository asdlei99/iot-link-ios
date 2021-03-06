//
//  WCMemberInfoVC.m
//  TenextCloud
//
//  Created by Wp on 2020/1/8.
//  Copyright © 2020 Winext. All rights reserved.
//

#import "TIoTMemberInfoVC.h"

@interface TIoTMemberInfoVC ()
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *memberNick;
@property (weak, nonatomic) IBOutlet UILabel *account;
@property (weak, nonatomic) IBOutlet UILabel *roleL;
@property (weak, nonatomic) IBOutlet UIButton *removeBtn;

@end

@implementation TIoTMemberInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self fillInfo];
}

- (void)fillInfo
{
    self.title = NSLocalizedString(@"member_setting", @"成员设置");
    [self.headImg setImageWithURLStr:self.memberInfo[@"Avatar"] placeHolder:@"userDefalut"];
    self.memberNick.text = self.memberInfo[@"NickName"];
    self.roleL.text = [self.memberInfo[@"Role"] integerValue] == 1 ? NSLocalizedString(@"role_owner", @"所有者") : NSLocalizedString(@"role_member",@"成员");
    
    if (self.isOwner && ![[TIoTCoreUserManage shared].userId isEqualToString:self.memberInfo[@"UserID"]]) {
        self.removeBtn.hidden = NO;
    }
}

- (IBAction)done:(UIButton *)sender {
    NSDictionary *param = @{@"MemberID":self.memberInfo[@"UserID"],@"FamilyId":self.familyId};
    [[TIoTRequestObject shared] post:AppDeleteFamilyMember Param:param success:^(id responseObject) {
        [MBProgressHUD showSuccess:NSLocalizedString(@"remove_success", @"移除成功")];
        [HXYNotice postUpdateMemberList];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *reason, NSError *error,NSDictionary *dic) {
        [MBProgressHUD showError:reason];
    }];
}



@end
