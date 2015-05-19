//
//  JTDefine.h
//  Qyli
//
//  Created by 小七 on 14-8-22.
//  Copyright (c) 2014年 ___清一丽___. All rights reserved.
//

#import <Foundation/Foundation.h>

#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

//MJRefreash
#define HeaderRefreshingText "清一丽  正在帮您刷新数据"
#define FooterRefreshingText "清一丽  正在帮您加载数据"
//获取屏幕宽高
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//导航高度
#define NAV_HEIGHT 44
#define TAB_HEIGHT 49
// 背景颜色(RGB)
#define BG_COLOR     [UIColor colorWithRed:137.0/255.0 green:121.0/255.0 blue:108.0/255.0 alpha:1]
// 导航颜色(RGB)
#define NAV_COLOR       [UIColor colorWithRed:241.0/255.0 green:140.0/255.0 blue:157.0/255.0 alpha:1]

#define QYL_URL "http://mobile.qin16.com/"
//#define QYL_URL "http://mobile.qing16.com/"
//#define QYL_URL "http://172.20.10.68:8080/com.qin16.web.mobile/"


//1.2商家用户登录
#define NEW_QYL_People_MobileLoginURL  "MobileLogin/MerchantLoginValidate"
//3.3修改用户密码
#define NEW_QYL_People_SaveEditPasswordURL  "MobileCustomerUserOperation/SaveEditPassword"
//15.1商家后台-店铺，获取店铺信息接口
#define NEW_QYL_People_GetMerchantShopForEdit  "Mobile/Shop/GetMerchantShopForEdit"
//15.2修改店铺信息接口
#define NEW_QYL_People_SaveMerchantShopForEdit  "Mobile/Shop/SaveMerchantShopForEdit"
//15.3商家后台获取LOGO
#define NEW_QYL_People_GetMerchantShopLOGO  "Mobile/Shop/GetMerchantShopLOGO"
//15.4商家后台保存修改LOGO
#define NEW_QYL_People_SaveMerchantShopLOGO  "Mobile/Shop/SaveMerchantShopLOGO"
//15.5商家后台获取封面
#define NEW_QYL_People_GetMerchantShopCover  "Mobile/Shop/GetMerchantShopCover"
//15.6商家后台保存修改封面
#define NEW_QYL_People_SaveMerchantShopCover  "Mobile/Shop/SaveMerchantShopCover"
//15.7手机端商家后台获取商品列表
#define NEW_QYL_People_GetMerchantShopGoodsPage  "Mobile/ShopGoods/GetMerchantShopGoodsPage"
//15.8手机端商家后台添加/修改商品初始化数据（商品可选类型提供）
//#define NEW_QYL_People_AddOrEditMerchantShopGoods  "Mobile/ShopGoods/AddOrEditMerchantShopGoods"
//15.9手机端商家后台获取商品详情
#define NEW_QYL_People_getMerchantShopGoodsDetail  "Mobile/ShopGoods/getMerchantShopGoodsDetail"
//15.10手机端商家后台添加/修改商品保存
//#define NEW_QYL_People_SaveMerchantShopGoods  "Mobile/ShopGoods/SaveMerchantShopGoods"
//15.11手机端商家后台,根据Id删除商品
//#define NEW_QYL_People_DelMerchantShopGoods  "Mobile/ShopGoods/DelMerchantShopGoodsForIOS"
//17.1商家后台向该商家的会员推送信息
#define NEW_QYL_Jpush_SendMessageMerchant  "Jpush/SendMessageMerchant"
//11.4获取最新版本IOS
#define NEW_QYL_GetLastIOSVersionForMerchant  "VersionUpdate/GetLastIOSVersionForMerchant"
//19.1商家后台查看每日点击量接口
#define NEW_QYL_GetDetailViewCountForUser  "DetailViewCount/GetDetailViewCountForUser"

//商家我的卡券列表
#define NEW_QYL_People_UserVoucherPage "Mobile/Voucher/UserVoucherPage"
//结算清单列表页
#define NEW_QYL_People_VoucherStatement "Mobile/VoucherStatement"
//确认已结算
#define NEW_QYL_People_VoucherStatementConfirm "Mobile/VoucherStatement/Confirm"


//商家活动列表
#define NEW_QYL_Dianpu_shopActivityPage "Mobile/ShopActivity/Shop/shopActivityPage"
//商家活动详细
#define NEW_QYL_Dianpu_shopActivity "Mobile/ShopActivity/shopActivity"
//取消活动
//#define NEW_QYL_Dianpu_cancleActivity "Mobile/ShopActivity/cancleActivity"
//使用入场券
#define NEW_QYL_Dianpu_recieveRegistration "Mobile/ShopActivity/recieveRegistration"


//查看某店铺会员
#define NEW_QYL_Dianpu_merchantMemberPage "MobileMerchantMember/merchantMemberPage"



@interface JTDefine : NSObject

@end
