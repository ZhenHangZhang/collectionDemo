//
//  ViewController.m
//  collectionDemo
//
//  Created by zhanghangzhen on 2016/11/18.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import "ViewController.h"
#import "CustomCollectionViewCell.h"
#import "CustomCollectionReusableView.h"
#import "HeaderFlowLayout.h"




//宏定义宽高
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

static NSString *const CustomCollectionHeadId = @"CustomCollectionReusableViewId";
static NSString *const cellId = @"CustomCollectionViewCellId";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HeaderFlowLayout *larOut = [[HeaderFlowLayout alloc]init];
    [larOut setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    
    UICollectionViewFlowLayout *flat = [[UICollectionViewFlowLayout alloc]init];
    flat.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    [self.collectionView setCollectionViewLayout:larOut];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CustomCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CustomCollectionHeadId];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CustomCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellId];
}

#pragma mark collectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}
//设置元素大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(SCREEN_WIDTH/2 - 5, 300);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    NSInteger tag = 10;
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:tag];
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.tag = tag;
        label.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:label];
    }
    
    label.text = [NSString stringWithFormat:@"第%@个item",@(indexPath.row)];
    [label sizeToFit];
    return cell;
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //UICollectionView被选中时调用的方法
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionReusableView *headReusableView;
    //此处是headerView
    if (kind == UICollectionElementKindSectionHeader) {
        headReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:CustomCollectionHeadId forIndexPath:indexPath];
        headReusableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 250);
    }
    return headReusableView;
}

//执行的 headerView 代理  返回 headerView 的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
        return CGSizeMake(SCREEN_WIDTH, 250);
}

@end
