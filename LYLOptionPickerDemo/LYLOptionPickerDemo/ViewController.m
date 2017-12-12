//
//  ViewController.m
//  LYLOptionPickerDemo
//
//  Created by Rainy on 2017/12/12.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "ViewController.h"
#import "LYLOptionPicker.h"
#import "LYLDatePicker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)optionPicker:(id)sender {
    
    [LYLOptionPicker showOptionPickerInView:self.view dataSource:@[@[@"a",@"b",@"c",@"d",@"e",@"f"],@[@"a",@"b",@"c",@"d",@"e",@"f"],@[@"a",@"b",@"c",@"d",@"e",@"f"],@[@"a",@"b",@"c",@"d",@"e",@"f"]] determineChoose:^(NSArray *indexes, NSArray *selectedItems) {
        
        NSLog(@"%@,%@",indexes,selectedItems);
        
    }];
}
- (IBAction)datePicker:(id)sender {
    
    [LYLDatePicker showDateDetermineChooseInView:self.view determineChoose:^(NSString *dateString) {
        NSLog(@"%@",dateString);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
