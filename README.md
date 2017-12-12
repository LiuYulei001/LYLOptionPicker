# LYLOptionPicker
封装的简易方便的时间选择器、选项选择器！

1.时间选择器 LYLDatePicker ：

view 需要展示在某个视图，

determineChoose 回调时返回选择的时间字符串；


+ (void)showDateDetermineChooseInView:(UIView *)view
                      determineChoose:(void(^)(NSString *dateString))determineChoose;
                      
2.选项选择器 LYLOptionPicker ：

view 需要展示在某个视图，

dataSource 需要展示的选项 格式为@[@[@"string",@"string"...],@[@"string",@"string"...]...,]

determineChoose 回调时返回选中的item字符串和各个item的下标 均为正序数组；


+ (void)showOptionPickerInView:(UIView *)view
                    dataSource:(NSArray <NSArray <NSString *>*>*)dataSource
               determineChoose:(DetermineChoose)determineChoose;
