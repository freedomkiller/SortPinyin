//
//  ViewController.m
//  SortPinyin
//
//  Created by iHope on 13-11-6.
//  Copyright (c) 2013年 Tamil. All rights reserved.
//

#import "ViewController.h"
#import "pinyin.h"
#import "ChineseString.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.resultArray = [NSMutableArray arrayWithObjects:@"中文",@"英文", @"德国", @"阿拉伯", @"任海丽", @"周晓栋",@"阿司法局了",@"撒旦法",@" 随碟附送",@"撒旦法",@"十多个人",  nil];
    self.sortedArray = [NSMutableArray arrayWithArray:[self getChinesArray:_resultArray]];
    
    
    for (NSString *string in _resultArray) {
        NSLog(@"--%@",string);
    }
    
    for (NSString *string in _sortedArray) {
        NSLog(@"==%@",string);
    }
    
    for (NSString *string in sortHeaders) {
        NSLog(@"333%@",string);
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray*)getChinesArray:(NSMutableArray*)arrToSort
{
    //创建一个临时的变动数组
    NSMutableArray *chineseStringsArray = [NSMutableArray array];
    for(int i =0; i < arrToSort.count; i++)
    {
        
        //创建一个临时的数据模型对象
        ChineseString *chineseString=[[ChineseString alloc]init];
        //给模型赋值
        chineseString.string=[NSString stringWithString:[arrToSort objectAtIndex:i]];
        
        if(chineseString.string==nil)
        {
            chineseString.string=@"";
        }
        if(![chineseString.string isEqualToString:@""])
        {
            //join(链接) the pinYin (letter字母) 链接到首字母
            NSString *pinYinResult = [NSString string];
            
            //按照数据模型中row的个数循环
            
            for(int j =0;j < chineseString.string.length; j++)
            {
                NSString *singlePinyinLetter = [[NSString stringWithFormat:@"%c",
                                                 pinyinFirstLetter([chineseString.string characterAtIndex:j])]uppercaseString];
                pinYinResult = [pinYinResult stringByAppendingString:singlePinyinLetter];
            }
            chineseString.pinYin = pinYinResult;
            
        } else {
            chineseString.pinYin =@"";
        }
        [chineseStringsArray addObject:chineseString];
    }
    
    //sort(排序) the ChineseStringArr by pinYin(首字母)
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin"ascending:YES]];
    
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
    
    NSMutableArray *arrayForArrays = [NSMutableArray array];
    
    BOOL checkValueAtIndex=NO; //flag to check
    
    NSMutableArray *TempArrForGrouping =nil;
    
    NSMutableArray *heads = [NSMutableArray array];
    
    for(int index =0; index < [chineseStringsArray count]; index++)
    {
        ChineseString *chineseStr = (ChineseString *)[chineseStringsArray objectAtIndex:index];
        
        NSMutableString *strchar= [NSMutableString stringWithString:chineseStr.pinYin];
        //sr containing here the first character of each string  (这里包含的每个字符串的第一个字符)
        NSString *sr= [strchar substringToIndex:1];
        //here I'm checking whether the character already in the selection header keys or not  (检查字符是否已经选择头键)
        
        if(![heads containsObject:[sr uppercaseString]])
        {
            [heads addObject:[sr uppercaseString]];
            
            TempArrForGrouping = [[NSMutableArray alloc]initWithObjects:nil];
            
            checkValueAtIndex = NO;
        }
        
        if([heads containsObject:[sr uppercaseString]])
        {
            [TempArrForGrouping addObject:[chineseStringsArray objectAtIndex:index]];
            
            if(checkValueAtIndex == NO)
            {
                [arrayForArrays addObject:TempArrForGrouping];
                checkValueAtIndex = YES;
            }
        }
        
    }
    
    sortHeaders = [NSMutableArray arrayWithArray:heads];
    return arrayForArrays;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return sortHeaders.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [_sortedArray objectAtIndex:section];
    return array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //行高
    return 44;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return sortHeaders;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSArray *array = [_sortedArray objectAtIndex:indexPath.section];
    ChineseString *china = [array objectAtIndex:indexPath.row];
    cell.textLabel.text = china.string;
    
    
    return cell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell");
}



@end
