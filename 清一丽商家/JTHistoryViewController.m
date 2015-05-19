//
//  JTHistoryViewController.m
//  清一丽商家后台
//
//  Created by 小七 on 15-3-14.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTHistoryViewController.h"
#import "JTHistoryTableViewCell.h"

@interface JTHistoryViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _listModelArr;
    int q;
    
}


@end

@implementation JTHistoryViewController
-(void)viewDidAppear:(BOOL)animated
{
    [self sendPost];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    q=3;
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
    navTitailLab.text=@"访问记录";
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
    
    UIView * longView=[[UIView alloc] initWithFrame:CGRectMake(0,64 , SCREEN_WIDTH, 30)];
    longView.backgroundColor=[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    [self.view addSubview:longView];

    NSArray * arr=[[NSArray alloc] initWithObjects:@"访问日期",@"店铺访问量",@"商品访问量",@"活动访问量" ,nil];
    for (int i=0; i<4; i++)
    {
        UILabel * lab=[[UILabel alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH/4.0, 0,SCREEN_WIDTH/4.0, 30)];
        lab.font=[UIFont systemFontOfSize:14];
        lab.textAlignment=NSTextAlignmentCenter;
        lab.textColor=[UIColor blackColor];
        lab.text=[arr objectAtIndex:i];
        [longView addSubview:lab];
    }
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64+30, self.view.frame.size.width, self.view.frame.size.height-94) style:UITableViewStylePlain];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [_tableView addHeaderWithTarget:self action:@selector(CompanyListHeaderRefreshing)];
    [_tableView addFooterWithTarget:self  action:@selector(footerRefresh)];
    _tableView.headerRefreshingText =@HeaderRefreshingText;
    _tableView.footerRefreshingText=@FooterRefreshingText;
    [self.view addSubview:_tableView];
}
-(void)leftBtnCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listModelArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JTHistoryTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell=[[JTHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    JTSortModel * model=[_listModelArr objectAtIndex:indexPath.row];

    cell.dateLab.text=[NSString stringWithFormat:@"%@",model.registTime];
    cell.isCountLab.text=[NSString stringWithFormat:@"%@",model.beginDate];
    cell.cgCountLab.text=[NSString stringWithFormat:@"%@",model.endDate];
    cell.aCountLab.text=[NSString stringWithFormat:@"%@",model.openTime];
    return cell;
}
//发请求
-(void)sendPost
{
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
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_tableView headerEndRefreshing];
    });
}

-(void)footerRefresh
{
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
    
    AppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
    if ([SOAPRequest checkNet])
    {
        
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",appdelegate.appUser.userShangjiaID],@"targetId",@"",@"lastDate",@"2",@"type",@"20",@"pageSize", nil];
        NSDictionary * zaojiaoDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_GetDetailViewCountForUser] jsonDic:jsondic]];
        if ([[NSString stringWithFormat:@"%@",[zaojiaoDic objectForKey:@"resultCode"]]isEqualToString:@"1000"])
        {
            
            if (q==3)
            {
                if ([[[zaojiaoDic objectForKey:@"detailViewCountDtoPage"] objectForKey:@"totalCount"] intValue]==0)
                {
                    NSString * str=@"未找到符合条件的数据！";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                    return;
                }
                NSArray * zaojiaoListArr=[[zaojiaoDic objectForKey:@"detailViewCountDtoPage"] objectForKey:@"list"];
                for (int i=0; i<zaojiaoListArr.count; i++)
                {
                    JTSortModel * sortModel=[[JTSortModel alloc] init];
                    sortModel.registTime=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"viewDate"];
                    sortModel.beginDate=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"isCount"];
                    sortModel.endDate=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"cgCount"];
                    sortModel.openTime=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"aCount"];
                    [_listModelArr addObject:sortModel];
                }
                q=6;
            }
            else
            {
                NSArray * zaojiaoListArr=[[zaojiaoDic objectForKey:@"detailViewCountDtoPage"] objectForKey:@"list"];;
                for (int i=0; i<zaojiaoListArr.count; i++)
                {
                    NSString * idStr=[NSString stringWithFormat:@"%@",[[zaojiaoListArr objectAtIndex:i] objectForKey:@"viewDate"]];
                    BOOL isExist=0;
                    for (int j=0; j<[_listModelArr count]; j++)
                    {
                        JTSortModel * aModel=[_listModelArr objectAtIndex:j];
                        if ([[NSString stringWithFormat:@"%@",aModel.registTime] isEqualToString:idStr])
                        {
                            isExist=1;
                            break;
                        }
                    }
                    if (isExist==0)
                    {
                        JTSortModel * sortModel=[[JTSortModel alloc] init];
                        sortModel.registTime=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"viewDate"];
                        sortModel.beginDate=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"isCount"];
                        sortModel.endDate=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"cgCount"];
                        sortModel.openTime=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"aCount"];
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
    JTSortModel * model=[_listModelArr lastObject];
    AppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
    
    NSString * str=[NSString stringWithFormat:@"%@",model.registTime];
    if (model.registTime==nil||[model.registTime isEqualToString:@""])
    {
        str=@"";
    }
    if ([SOAPRequest checkNet])
    {
        
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",appdelegate.appUser.userShangjiaID],@"targetId",str,@"lastDate",@"2",@"type",@"20",@"pageSize", nil];
        NSDictionary * zaojiaoDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_GetDetailViewCountForUser] jsonDic:jsondic]];
        
        if ([[NSString stringWithFormat:@"%@",[zaojiaoDic objectForKey:@"resultCode"]] isEqualToString:@"1000"])
        {
            if ([[[zaojiaoDic objectForKey:@"detailViewCountDtoPage"] objectForKey:@"list"] count]==0)
            {
                NSString * str=@"已全部加载完毕！";
                [JTAlertViewAnimation startAnimation:str view:self.view];
                return;
            }
            NSArray * zaojiaoListArr=[[zaojiaoDic objectForKey:@"detailViewCountDtoPage"]objectForKey:@"list"];
            for (int i=0; i<zaojiaoListArr.count; i++)
            {
                JTSortModel * sortModel=[[JTSortModel alloc] init];
                sortModel.registTime=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"viewDate"];
                sortModel.beginDate=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"isCount"];
                sortModel.endDate=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"cgCount"];
                sortModel.openTime=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"aCount"];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
