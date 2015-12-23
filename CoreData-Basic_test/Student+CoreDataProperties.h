//
//  Student+CoreDataProperties.h
//  CoreData-Basic_test
//
//  Created by Yuriy T on 23.12.15.
//  Copyright © 2015 Yuriy T. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Student.h"
#import "Course.h"
#import "Car.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *birthDay;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSNumber *score;
@property (nullable, nonatomic, retain) Car *car;
@property (nullable, nonatomic, retain) University *university;
@property (nullable, nonatomic, retain) NSSet<Course *> *courses;

@end

@interface Student (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(Course *)value;
- (void)removeCoursesObject:(Course *)value;
- (void)addCourses:(NSSet<Course *> *)values;
- (void)removeCourses:(NSSet<Course *> *)values;

@end

NS_ASSUME_NONNULL_END
