//
//  LYLOptionPicker.h
//  LYLOptionPickerDemo
//
//  Created by Rainy on 2017/12/12.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LYLOptionPicker : NSObject

typedef void(^DetermineChoose)(NSArray *indexes,id selectedItems);


+ (void)showOptionPickerInView:(UIView *)view
                    dataSource:(NSArray <NSArray <NSString *>*>*)dataSource
               determineChoose:(DetermineChoose)determineChoose;

@end
