//
//  LYLDatePicker.h
//  LYLOptionPickerDemo
//
//  Created by Rainy on 2017/10/17.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYLDatePicker : NSObject

+ (void)showDateDetermineChooseInView:(UIView *)view
                      determineChoose:(void(^)(NSString *dateString))determineChoose;

@end
