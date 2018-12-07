//
//  MyLoader.h
//  NickelFoxDemo
//
//  Created by Ruchin Somal on 07/12/18.
//  Copyright © 2018 Ruchin Somal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLoader : UIView
+ (void)showLoadingView;
+ (void)hideLoadingView;
+ (void)showLoadingView:(UIView *)view;
+ (void)hideLoadingView:(UIView *)view;
+ (UIImage *) imageWithView:(UIView *)view;
@end
