//
//  LYLOptionPicker.m
//  LYLOptionPickerDemo
//
//  Created by Rainy on 2017/12/12.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "LYLOptionPicker.h"
#import "LYLOptionPickerHeader.h"

@interface LYLOptionPicker ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)UIPickerView *optionPickerView;

@property(nonatomic,strong)NSArray *dataSource;

@property(nonatomic,strong)UIView *determineView;

@property(nonatomic,strong)UIView *backView;

@property(nonatomic,strong)UIView *currentView;

@end

@implementation LYLOptionPicker

+ (instancetype)sharedOptionPicker {
    
    static LYLOptionPicker *optionPicker = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!optionPicker) {
            optionPicker = [LYLOptionPicker new];
        }
    });
    return optionPicker;
}

static DetermineChoose _determineChoose;
+ (void)showOptionPickerInView:(UIView *)view
                    dataSource:(NSArray *)dataSource
               determineChoose:(DetermineChoose)determineChoose
{
    [LYLOptionPicker sharedOptionPicker].currentView = view;
    [[LYLOptionPicker sharedOptionPicker] showOptionPicker:dataSource determineChoose:determineChoose];
}
- (void)showOptionPicker:(NSArray *)dataSource
         determineChoose:(DetermineChoose)determineChoose
{
    _determineChoose = determineChoose;
    self.dataSource = dataSource;
    [self clearViews];
    [self.currentView addSubview:self.backView];
    [self.currentView addSubview:self.optionPickerView];
    [self.currentView addSubview:self.determineView];
    [UIView animateWithDuration:kPrompt_DismisTime animations:^{
        
        self.backView.alpha = kAlpha;
        self.optionPickerView.Y = self.currentView.Sh - self.optionPickerView.Sh;
        self.determineView.Y = self.optionPickerView.Y - 30;
    }];
}
- (void)disapper
{
    [UIView animateWithDuration:kPrompt_DismisTime animations:^{
        
        self.backView.alpha = 0;
        self.optionPickerView.Y = self.currentView.Sh + 30;
        self.determineView.Y = self.currentView.Sh;
        
    } completion:^(BOOL finished) {
        
        [self clearViews];
        
    }];
}
- (void)clearViews
{
    [self.backView removeFromSuperview];
    [self.optionPickerView removeFromSuperview];
    [self.determineView removeFromSuperview];
    
    self.backView = nil;
    self.optionPickerView = nil;
    self.determineView = nil;
}


#pragma mark UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.dataSource.count;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.dataSource[component] count];
}
#pragma mark UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.dataSource[component][row];
}

- (void)determineAction:(UIButton *)BT
{
    NSMutableArray *indexes = [NSMutableArray array];
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i < self.dataSource.count; i++) {
        NSInteger row = [self.optionPickerView selectedRowInComponent:i];
        [items addObject:self.dataSource[i][row]];
        [indexes addObject:[NSString stringWithFormat:@"%ld",row]];
    }
    
    [self disapper];
    _determineChoose(indexes,items);
}

#pragma mark - lazy
- (UIPickerView *)optionPickerView
{
    if (!_optionPickerView) {
        
        _optionPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, self.currentView.Sh + 30, self.currentView.Sw, self.currentView.Sh/4)];
        _optionPickerView.showsSelectionIndicator = YES;
        _optionPickerView.backgroundColor = kWhiteColor;
        _optionPickerView.delegate = self;
        _optionPickerView.dataSource = self;
    }
    return _optionPickerView;
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
