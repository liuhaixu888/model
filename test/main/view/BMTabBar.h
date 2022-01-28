//
//  BMTabBar.h
//  test
//
//  Created by tdem on 2021/11/30.
//  Copyright © 2021 tdem. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSTabBarItem;


#pragma mark -
#pragma mark WSTabBarItem
#pragma mark -
@interface WSTabBarItem : UIView

@property (assign, nonatomic, getter=isSelected) BOOL selected;

@property (copy, nonatomic) void (^_Nullable itemClick)(WSTabBarItem * _Nonnull item);

+ (nonnull instancetype)tabBarItemWithTitle:(nonnull NSString *)title itemImage:(nonnull UIImage *)image selectedImage:(nullable UIImage *)selImage;

@end


#pragma mark -
#pragma mark  WSTabBar
#pragma mark -

typedef void(^barItemClickBlock) (NSInteger);
@interface WSTabBar : UIView


@property (assign, nonatomic, readonly) NSInteger selectedIndex;

@property (strong, nonatomic, nullable,) NSArray<WSTabBarItem *> *items;

+ (nonnull instancetype)tabBarWithItems:(nullable NSArray<WSTabBarItem *> *)items itemClick:(nonnull barItemClickBlock) myblock;;


@end
