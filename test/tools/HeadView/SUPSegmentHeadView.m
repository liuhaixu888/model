//
//  DFSegmentHeadView.m
//  SinoCommunity
//
//  Created by df on 2017/4/28.
//  Copyright © 2017年 df. All rights reserved.
//

#import "SUPSegmentHeadView.h"

@interface SUPSegmentHeadView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectV;

@property (nonatomic, assign) NSInteger selectIndex;


@end

@implementation SUPSegmentHeadView

- (void)setDelegate:(id<SUPSegmentHeadViewDelegate>)delegate {
    
    _delegate = delegate;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal ;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    
    self.collectV = collectionView;
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    self.selectIndex = 0;
    
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsHorizontalScrollIndicator = NO;;
    
    [self addSubview:collectionView];
    
    [self.collectV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [collectionView registerClass:[SUPSegmentViewCell class] forCellWithReuseIdentifier:@"SUPSegmentViewCell"];
    
    self.textLabelColor = [UIColor orangeColor];
    self.linelColor = [UIColor orangeColor];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 5;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *str = @"待处理";
//
//    UIFont * font = [UIFont systemFontOfSize:13];
//    CGSize size = [str sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
//
//    return CGSizeMake(size.width + 25, 30);
//    return [self.delegate dfSegmentItemSimeWithIndex:indexPath.item];
    return CGSizeMake((self.frame.size.width-90)/4, 30);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SUPSegmentViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SUPSegmentViewCell" forIndexPath:indexPath];
    
    cell.labelText.text = @"待处理";
    
    if (self.selectIndex == indexPath.item) {
        
        cell.lineView.backgroundColor = self.linelColor;
        cell.labelText.textColor = self.textLabelColor;
        
         [UIView animateWithDuration:0.3 animations:^{
            cell.lineView.transform = CGAffineTransformMakeScale(1.2, 1.2);
            cell.labelText.transform = CGAffineTransformMakeScale(1.2, 1.2);
        }];

    }else {
        cell.lineView.backgroundColor = [UIColor clearColor];
        cell.labelText.textColor = [UIColor blackColor];
        
        cell.lineView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        cell.labelText.transform = CGAffineTransformMakeScale(1.0, 1.0);


    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.selectIndex == indexPath.row) {
        
        return;
    }
    
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    [self.collectV reloadData];
    
    self.selectIndex = indexPath.row;
    NSLog(@"didSelectItemAtIndexPath --------------%d", indexPath.row);
    [self.delegate selectWithIndex:indexPath.row];
}

- (void)setSelectItemWithIndex:(NSInteger)index {
    
//    if (index > [self.delegate dfSegmentNumber] || index < 0) {
//
//        return;
//    }
    
    [self.collectV scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:YES];
    
    self.selectIndex = index;
    
    [self.collectV reloadData];
}

@end

@implementation SUPSegmentViewCell

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.labelText = [UILabel new];
        
        [self.contentView addSubview:self.labelText];
        
        self.labelText.font = [UIFont systemFontOfSize:13];
        
        self.labelText.textAlignment = NSTextAlignmentCenter;
        
        [self.labelText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.bottom.mas_equalTo(-4);
            make.centerX.equalTo(self.contentView);
        }];
        
        
        
        self.lineView = [UIView new];
        
        [self.contentView addSubview:self.lineView];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.labelText.mas_bottom);
            make.height.equalTo(@2);
            make.left.right.equalTo(self.labelText);
        }];
        
    }
    return self;

}

@end
