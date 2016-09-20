//
//  ViewController.m
//  Demo_BackgroundFetch
//
//  Created by 孙立强 on 16/9/18.
//  Copyright © 2016年 孙立强. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic) NSMutableArray *objects;
@property (nonatomic) NSArray *possibleTableData;
@property (nonatomic) int numberOfnewPosts;
@property (nonatomic) UIRefreshControl *refreshControl;
@end

@implementation ViewController

@dynamic refreshControl;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.possibleTableData = [NSArray arrayWithObjects:@"Spicy garlic Lime Chicken",@"Apple Crisp II",@"Eggplant Parmesan II",@"Pumpkin Ginger Cupcakes",@"Easy Lasagna", @"Puttanesca", @"Alfredo Sauce", nil];
    self.navigationItem.title = @"Delicious Dishes";
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(insertNewObject:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}
-(NSMutableArray *)objects
{
    if (!_objects) {
        _objects = [NSMutableArray array];
    }
    return _objects;
}
-(void)insertObject:(id)object
{
    [self.objects addObject:object];
}

- (void)insertNewObject:(id)sender
{
    self.numberOfnewPosts = [self getRandomNumberBetween:0 to:4];
    NSLog(@"%d new fetched objects",self.numberOfnewPosts);
    for(int i = 0; i < self.numberOfnewPosts; i++){
        int addPost = [self getRandomNumberBetween:0 to:(int)([self.possibleTableData count]-1)];
        [self insertObject:[self.possibleTableData objectAtIndex:addPost]];
    }
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.objects[indexPath.row];
    if(indexPath.row < self.numberOfnewPosts){
        cell.backgroundColor = [UIColor yellowColor];
    }
    else
        cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
-(int)getRandomNumberBetween:(int)from to:(int)to {
    return (int)from + arc4random() % (to-from+1);
}
- (void)insertNewObjectForFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"Update the tableview.");
    self.numberOfnewPosts = [self getRandomNumberBetween:0 to:4];
    NSLog(@"%d new fetched objects",self.numberOfnewPosts);
    if (self.possibleTableData.count == 0) {
        self.possibleTableData = [NSArray arrayWithObjects:@"Spicy garlic Lime Chicken",@"Apple Crisp II",@"Eggplant Parmesan II",@"Pumpkin Ginger Cupcakes",@"Easy Lasagna", @"Puttanesca", @"Alfredo Sauce", nil];
    }
    for(int i = 0; i < self.numberOfnewPosts; i++){
        int addPost = [self getRandomNumberBetween:0 to:(int)([self.possibleTableData count]-1)];
        [self insertObject:[self.possibleTableData objectAtIndex:addPost]];
    }
    [self.tableView reloadData];
    /*
     At the end of the fetch, invoke the completion handler.
     */
    completionHandler(UIBackgroundFetchResultNewData);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
