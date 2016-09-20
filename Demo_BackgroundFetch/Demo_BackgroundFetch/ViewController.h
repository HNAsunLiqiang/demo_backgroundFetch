//
//  ViewController.h
//  Demo_BackgroundFetch
//
//  Created by 孙立强 on 16/9/18.
//  Copyright © 2016年 孙立强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController


- (void)insertNewObjectForFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

@end

