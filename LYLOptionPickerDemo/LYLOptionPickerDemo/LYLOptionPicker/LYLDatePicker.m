//
//  LYLDatePicker.m
//  LYLOptionPickerDemo
//
//  Created by Rainy on 2017/10/17.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "LYLDatePicker.h"
#import "LYLOptionPickerHeader.h"

@interface LYLDatePicker ()

@property(nonatomic,strong)UIDatePicker *datePickerView;

@property(nonatomic,strong)UIView *determineView;

@property(nonatomic,strong)UIView *backView;

@property(nonatomic,strong)UIView *currentView;

@end

@implementation LYLDatePicker

+ (instancetype)sharedDatePicker {
    
    static LYLDatePicker *datePicker = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!datePicker) {
            datePicker = [LYLDatePicker new];
        }
    });
    return datePicker;
}

static void(^_determineChoose)(NSString *dateString);
+ (void)showDateDetermineChooseInView:(UIView *)view
                      determineChoose:(void(^)(NSString *dateString))determineChoose
{
    [LYLDatePicker sharedDatePicker].currentView = view;
    [[LYLDatePicker sharedDatePicker] showDateDetermineChoose:determineChoose];
}
- (void)showDateDetermineChoose:(void(^)(NSString *dateString))determineChoose
{
    _determineChoose = determineChoose;
    [self clearViews];
    [self.currentView addSubview:self.backView];
    [self.currentView addSubview:self.datePickerView];
    [self.currentView addSubview:self.determineView];
    [UIView animateWithDuration:kPrompt_DismisTime animations:^{
        
        self.backView.alpha = kAlpha;
        self.datePickerView.Y = self.currentView.Sh - self.datePickerView.Sh;
        self.determineView.Y = self.datePickerView.Y - 30;
    }];
}
- (void)disapper
{
    [UIView animateWithDuration:kPrompt_DismisTime animations:^{
        
        self.backView.alpha = 0;
        self.datePickerView.Y = self.currentView.Sh + 30;
        self.determineView.Y = self.currentView.Sh;
        
    } completion:^(BOOL finished) {
        
        [self clearViews];
        
    }];
}
- (void)clearViews
{
    [self.backView removeFromSuperview];
    [self.datePickerView removeFromSuperview];
    [self.determineView removeFromSuperview];
    
    self.backView = nil;
    self.datePickerView = nil;
    self.determineView = nil;
}

- (void)determineAction:(UIButton *)BT
{
    NSDate *date = self.datePickerView.date;
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSString *dateString = [format stringFromDate:date];
    _determineChoose(dateString);
    [self disapper];
}
#pragma mark - lazy
- (UIDatePicker *)datePickerView
{
    if (!_datePickerView) {
        
        _datePickerView = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.currentView.Sh + 30, self.currentView.Sw, self.currentView.Sh/4)];
        _datePickerView.backgroundColor = kWhiteColor;
        
        _datePickerView.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_ch"];
        _datePickerView.timeZone = [NSTimeZone timeZoneWithName:@"GTM+8"];
        
        _datePickerView.datePickerMode = UIDatePickerModeDate;
    }
    return _datePickerView;
}
- (UIView *)determineView
{
    if (!_determineView) {
        
        _determineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.currentView.Sh, self.currentView.Sw, 30)];
        _determineView.backgroundColor = kWhiteColor;
        UIButton *determineBT = [UIButton buttonWithType:UIButtonTypeSystem];
        [determineBT setTitleColor:kThemeColor forState:UIControlStateNormal];
        [determineBT setTitle:@"确定" forState:UIControlStateNormal];
        determineBT.frame = CGRectMake(_determineView.Sw - 70, 0, 70, 30);
        determineBT.titleLabel.font = kSeventeenFontSize;
        [determineBT addTarget:self action:@selector(determineAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_determineView addSubview:determineBT];
    }
    return _determineView;
}
-(UIView *)backView
{
    if (!_backView) {
        
        _backView = [[UIView alloc]initWithFrame:self.currentView.bounds];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapper)];
        _backView.userInteractionEnabled = YES;
        [_backView addGestureRecognizer:tap];
    }
    return _backView;
}

@end
