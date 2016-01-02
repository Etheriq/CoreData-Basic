//
//  AppDelegate.m
//  CoreData-Basic_test
//
//  Created by Yuriy T on 16.12.15.
//  Copyright © 2015 Yuriy T. All rights reserved.
//

#import "AppDelegate.h"
#import "Student.h"
#import "Car.h"
#import "University.h"
#import "Course.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    self.managedObjectContext;
    
//    NSLog(@"%@", [self.managedObjectModel entitiesByName]);
    
    
/*
    ////   Write to db one record  KVC
    NSManagedObject *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    [student setValue:@"fName" forKey:@"firstName"];
    [student setValue:@"lName" forKey:@"lastName"];
    [student setValue:[NSDate dateWithTimeIntervalSinceReferenceDate:0] forKey:@"birthDay"];
    [student setValue:@3.8 forKey:@"score"];
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"not saved ((( %@", [error localizedDescription]);
    }
*/

/*
//   read from db records. KVC
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];
    [request setResultType:NSDictionaryResultType];
    NSError *errorReq = nil;
    NSArray *resultF = [self.managedObjectContext executeFetchRequest:request error:&errorReq];
    if (errorReq) {
        NSLog(@"error on fetch %@", [errorReq localizedDescription]);
    } else {
        NSLog(@"res: %@", resultF);
    }

    
    for (NSManagedObject *object in resultF) {
        NSLog(@"%@ - %@ - %@", [object valueForKey:@"firstName"], [object valueForKey:@"lastName"], [object valueForKey:@"score"]);
    }
*/
    
    
// ------  Models  --------
    
//    [self createStudent:@"StFN1" andLastName:@"StLN1" andBirthDay:[NSDate dateWithTimeIntervalSinceNow:0] andScore:@3.2f];
//    [self createStudent:@"StFN2" andLastName:@"StLN2" andBirthDay:[NSDate dateWithTimeIntervalSinceNow:4] andScore:@3.5f];
//    [self createStudent:@"StFN3" andLastName:@"StLN3" andBirthDay:[NSDate dateWithTimeIntervalSinceNow:2] andScore:@3.0f];
//    [self createStudent:@"StFN4" andLastName:@"StLN4" andBirthDay:[NSDate dateWithTimeIntervalSinceNow:-10] andScore:@4.2f];
//    [self createStudent:@"StFN5" andLastName:@"StLN5" andBirthDay:[NSDate dateWithTimeIntervalSinceNow:15] andScore:@3.1f];
    
    // With relationships

//    [self removaAll];
    
//    University *univer1 = [self createUniversity:@"Garvard"];
//
//    Student *student1 = [self createStudent:@"StFN1" andLastName:@"StLN1" andBirthDay:[NSDate dateWithTimeIntervalSinceNow:0] andScore:@3.8f];
//    Car *car1 = [self createCar:@"car1"];
//    student1.car = car1;
//
//    Student *student2 = [self createStudent:@"StFN2" andLastName:@"StLN2" andBirthDay:[NSDate dateWithTimeIntervalSinceNow:0] andScore:@3.3f];
//    Car *car2 = [self createCar:@"car2"];
//    student2.car = car2;
//    
//    [univer1 addStudentsObject:student1];  // or student1.university = univer1;
//    [univer1 addStudentsObject:student2];  // or student2.university = univer2;
//
//    Course *course1 = [self createCourse:@"course1"];
//    course1.universitet = univer1;
//    [course1 addStudentsObject:student1];
    
    // **********
        //  [(Course *)[student1.courses anyObject] name];
    // **********
//    [self printAll];

     // remove 1 student with her car via cascade
//    NSArray *students = [self getAllStudents:@"Student"];
//    if ([students count] > 0) {
//        Student *last = [students lastObject];
//        [self.managedObjectContext deleteObject:last];
//    }

    
    // remove car and student via nulify (the student must remain)
//    NSArray *cars = [self getAllStudents:@"Car"];
//    if ([cars count] > 0) {
//        Car *car = [cars lastObject];
//        [self.managedObjectContext deleteObject:car];
//    }
    
    // remove university
//    NSArray *univers = [self getAllStudents:@"University"];
//    if ([univers count] > 0) {
//        University *univer = [univers lastObject];
//        [self.managedObjectContext deleteObject:univer];
//    }
    
//    NSError *err = nil;
//    if(![self.managedObjectContext save:&err]){
//        NSLog(@"%@", [err localizedDescription]);
//    }

//    ********  Fetch  ************
    
//    [self loadFixtures];
    
    [self printEntity:[self getAllStudents:@"Student"]];
    NSLog(@"   *******************   ");
    [self printEntity:[self gueryForCourseEntity]];
    NSLog(@"   *******************   ");    
//    [self printAll];
    
    return YES;
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

//    NSError *err = nil;
//    if(![self.managedObjectContext save:&err]){  //  or [newSt.managedObjectContext save:nil];)
//        NSLog(@"%@", [err localizedDescription]);
//    }
    
    return newSt;
}

- (Car *) createCar:(NSString*) model {
    Car *car = [NSEntityDescription insertNewObjectForEntityForName:@"Car" inManagedObjectContext:self.managedObjectContext];
    car.model = model;
    
//    NSError *err = nil;
//    if(![self.managedObjectContext save:&err]){
//        NSLog(@"%@", [err localizedDescription]);
//    }
    
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
    NSArray *validNames = @[@"MfTse", @"LCpYM"];

    NSPredicate *predicat = [NSPredicate predicateWithFormat:@"score > %f and score <= %f and courses.@count >= %d and firstName in %@", 2.1, 2.33, 2, validNames];
//    NSPredicate *predicat = [NSPredicate predicateWithFormat:@"any score >= %f", 2.1];
    
//    NSPredicate *predicat = [NSPredicate predicateWithFormat:@"@avg.students.score >= %f", 2.1];  //  for course entity example all courses where students with average score >= 2.1
    
    [request setPredicate:predicat];
    
    
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

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
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
