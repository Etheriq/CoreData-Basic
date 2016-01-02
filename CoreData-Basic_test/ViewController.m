//
//  ViewController.m
//  CoreData-Basic_test
//
//  Created by Yuriy T on 16.12.15.
//  Copyright © 2015 Yuriy T. All rights reserved.
//

#import "ViewController.h"
#import "DataManager.h"

@interface ViewController ()

@property(strong, nonatomic) NSManagedObjectContext *managedContext;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSManagedObjectContext *) managedContext {
    
    if (!_managedContext) {
        _managedContext = [[DataManager Manager] managedObjectContext];
    }
    
    return _managedContext;
}

@end
