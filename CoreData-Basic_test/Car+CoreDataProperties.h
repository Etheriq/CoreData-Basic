//
//  Car+CoreDataProperties.h
//  CoreData-Basic_test
//
//  Created by Yuriy T on 17.12.15.
//  Copyright © 2015 Yuriy T. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Car.h"
#import "Student.h"

NS_ASSUME_NONNULL_BEGIN

@interface Car (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *model;
@property (nullable, nonatomic, retain) Student *owner;

@end

NS_ASSUME_NONNULL_END
