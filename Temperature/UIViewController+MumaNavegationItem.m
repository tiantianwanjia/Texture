//
//  UIViewController+MumaNavegation.m
//  Temperature
//
//  Created by muma on 2020/10/29.
//  Copyright © 2020 yuanwenxue. All rights reserved.
//

#import "UIViewController+MumaNavegationItem.h"


@implementation UIViewController (MumaNavegationItem)
/**
*导航栏左侧添加按钮
*
*@param title 按钮名称
*/
- (void)muma_setLeftItemWithTitle:(NSString *)title
{
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStyleDone target:self action:@selector(muma_leftBarAction:)];
    self.navigationItem.leftBarButtonItem = left;
}

/**
*导航栏左侧添加按钮
*
*@param title 按钮名称
*@param titleColor 文字颜色
*/
- (void)muma_setLeftItemWithTitle:(NSString *)title titleColor:(UIColor*)titleColor;
{

    UIBarButtonItem * left =[[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(muma_leftBarAction:)];
    [left setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName, nil] forState:UIControlStateNormal];
    left.tintColor = titleColor;
    self.navigationItem.leftBarButtonItem = left;
   
}

/**
*导航栏左侧添加按钮
*
*@param image 图片名称
*/
- (void)muma_setLeftItemWithImage:(UIImage *)image{
    UIImage * editimgae = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftImageItem = [[UIBarButtonItem alloc]initWithImage:editimgae style:UIBarButtonItemStyleDone target:self action:@selector(muma_leftBarAction:)];
    self.navigationItem.leftBarButtonItem = leftImageItem;
}

/**
*导航栏左侧添加按钮
*
*@param image 图片名称
*@param title 按钮名称
*@param titleColor 文字颜色
*/
- (void)muma_setLeftItemWithImage:(UIImage *)image andwithTitle:(NSString *)title  titleColor:(UIColor*)titleColor
{
    UIButton * but =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 60)];
    [but setImage:image forState:UIControlStateNormal];
    [but setImage:image forState:UIControlStateSelected];
    [but setImage:image forState:UIControlStateHighlighted];
    [but setTitle:title forState:UIControlStateNormal];
    [but setTitleColor:titleColor forState:UIControlStateNormal];
    but.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    but.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [but addTarget:self action:@selector(muma_leftBarAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithCustomView:but];
    self.navigationItem.leftBarButtonItem = left;
}

/**
*导航栏左侧添加按钮
*
*@param view view视图
*/
- (void)muma_setLeftItemWithView:(UIView*)view{
    UIBarButtonItem * left =[[UIBarButtonItem alloc]initWithCustomView:view];
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(muma_leftBarAction:)];
    [view addGestureRecognizer:tap];
    self.navigationItem.leftBarButtonItem=left;
}

/**
 *导航栏右侧添加按钮
 *
 *@param title 按钮名称
 */
- (void)muma_setRightItemWithTitle:(NSString*)title{
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(muma_rightBarAction:)];
    right.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = right;
}

/**
 *导航栏右侧添加按钮
 *
 *@param title 按钮名称
 *@param titleColor 文字颜色
 */
- (void)muma_setRightItemWithTitle:(NSString *)title titleColor:(UIColor*)titleColor{
    UIBarButtonItem * right =[[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(muma_rightBarAction:)];
    [right setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName, nil] forState:UIControlStateNormal];
    [right setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName, nil] forState:UIControlStateSelected];
    right.tintColor = titleColor;
    self.navigationItem.rightBarButtonItem = right;
}

/**
 *导航栏右侧添加按钮
 *
 *@param image 图片名称
 */
- (void)muma_setRightItemWithImage:(UIImage*)image{
    UIImage * editimgae = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * rightImage = [[UIBarButtonItem alloc]initWithImage:editimgae style:UIBarButtonItemStyleDone target:self action:@selector(muma_rightBarAction:)];
    self.navigationItem.rightBarButtonItem = rightImage;
}

/**
 *导航栏右侧添加按钮
 *
 *@param image 图片名称
 *@param title 按钮名称
 *@param titleColor 文字颜色
 */
- (void)muma_setRightItemWithImage:(UIImage*)image andwithTitle:(NSString *)title titleColor:(UIColor*)titleColor{
    UIButton * but = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 60)];
    [but setImage:image forState:UIControlStateNormal];
    [but setTitle:title forState:UIControlStateNormal];
    [but setTitleColor:titleColor forState:UIControlStateNormal];
    [but setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //but.contentEdgeInsets=UIEdgeInsetsMake(0, -20, 0, 25);
    [but addTarget:self action:@selector(muma_rightBarAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithCustomView:but];
    self.navigationItem.rightBarButtonItem = right;
}

/**
 *导航栏右侧添加按钮
 *
 *@param view view视图
 */
- (void)muma_setRightItemWithView:(UIView*)view{
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithCustomView:view];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(muma_rightBarAction:)];
    [view addGestureRecognizer:tap];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)muma_leftBarAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)muma_rightBarAction:(UIButton *)sender
{
    
}

@end
