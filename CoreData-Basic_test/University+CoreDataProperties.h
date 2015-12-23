//
//  University+CoreDataProperties.h
//  CoreData-Basic_test
//
//  Created by Yuriy T on 23.12.15.
//  Copyright © 2015 Yuriy T. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "University.h"
#import "Student.h"
#import "Course.h"

NS_ASSUME_NONNULL_BEGIN

@interface University (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Student *> *students;
@property (nullable, nonatomic, retain) NSSet<Course *> *courses;

@end

@interface University (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(Student *)value;
- (void)removeStudentsObject:(Student *)value;
- (void)addStudents:(NSSet<Student *> *)values;
- (void)removeStudents:(NSSet<Student *> *)values;

- (void)addCoursesObject:(Course *)value;
- (void)removeCoursesObject:(Course *)value;
- (void)addCourses:(NSSet<Course *> *)values;
- (void)removeCourses:(NSSet<Course *> *)values;

@end

NS_ASSUME_NONNULL_END
