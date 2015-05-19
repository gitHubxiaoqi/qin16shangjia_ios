//
//  JTDianpuPersonalDaijinquanListTabviewCell.h
//  清一丽
//
//  Created by 小七 on 15-1-5.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTDianpuPersonalDaijinquanListTabviewCell : UITableViewCell
@property(nonatomic,strong)UIImageView * bgImgView;
@property(nonatomic,strong)UIImageView * imgView;
@property(nonatomic,strong)UILabel * numLab;
@property(nonatomic,strong)UILabel * dateLab;
@property(nonatomic,strong)UILabel * dateValueLab;
@property(nonatomic,strong)UIImageView * finishLab;
@property(nonatomic,strong)UILabel * addLab;
@property(nonatomic,strong)UILabel * addHistoryLab;
-(void)refreshUI;
@end
