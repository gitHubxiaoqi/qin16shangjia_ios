//
//  JTHuoyuanListViewController.m
//  清一丽商家后台
//
//  Created by 小七 on 15-3-12.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTHuoyuanListViewController.h"
#import "JTHuiyuanListTableViewCell.h"

@interface JTHuoyuanListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _listModelArr;
    int pageNum;
    int q;
    int totalCount;
}


@end

@implementation JTHuoyuanListViewController

-(void)viewDidAppear:(BOOL)animated
{
    [self sendPost];
    UILabel * totalLab=(UILabel *)[self.view viewWithTag:50];
    totalLab.text=[NSString stringWithFormat:@"会员总数：%d",totalCount];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    totalCount=0;
    pageNum=1;
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
    navTitailLab.text=@"我的会员";
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
    
    
    UILabel * totalLab=[[UILabel alloc] initWithFrame:CGRectMake(10, 20+NAV_HEIGHT, SCREEN_WIDTH-20, 30)];
    totalLab.tag=50;
    totalLab.textColor=[UIColor blackColor];
    totalLab.font=[UIFont systemFontOfSize:18];
    [self.view addSubview:totalLab];
    
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64+30, self.view.frame.size.width, self.view.frame.size.height-64-30) style:UITableViewStylePlain];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [_tableView addHeaderWithTarget:self action:@selector(CompanyListHeaderRefreshing)];
    [_tableView addFooterWithTarget:self  action:@selector(footerRefresh)];
    _tableView.headerRefreshingText =@HeaderRefreshingText;
    _tableView.footerRefreshingText=@FooterRefreshingText;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
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
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JTHuiyuanListTableViewCell * customCell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!customCell)
    {
        customCell=[[JTHuiyuanListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        customCell.selectionStyle=UITableViewCellSelectionStyleNone;
        customCell.backgroundColor=[UIColor clearColor];
    }
    JTSortModel * model=[_listModelArr objectAtIndex:indexPath.row];
    customCell.titleLab.text=model.title;
    customCell.activeValueLab.text=[NSString stringWithFormat:@"会员活跃度：%@",model.style];
    customCell.registDateLab.text=[NSString stringWithFormat:@"会员生成日：%@",model.beginDate];
       return customCell;
}
#pragma mark- 发请求
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
    if ([SOAPRequest checkNet])
    {
        AppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:appdelegate.appUser.userShangjiaID,@"merchantId",@"1",@"page",nil];
        NSDictionary * zaojiaoListDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_Dianpu_merchantMemberPage] jsonDic:jsondic]];
        
        
        if ([[NSString stringWithFormat:@"%@",[zaojiaoListDic objectForKey:@"resultCode"]] isEqualToString:@"1000"])
        {
            totalCount=[[[zaojiaoListDic objectForKey:@"mmPage"] objectForKey:@"totalCount"] intValue];
            if (q==3)
            {
                if ([[[zaojiaoListDic objectForKey:@"mmPage"] objectForKey:@"totalCount"] intValue]==0)
                {
                    NSString * str=@"未找到符合条件的数据！";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                    return;
                }
                NSArray * zaojiaoListArr=[[zaojiaoListDic objectForKey:@"mmPage"] objectForKey:@"list"];
                for (int i=0; i<zaojiaoListArr.count; i++)
                {
                    JTSortModel * sortModel=[[JTSortModel alloc] init];
                    sortModel.idStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"];
                    sortModel.title=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"memberName"];
                    sortModel.beginDate=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"registValue"];
                    sortModel.style=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"activeValue"];
                    
                    [_listModelArr addObject:sortModel];
                }
                q=6;
            }
            else
            {
                NSArray * zaojiaoListArr=[[zaojiaoListDic objectForKey:@"mmPage"] objectForKey:@"list"];
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
                        sortModel.title=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"memberName"];
                        sortModel.beginDate=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"registValue"];
                        sortModel.style=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"activeValue"];
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
    if ([SOAPRequest checkNet])
    {
        AppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:appdelegate.appUser.userShangjiaID,@"merchantId",[NSString stringWithFormat:@"%d",pageNum],@"page", nil];
        NSDictionary * zaojiaoListDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_Dianpu_merchantMemberPage] jsonDic:jsondic]];
        
        if ([[zaojiaoListDic objectForKey:@"resultCode"] intValue]==1000)
        {
            if ([[[zaojiaoListDic objectForKey:@"mmPage"] objectForKey:@"list"] count]==0)
            {
                NSString * str=@"已全部加载完毕！";
                [JTAlertViewAnimation startAnimation:str view:self.view];
                pageNum--;
                return;
            }
            NSArray * zaojiaoListArr=[[zaojiaoListDic objectForKey:@"mmPage"] objectForKey:@"list"];
            for (int i=0; i<zaojiaoListArr.count; i++)
            {
                JTSortModel * sortModel=[[JTSortModel alloc] init];
                sortModel.idStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"];
                sortModel.title=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"memberName"];
                sortModel.beginDate=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"registValue"];
                sortModel.style=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"activeValue"];
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
