//
//  JTDianpuPersonalGoodsListTabViewCell.h
//  清一丽
//
//  Created by 小七 on 14-12-31.
//  Copyright (c) 2014年 ___清一丽___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTDianpuPersonalGoodsListTabViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView * bgImgView;
@property(nonatomic,strong)UIImageView * imgView;
@property(nonatomic,strong)UILabel * titleLab;
@property(nonatomic,strong)UILabel * typeLab;
@property(nonatomic,strong)UILabel * typeValueLab;
@property(nonatomic,strong)UILabel * priceLab;
@property(nonatomic,strong)UILabel * priceValueLab;
-(void)refreshUI;
@end
