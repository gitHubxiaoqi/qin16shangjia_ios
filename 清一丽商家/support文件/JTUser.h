//
//  JTUser.h
//  Qyli
//
//  Created by 小七 on 14-8-4.
//  Copyright (c) 2014年 ___清一丽___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JTUser : NSObject

@property(assign,nonatomic)int userID;
@property(strong,nonatomic)NSString * userName;
@property(strong,nonatomic)NSString * loginName;
@property(strong,nonatomic)NSString * password;

@property(strong,nonatomic)NSString * headPortraitImgUrlStr;
@property(strong,nonatomic)NSString * pointsTitle;//积分头衔  新版NULL

//新版新增

@property(strong,nonatomic)NSString * userType;//用户类型（USER:普通，MERCHANT:商家，ADMIN:管理员）
@property(strong,nonatomic)NSString * userShangjiaType;//用户商家类型（1:机构，2:店铺）
@property(strong,nonatomic)NSString * userShangjiaID;//用户商家Id

@property(nonatomic,assign)NSString * status;//用户是否有效

@property(strong,nonatomic)NSString * EMuserLoginName;
@end
