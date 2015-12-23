//
//  Car.m
//  CoreData-Basic_test
//
//  Created by Yuriy T on 17.12.15.
//  Copyright © 2015 Yuriy T. All rights reserved.
//

#import "Car.h"
#import "Student.h"

@implementation Car

// Insert code here to add functionality to your managed object subclass

- (BOOL) validateForDelete:(NSError * _Nullable __autoreleasing *)error {
    
    NSLog(@"Car validateForDelete");
    
    return YES;
}

@end
