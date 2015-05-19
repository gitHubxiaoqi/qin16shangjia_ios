//
//  JTDianpuPersonalDaijinquanViewController.m
//  清一丽
//
//  Created by 小七 on 15-1-5.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTDianpuPersonalDaijinquanViewController.h"
#import "JTDianpuPersonalDaijinquanListTabviewCell.h"
@interface JTDianpuPersonalDaijinquanViewController()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _listModelArr;
    int pageNum;
    int q;
    UIButton * _selectedBtn1;
    UIButton * _selectedBtn2;
    BOOL  isFinish;
    
    UILabel * _countLab;
    int totalCount;
    int totalAmount;
    
}
@end
@implementation JTDianpuPersonalDaijinquanViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [self sendPost];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    totalCount=0;
    totalAmount=0;
    isFinish=0;
    q=3;
    pageNum=1;
    _listModelArr=[[NSMutableArray alloc] initWithCapacity:0];
    [self readyUI];
}
-(void)readyUI
{
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.hidden=YES;
    //自定义导航条
    UIImageView * navBgImgview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 44)];
    navBgImgview.image=[UIImage imageNamed:@"小横条.png"];
    navBgImgview.userInteractionEnabled=YES;
    [self.view addSubview:navBgImgview];
    
    UILabel * navTitailLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    navTitailLab.text=@"商家优惠券管理";
    navTitailLab.textAlignment=NSTextAlignmentCenter;
    navTitailLab.textColor=[UIColor whiteColor];
    navTitailLab.font=[UIFont systemFontOfSize:22];
    [navBgImgview addSubview:navTitailLab];
    
    UIImageView * bigBgImgview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-44)];
    bigBgImgview.image=[UIImage imageNamed:@"大背景.png"];
    bigBgImgview.userInteractionEnabled=YES;
    [self.view addSubview:bigBgImgview];
    
    UIButton * leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame=CGRectMake(0, 0, 80, NAV_HEIGHT);
    [leftBtn addTarget:self action:@selector(leftBtnCilck) forControlEvents:UIControlEventTouchUpInside];
    [navBgImgview addSubview:leftBtn];
    
    UIImageView * backImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"返回按钮.png"]];
    backImgView.frame=CGRectMake(20, (NAV_HEIGHT-15)/2, 10, 15);
    [leftBtn addSubview:backImgView];
    
    _selectedBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
    _selectedBtn1.frame=CGRectMake(self.view.frame.size.width/2.0-80, 64+15, 80, 25);
    [_selectedBtn1 setImage:[UIImage imageNamed:@"当前1.png"] forState:UIControlStateSelected];
    [_selectedBtn1 setImage:[UIImage imageNamed:@"当前2.png"] forState:UIControlStateNormal];
    [_selectedBtn1 addTarget:self action:@selector(qiehuan:) forControlEvents:UIControlEventTouchUpInside];
    _selectedBtn1.selected=YES;
    [self.view addSubview:_selectedBtn1];
    
    
    _selectedBtn2=[UIButton buttonWithType:UIButtonTypeCustom];
    _selectedBtn2.frame=CGRectMake(self.view.frame.size.width/2.0, 64+15, 80, 25);
    [_selectedBtn2 setImage:[UIImage imageNamed:@"历史2.png"] forState:UIControlStateSelected];
    [_selectedBtn2 setImage:[UIImage imageNamed:@"历史1.png"] forState:UIControlStateNormal];
    [_selectedBtn2 addTarget:self action:@selector(qiehuan:) forControlEvents:UIControlEventTouchUpInside];
    _selectedBtn2.selected=NO;
    [self.view addSubview:_selectedBtn2];
    
    _countLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 64+15+25+5, self.view.frame.size.width, 25)];
    _countLab.text=@"您有X张代金券未结算(共计Y元)";
    _countLab.textColor=[UIColor orangeColor];
    _countLab.textAlignment=NSTextAlignmentCenter;
    _countLab.font=[UIFont systemFontOfSize:18];
    [self.view addSubview:_countLab];
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64+15+25+25+5, self.view.frame.size.width, self.view.frame.size.height-134) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [_tableView addHeaderWithTarget:self action:@selector(CompanyListHeaderRefreshing)];
    [_tableView addFooterWithTarget:self  action:@selector(footerRefresh)];
    _tableView.headerRefreshingText =@HeaderRefreshingText;
    _tableView.footerRefreshingText=@FooterRefreshingText;
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];

}
-(void)qiehuan:(UIButton *)sender
{
    if (sender==_selectedBtn1)
    {
        _selectedBtn1.selected=YES;
        _selectedBtn2.selected=NO;
        isFinish=0;
        [self sendPost];
        _tableView.frame=CGRectMake(0, 64+15+25+25+5, self.view.frame.size.width, self.view.frame.size.height-134);
        _countLab.hidden=NO;
    }
    else if (sender==_selectedBtn2)
    {
        _selectedBtn1.selected=NO;
        _selectedBtn2.selected=YES;
        isFinish=1;
        [self sendPost];
        _tableView.frame=CGRectMake(0, 64+15+25+5, self.view.frame.size.width, self.view.frame.size.height-109);
        _countLab.hidden=YES;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listModelArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JTDianpuPersonalDaijinquanListTabviewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell=[[JTDianpuPersonalDaijinquanListTabviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    JTSortModel * model=[_listModelArr objectAtIndex:indexPath.row];
    cell.numLab.text=[NSString stringWithFormat:@"编号:%@",model.name];
    cell.dateValueLab.text=[NSString stringWithFormat:@"%@",model.openDay];
    if ([model.imgUrlStr isEqualToString:@""]||model.imgUrlStr==nil)
    {
        cell.imgView.image=[UIImage imageNamed:@"代金券.png"];
    }
    else
    {
       [cell.imgView setImageWithURL:[NSURL URLWithString:model.imgUrlStr] placeholderImage:[UIImage imageNamed:@"代金券.png"]];
    }
    if (isFinish==0)
    {
        cell.addHistoryLab.hidden=YES;
        cell.finishLab.hidden=YES;
        if ([[NSString stringWithFormat:@"%@",model.cost] isEqualToString:@"0"]||model.cost==nil)
        {
            cell.addLab.hidden=YES;

        }
        else
        {
            cell.addLab.hidden=NO;
            cell.addLab.text=[NSString stringWithFormat:@"奖励:%@元",model.cost];
        
        }
        
    }
    else if(isFinish==1)
    {
        cell.addLab.hidden=YES;
        cell.finishLab.hidden=NO;
        if ([[NSString stringWithFormat:@"%@",model.cost] isEqualToString:@"0"]||model.cost==nil)
        {
            cell.addHistoryLab.hidden=YES;
            
        }
        else
        {
            cell.addHistoryLab.hidden=NO;
            cell.addHistoryLab.text=[NSString stringWithFormat:@"奖励:%@元",model.cost];
        }
    }
    [cell refreshUI];
    return cell;
}
-(void)leftBtnCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}
//发请求
-(void)sendPost
{
    pageNum=1;
    [_listModelArr removeAllObjects];
    [_tableView reloadData];
    q=3;
    [_tableView headerBeginRefreshing];
}
-(void)CompanyListHeaderRefreshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 刷新表格
        [self GetCompanyListData];
        [_tableView reloadData];
        _countLab.text=[NSString stringWithFormat:@"您有%d张代金券未结算(共计%d元)",totalCount,totalAmount];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_tableView headerEndRefreshing];
    });
}

-(void)footerRefresh
{
    pageNum++;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //请求数据
        [self loadMoreData];
        // 刷新表格
        [_tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_tableView footerEndRefreshing];
    });
}
-(void)GetCompanyListData
{
    NSMutableArray * statueArr=[[NSMutableArray alloc] initWithCapacity:0];
    if (isFinish==0)
    {
        [statueArr addObject:@"Used"];
    }
    else if(isFinish==1)
    {
        [statueArr addObject:@"Settled"];
    }
    
    AppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
    if ([SOAPRequest checkNet])
    {
        
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",appdelegate.appUser.userShangjiaID],@"shopId",statueArr,@"status",@"1",@"page",@"20",@"pageSize", nil];
        NSDictionary * zaojiaoDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_UserVoucherPage] jsonDic:jsondic]];
        if ([[NSString stringWithFormat:@"%@",[zaojiaoDic objectForKey:@"resultCode"]]isEqualToString:@"1000"])
        {
            totalCount=[[[[zaojiaoDic objectForKey:@"userVoucherPage"] objectForKey:@"page"] objectForKey:@"totalCount"] intValue];
            totalAmount=[[[zaojiaoDic objectForKey:@"userVoucherPage"] objectForKey:@"totalAmount"] intValue];
            if (q==3)
            {
                if ([[[[zaojiaoDic objectForKey:@"userVoucherPage"] objectForKey:@"page"] objectForKey:@"totalCount"] intValue]==0)
                {
                    NSString * str=@"未找到符合条件的数据！";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                    return;
                }
                NSArray * zaojiaoListArr=[[[zaojiaoDic objectForKey:@"userVoucherPage"] objectForKey:@"page"] objectForKey:@"list"];
                for (int i=0; i<zaojiaoListArr.count; i++)
                {
                    JTSortModel * sortModel=[[JTSortModel alloc] init];
                    sortModel.idStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"];
                    sortModel.name=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"];
                    sortModel.imgUrlStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"imgUrl"];
                    if(isFinish==0)
                    {
                        sortModel.openDay=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"usedDate"];
                    }
                    else if(isFinish==1)
                    {
                        sortModel.openDay=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"settledDate"];
                    }
                    sortModel.cost=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"additional"];
                    [_listModelArr addObject:sortModel];

                }
                q=6;
            }
            else
            {
                NSArray * zaojiaoListArr=[[[zaojiaoDic objectForKey:@"userVoucherPage"] objectForKey:@"page"] objectForKey:@"list"];;
                for (int i=0; i<zaojiaoListArr.count; i++)
                {
                    NSString * idStr=[NSString stringWithFormat:@"%@",[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"]];
                    BOOL isExist=0;
                    for (int j=0; j<[_listModelArr count]; j++)
                    {
                        JTSortModel * aModel=[_listModelArr objectAtIndex:j];
                        if ([[NSString stringWithFormat:@"%@",aModel.idStr] isEqualToString:idStr])
                        {
                            isExist=1;
                            break;
                        }
                    }
                    if (isExist==0)
                    {
                        JTSortModel * sortModel=[[JTSortModel alloc] init];
                        sortModel.idStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"];
                        sortModel.name=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"];
                        sortModel.imgUrlStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"imgUrl"];
                        if(isFinish==0)
                        {
                            sortModel.openDay=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"usedDate"];
                        }
                        else if(isFinish==1)
                        {
                            sortModel.openDay=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"settledDate"];
                        }
                        sortModel.cost=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"additional"];
                        [_listModelArr insertObject:sortModel atIndex:0];

                        
                    }
                }
                
            }
        }
        else
        {
            NSString * str=@"服务器异常，请稍后重试...";
            [JTAlertViewAnimation startAnimation:str view:self.view];
        }
    }

    
}
-(void)loadMoreData
{
    NSMutableArray * statueArr=[[NSMutableArray alloc] initWithCapacity:0];
    if (isFinish==0)
    {
        [statueArr addObject:@"Used"];
    }
    else if(isFinish==1)
    {
        [statueArr addObject:@"Settled"];
    }
    if ([SOAPRequest checkNet])
    {
        AppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",appdelegate.appUser.userShangjiaID],@"shopId",statueArr,@"status",[NSString stringWithFormat:@"%d",pageNum],@"page",@"20",@"pageSize", nil];
        NSDictionary * zaojiaoDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_UserVoucherPage] jsonDic:jsondic]];
        
        if ([[NSString stringWithFormat:@"%@",[zaojiaoDic objectForKey:@"resultCode"]] isEqualToString:@"1000"])
        {
            if ([[[[zaojiaoDic objectForKey:@"userVoucherPage"] objectForKey:@"page"] objectForKey:@"list"] count]==0)
            {
                NSString * str=@"已全部加载完毕！";
                [JTAlertViewAnimation startAnimation:str view:self.view];
                pageNum--;
                return;
            }
            NSArray * zaojiaoListArr=[[[zaojiaoDic objectForKey:@"userVoucherPage"] objectForKey:@"page"]objectForKey:@"list"];
            for (int i=0; i<zaojiaoListArr.count; i++)
            {
                JTSortModel * sortModel=[[JTSortModel alloc] init];
                sortModel.idStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"];
                sortModel.name=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"];
                sortModel.imgUrlStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"imgUrl"];
                if(isFinish==0)
                {
                    sortModel.openDay=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"usedDate"];
                }
                else if(isFinish==1)
                {
                    sortModel.openDay=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"settledDate"];
                }
                sortModel.cost=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"additional"];
                [_listModelArr addObject:sortModel];
              
            }
            
        }
        else
        {
            NSString * str=@"服务器异常，请稍后重试...";
            [JTAlertViewAnimation startAnimation:str view:self.view];
        }
    }

}
@end
