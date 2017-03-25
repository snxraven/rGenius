//  TableViewController.m
//  rGenius - 1.0
//  Created by Raven Scott on 03/24/17.



#import "TableViewController.h"
#import "AFHTTPSessionManager.h"
#import "UIImageView+AFNetworking.h"
#import "Ninja.h"
#import "DetailViewController.h"

@interface TableViewController ()

@property (nonatomic, strong)NSArray *ninjas;



@end


@implementation TableViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"rGenius";
    // first we create a button and set it's properties
    UIBarButtonItem *myButton = [[UIBarButtonItem alloc]init];
    myButton.action = @selector(aboutAlert);
    myButton.title = @"About";
    myButton.target = self;
    
    // then we add the button to the navigation bar
    self.navigationItem.rightBarButtonItem = myButton;
    
    [self loadNinjas];
    
    // Remove empty cells
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void) aboutAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"About rGenius"
                                                    message:@"Raven Scott\nrGenius\nVersion 1.0"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    [alert show];


    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.ninjas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.ninjas[indexPath.row] name];
    
   // [cell.imageView setImageWithURL:[NSURL URLWithString:[self.ninjas[indexPath.row] thumbnail]]
     //              placeholderImage:[UIImage imageNamed:@"50-50.jpg"]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

#pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Get the new view controller using [segue destinationViewController].
    DetailViewController *detailvc = [segue destinationViewController];
    
    // Pass the selected object to the new view controller.
    NSIndexPath *index = self.tableView.indexPathForSelectedRow;
    Ninja *ninja = self.ninjas[index.row];
    
    detailvc.ninja = ninja;
}

- (void)loadNinjas {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"https://jbbar.ml/rgenius/data.json" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSArray *jsonArray = (NSArray *)responseObject;
        NSMutableArray *tempNinjas = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in jsonArray) {
            Ninja *ninja = [[Ninja alloc] initWithDictionary:dic];
            [tempNinjas addObject:ninja];
        }
        
        self.ninjas = [[NSArray alloc] initWithArray:tempNinjas];
        tempNinjas = nil;
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Ninjas"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];

}

@end
