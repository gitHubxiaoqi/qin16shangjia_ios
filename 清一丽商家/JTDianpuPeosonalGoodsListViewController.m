//
//  JTDianpuPeosonalGoodsListViewController.m
//  清一丽
//
//  Created by 小七 on 14-12-31.
//  Copyright (c) 2014年 ___清一丽___. All rights reserved.
//

#import "JTDianpuPeosonalGoodsListViewController.h"
#import "JTDianpuPersonalGoodsListTabViewCell.h"
#import "JTDianpuPersonalGoodsDetailViewController.h"
@interface JTDianpuPeosonalGoodsListViewController()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate>
{
    UITableView * _tableView;
    NSString * _searchWord;
    NSMutableArray * _listModelArr;
    
    BOOL isSale;
    int pageNum;
    int q;
    int p;
}
@end
@implementation JTDianpuPeosonalGoodsListViewController
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
    if (p==1)
    {
        [self sendPost];
    }
    p=2;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    p=1;
    isSale=1;
    q=3;
    _searchWord=@"";
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
    
    UILabel * navTitailLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    navTitailLab.text=@"本店商品";
    navTitailLab.textAlignment=NSTextAlignmentCenter;
    navTitailLab.textColor=[UIColor whiteColor];
    navTitailLab.font=[UIFont systemFontOfSize:22];
    [navBgImgview addSubview:navTitailLab];
    
    UIButton * qiehuanBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    qiehuanBtn.frame=CGRectMake(SCREEN_WIDTH-80, 5, 60, 34);
    qiehuanBtn.backgroundColor=[UIColor clearColor];
    [qiehuanBtn setTitle:@"已上架" forState:UIControlStateNormal];
    qiehuanBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    qiehuanBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    qiehuanBtn.titleLabel.textColor=[UIColor whiteColor];
    [qiehuanBtn addTarget:self action:@selector(qiehuan:) forControlEvents:UIControlEventTouchUpInside];
    qiehuanBtn.tag=88;
    [navBgImgview addSubview:qiehuanBtn];
    
    UIImageView * imgView3=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"下箭头.png"]];
    imgView3.frame=CGRectMake(SCREEN_WIDTH-58, 30, 15, 10);
    [navBgImgview addSubview:imgView3];
    
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
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

-(void)qiehuan:(UIButton *)sender
{
    if (isSale==1)
    {
        [sender setTitle:@"未上架" forState:UIControlStateNormal];
        isSale=0;
        [self sendPost];
    }
    else
    {
        [sender setTitle:@"已上架" forState:UIControlStateNormal];
        isSale=1;
        [self sendPost];
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listModelArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JTSortModel * model=[_listModelArr objectAtIndex:indexPath.row];
    if ([model.type isEqualToString:@""]||model.type==nil)
    {
        return 80;
    }
    CGSize size=CGSizeMake(self.view.frame.size.width-150-10, MAXFLOAT);
    CGSize autoSize=[model.type boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size;
    if (autoSize.height<20)
    {
        autoSize.height=20;
    }
    return 60+autoSize.height;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JTDianpuPersonalGoodsListTabViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell=[[JTDianpuPersonalGoodsListTabViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
     JTSortModel * model=[_listModelArr objectAtIndex:indexPath.row];
    if(model.imgUrlStr==nil)
    {
      model.imgUrlStr=@"";
    }
    [cell.imgView setImageWithURL:[NSURL URLWithString:model.imgUrlStr] placeholderImage:[UIImage imageNamed:@"adapter_default_icon.png"]];
    cell.titleLab.text=model.title;
    cell.typeValueLab.text=model.type;
    CGSize size=CGSizeMake(self.view.frame.size.width-150-10, MAXFLOAT);
    CGSize autoSize=[model.type boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: cell.typeValueLab.font} context:nil].size;
    if (autoSize.height<20)
    {
        autoSize.height=20;
    }
    cell.typeValueLab.frame=CGRectMake(140, 30, autoSize.width, autoSize.height);

    if (model.cost==nil)
    {
        model.cost=@"0";
    }
    cell.priceValueLab.text=[NSString stringWithFormat:@"%@元",model.cost];
    [cell refreshUI];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JTDianpuPersonalGoodsDetailViewController * detailVC=[[JTDianpuPersonalGoodsDetailViewController alloc] init];
    JTSortModel * model=[_listModelArr objectAtIndex:indexPath.row];
    detailVC.sortmodel=[[JTSortModel alloc] init];
    detailVC.sortmodel=model;
    [self.navigationController pushViewController:detailVC animated:YES];
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
    AppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
    if ([SOAPRequest checkNet])
    {
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",appdelegate.appUser.userShangjiaID],@"shopId",_searchWord,@"name",[NSString stringWithFormat:@"%d",isSale],@"onShelves",@"1",@"currentPageNo",@"20",@"pageSize", nil];
        NSDictionary * zaojiaoDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_GetMerchantShopGoodsPage] jsonDic:jsondic]];
        if ([[NSString stringWithFormat:@"%@",[zaojiaoDic objectForKey:@"resultCode"]]isEqualToString:@"1000"])
        {
            
            if (q==3)
            {
                if ([[[zaojiaoDic objectForKey:@"merchantGoodsPage"] objectForKey:@"totalCount"] intValue]==0)
                {
                    NSString * str=@"未找到符合条件的数据！";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                    return;
                }
                NSArray * zaojiaoListArr=[[zaojiaoDic objectForKey:@"merchantGoodsPage"] objectForKey:@"list"];
                for (int i=0; i<zaojiaoListArr.count; i++)
                {
                    JTSortModel * sortModel=[[JTSortModel alloc] init];
                    sortModel.idStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"];
                    sortModel.fuId=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"shopId"];
                    sortModel.title=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"name"];
                    sortModel.type=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"typeValue"];
                    sortModel.cost=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"price"];
                    sortModel.isCanSeal=[NSString stringWithFormat:@"%@",[[zaojiaoListArr objectAtIndex:i] objectForKey:@"onShelves"]];
                    sortModel.imgUrlStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"imgUrl"];
                    [_listModelArr addObject:sortModel];
                   
                }
                q=6;
            }
            else
            {
                NSArray * zaojiaoListArr=[[zaojiaoDic objectForKey:@"merchantGoodsPage"] objectForKey:@"list"];;
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
                        sortModel.fuId=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"shopId"];
                        sortModel.title=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"name"];
                        sortModel.type=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"typeValue"];
                        sortModel.cost=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"price"];
                        sortModel.isCanSeal=[NSString stringWithFormat:@"%@",[[zaojiaoListArr objectAtIndex:i] objectForKey:@"onShelves"]];
                        sortModel.imgUrlStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"imgUrl"];
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
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",appdelegate.appUser.userShangjiaID],@"shopId",_searchWord,@"name",[NSString stringWithFormat:@"%d",isSale],@"onShelves",[NSString stringWithFormat:@"%d",pageNum],@"currentPageNo",@"20",@"pageSize", nil];
        NSDictionary * zaojiaoDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_GetMerchantShopGoodsPage] jsonDic:jsondic]];
        if ([[NSString stringWithFormat:@"%@",[zaojiaoDic objectForKey:@"resultCode"]] isEqualToString:@"1000"])
        {
            if ([[[zaojiaoDic objectForKey:@"merchantGoodsPage"] objectForKey:@"list"] count]==0)
            {
                NSString * str=@"已全部加载完毕！";
                [JTAlertViewAnimation startAnimation:str view:self.view];
                pageNum--;
                return;
            }
            NSArray * zaojiaoListArr=[[zaojiaoDic objectForKey:@"merchantGoodsPage"] objectForKey:@"list"];
            for (int i=0; i<zaojiaoListArr.count; i++)
            {
                JTSortModel * sortModel=[[JTSortModel alloc] init];
                sortModel.idStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"];
                sortModel.fuId=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"shopId"];
                sortModel.title=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"name"];
                sortModel.type=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"typeValue"];
                sortModel.cost=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"price"];
                sortModel.isCanSeal=[NSString stringWithFormat:@"%@",[[zaojiaoListArr objectAtIndex:i] objectForKey:@"onShelves"]];
                sortModel.imgUrlStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"imgUrl"];
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
