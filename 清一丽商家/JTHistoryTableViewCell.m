//
//  JTHistoryTableViewCell.m
//  清一丽商家
//
//  Created by 小七 on 15-4-17.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTHistoryTableViewCell.h"

@implementation JTHistoryTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        CGRect rect=self.frame;
        rect.size.width=[UIScreen mainScreen].bounds.size.width;
        self.frame=rect;
        
        self.dateLab=[[UILabel alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH/4.0,40)];
        self.dateLab.textColor=[UIColor brownColor];
        self.dateLab.textAlignment=NSTextAlignmentCenter;
        self.dateLab.font=[UIFont systemFontOfSize:13];
        [self addSubview:self.dateLab];
        
        self.isCountLab=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4.0, 0, SCREEN_WIDTH/4.0, 40)];
        self.isCountLab.textColor=[UIColor blackColor];
        self.isCountLab.textAlignment=NSTextAlignmentCenter;
        self.isCountLab.font=[UIFont systemFontOfSize:13];
        [self addSubview:self.isCountLab];
        
        self.cgCountLab=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4.0*2, 0, SCREEN_WIDTH/4.0, 40)];
        self.cgCountLab.textColor=[UIColor blackColor];
        self.cgCountLab.textAlignment=NSTextAlignmentCenter;
        self.cgCountLab.font=[UIFont systemFontOfSize:13];
        [self addSubview:self.cgCountLab];
        
        self.aCountLab=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4.0*3, 0, SCREEN_WIDTH/4.0, 40)];
        self.aCountLab.textColor=[UIColor blackColor];
        self.aCountLab.textAlignment=NSTextAlignmentCenter;
        self.aCountLab.font=[UIFont systemFontOfSize:13];
        [self addSubview:self.aCountLab];
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
