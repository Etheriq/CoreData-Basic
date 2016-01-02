//
//  DataManager.m
//  CoreData-Basic_test
//
//  Created by Yuriy T on 02.01.16.
//  Copyright © 2016 Yuriy T. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

#pragma mark - SingleTone Constructor

+ (DataManager *) Manager {
    static DataManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataManager alloc] init];
    });
    
    return manager;
}

#pragma mark - Fixtures

-(void) loadFixtures {
    [self removaAll];
    
    University *univer = [self createUniversity:@"Garvard"];
    
    NSArray *courses = @[
                         [self createCourse:[self getRandomStringWithLength:3]],
                         [self createCourse:[self getRandomStringWithLength:3]],
                         [self createCourse:[self getRandomStringWithLength:3]],
                         ];
    
    [univer addCourses:[NSSet setWithArray:courses]];
    
    for (int i = 0; i < 100; i++) {
        Student *student = [self createStudent:[self getRandomStringWithLength:5] andLastName:[self getRandomStringWithLength:5] andBirthDay:[NSDate dateWithTimeIntervalSinceNow:0] andScore:[NSNumber numberWithFloat:[self getRandomFloatFrom:1.5f andTo:3.9f]]];
        
        if (arc4random_uniform(1000) < 500) {
            Car *car = [self createCar:[self getRandomStringWithLength:5]];
            student.car = car;
        }
        student.university = univer;
        
        int number = arc4random() % [courses count];
        
        while ([student.courses count] < number) {
            Course *course = [courses objectAtIndex:arc4random() % [courses count]];
            if (![student.courses containsObject:course]) {
                [student addCoursesObject:course];
            }
        } //  end While
    }  // end for
    
    NSError *err = nil;
    if(![self.managedObjectContext save:&err]){
        NSLog(@"%@", [err localizedDescription]);
    }
}

# pragma mark - workWithObjects

- (Student *) createStudent:(NSString *)firstName andLastName:(NSString*) lastName andBirthDay:(NSDate*) birthDay andScore:(NSNumber*) score   {
    // Create
    
    Student *newSt = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    newSt.firstName = firstName;
    newSt.lastName = lastName;
    newSt.birthDay = birthDay;
    newSt.score = score;
    
    return newSt;
}

- (Car *) createCar:(NSString*) model {
    Car *car = [NSEntityDescription insertNewObjectForEntityForName:@"Car" inManagedObjectContext:self.managedObjectContext];
    car.model = model;
    
    return car;
}

- (University *) createUniversity:(NSString*) name {
    University *univer = [NSEntityDescription insertNewObjectForEntityForName:@"University" inManagedObjectContext:self.managedObjectContext];
    univer.name = name;
    
    return univer;
}

- (Course *) createCourse:(NSString*) name {
    Course *course = [NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:self.managedObjectContext];
    course.name = name;
    
    return course;
}

- (NSArray*) getAllStudents:(NSString*) entity {
    // Read
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:entity inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];
    [request setFetchBatchSize:25];   // подгружать по 25 штук
    // sorting (firstName then lastName)
    NSSortDescriptor *firstNameSort = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSSortDescriptor *lastNameSort = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    NSSortDescriptor *score = [[NSSortDescriptor alloc] initWithKey:@"score" ascending:NO];
    [request setSortDescriptors:@[score, firstNameSort, lastNameSort]];
//    NSArray *validNames = @[@"MfTse", @"LCpYM"];
    
//    NSPredicate *predicat = [NSPredicate predicateWithFormat:@"score > %f and score <= %f and courses.@count >= %d and firstName in %@", 2.1, 2.33, 2, validNames];
    //    NSPredicate *predicat = [NSPredicate predicateWithFormat:@"any score >= %f", 2.1];
    
    //    NSPredicate *predicat = [NSPredicate predicateWithFormat:@"@avg.students.score >= %f", 2.1];  //  for course entity example all courses where students with average score >= 2.1
    
//    [request setPredicate:predicat];
    
    
    NSError *errorReq = nil;
    
    NSArray *res = nil;
    if (!(res = [self.managedObjectContext executeFetchRequest:request error:&errorReq])) {
        NSLog(@"GetAll error: %@", [errorReq localizedDescription]);
    }
    
    return res;
}

-(NSArray *) gueryForCourseEntity {
    // Read
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Course" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];
    [request setFetchBatchSize:25];   // подгружать по 25 штук
    // sorting (firstName then lastName)
    NSSortDescriptor *nameDescr = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [request setSortDescriptors:@[nameDescr]];
    
    //    NSPredicate *predicat = [NSPredicate predicateWithFormat:@"@avg.students.score >= %f", 1.0];  //  for course entity example all courses where students with average score >= 2.1
    NSPredicate *predicat = [NSPredicate predicateWithFormat:@"subquery(students, $student, $student.car.model == %@).@count >= %d", @"BryzS", 1];
    [request setPredicate:predicat];
    
    
    NSError *errorReq = nil;
    
    NSArray *res = nil;
    if (!(res = [self.managedObjectContext executeFetchRequest:request error:&errorReq])) {
        NSLog(@"GetAll error: %@", [errorReq localizedDescription]);
    }
    
    return res;
}

- (void) printEntity:(NSArray*) entities{
    NSLog(@"rows: %li", [entities count]);
    for (id object in entities) {
        if ([object isKindOfClass:[Student class]]) {
            Student *student = (Student*)object;
            NSLog(@"%@ %@: score = %1.2f (Car is %@) (Univer is %@)", student.firstName, student.lastName, [student.score floatValue], student.car.model, student.university.name);
        } else if ([object isKindOfClass:[Car class]]) {
            Car *car = (Car*)object;
            NSLog(@"Car model is %@, Owner is %@ %@", car.model, car.owner.firstName, car.owner.lastName);
        } else if ([object isKindOfClass:[University class]]) {
            University *univer = (University*) object;
            NSLog(@"Univer name is %@, Students %li", univer.name, [univer.students count]);
        } else if ([object isKindOfClass:[Course class]]) {
            Course *cource = (Course*) object;
            NSLog(@"Course name is %@, Students %li", cource.name, [cource.students count]);
        }
    }
}

- (NSArray*) printAll {
    
    NSArray *all = [self getAllStudents:@"BaseObj"];
    NSLog(@"   *******************   ");
    
    [self printEntity:all];
    
    return all;
}

- (void) removaAll {
    NSArray *all = [self getAllStudents:@"BaseObj"];
    NSError *errorReq = nil;
    
    //  Delete
    for (id object in all) {
        [self.managedObjectContext deleteObject:object];
    }
    
    if(![self.managedObjectContext save:&errorReq]){
        NSLog(@"%@", [errorReq localizedDescription]);
    }
}

#pragma mark - Generators

- (CGFloat) getRandomFloatFrom:(CGFloat) from andTo:(CGFloat) to {
    
    return (from * 100 + arc4random_uniform(to * 1000 + .1f - from * 1000)) / 1000;
}

-(NSString *) getRandomStringWithLength: (int) len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    
    return randomString;
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.learn.objective-c.CoreData_Basic_test" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreData_Basic_test" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreData_Basic_test.sqlite"];
    NSError *error = nil;
    //    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
        
        
        //        // Report any error we got.
        //        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        //        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        //        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        //        dict[NSUnderlyingErrorKey] = error;
        //        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        //        // Replace this with code to handle the error appropriately.
        //        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        //        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        //        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end
