//
//  DataManager.h
//  CoreData-Basic_test
//
//  Created by Yuriy T on 02.01.16.
//  Copyright © 2016 Yuriy T. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Student.h"
#import "Car.h"
#import "University.h"
#import "Course.h"

@interface DataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (NSArray *) gueryForCourseEntity;
- (NSArray*) getAllStudents:(NSString*) entity;
- (NSArray*) printAll;
- (void) printEntity:(NSArray*) entities;
- (void) loadFixtures;

+ (DataManager *) Manager;

@end
