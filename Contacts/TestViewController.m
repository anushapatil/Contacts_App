//
//  TestViewController.m
//  Contacts
//
//  Created by Anusha Patil on 18/03/2016.
//  Copyright © 2016 Anusha Patil. All rights reserved.
//

#import "TestViewController.h"
#import "Contacts-swift.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)test
{
    //Calling Swift method from Objective C
    AddContactsModel *addContact = [[AddContactsModel alloc] init];
    [addContact testSwift];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
