//
//  ViewController.h
//  SortPinyin
//
//  Created by iHope on 13-11-6.
//  Copyright (c) 2013年 Tamil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *sortHeaders;
}

@property (nonatomic, strong)NSMutableArray *resultArray;
@property (nonatomic, strong)NSMutableArray *sortedArray;

@end
