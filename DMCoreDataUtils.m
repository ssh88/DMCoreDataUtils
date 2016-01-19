//
//  DMCoreDataUtils.m
//  DMCoreDataUtils
//
//  Created by Hussain, Shabeer (UK - London) on 19/01/2016.
//  Copyright © 2016 Desert Monkey. All rights reserved.
//

#import "DMCoreDataUtils.h"
#import <CoreData/CoreData.h>

@implementation DMCoreDataUtils

+ (NSManagedObjectContext *) managedObjectContext
{
    //Uncomment this line with your own NSManagedObjectContext. Below is an example
    //[[DMDataModel sharedInstance] mainContext];
    return nil;
}

#pragma mark - Print Managed Objects

+ (void) printAllEntitiesInManagedObjectModel:(NSManagedObjectModel *)model
{
    for(NSEntityDescription *entity in [model entities])
    {
        [self printEntity:[entity name]];
    }
}

+ (void) printEntity:(NSString *)entity
{
    [self fetchObjectsFromEntity:entity
                         success:^(NSFetchRequest *fetchRequest, NSArray *fetchedObjects, NSPredicate *predicate) {
                             
                             if (fetchedObjects.count > 0)
                             {
                                 NSInteger count = 1;
                                 for (NSManagedObject *managedObject in fetchedObjects)
                                 {
                                     
                                     NSLog(@"----- %@ %ld ----------",entity,(long)count);
                                     [self printAttributesForManagedObject:managedObject];
                                     count ++;
                                 }
                                 
                                 NSLog(@"-------------------------");
                                 NSLog(@"\n");
                             }
                             
                         }
                            fail:^(NSError *error, NSFetchRequest *fetchRequest) {
                                
                            }
     ];
}

+ (void) printAttributesForManagedObject:(NSManagedObject *)managedObject
{
    
    NSDictionary *attributes = [managedObject.entity attributesByName];
    for (NSString *attribute in attributes)
    {
        //this string will be the space between the atribute name and value
        NSMutableString *space = [NSMutableString string];
        //we calculate the space so that all lines are formatted the same
        for (NSInteger index = attribute.length; index < 25; index++)
        {
            [space appendString:@" "];
        }
        
        //print
        id value = [managedObject valueForKey: attribute];
        NSLog(@"%@%@:   %@", attribute,space, value);
    }
}

#pragma mark - Fetch Results Controllers

/**
 entity Entity name
 sortDescriptors An array of sort descriptors
 predicate Predicate to filter fetch request
 sectionNameKeyPath Key for section headers
 fetchLimit limits the number of results returned, 0 indicates no limit
 success success block which returns the initialised FRC and predicate used to filter the fetch request
 fail an error block which returns an error and FRC
 */
+ (void) fetchResultsControllerWithEntity:(NSString *)entity
                          sortDescriptors:(NSArray *)sortDescriptors
                                predicate:(NSPredicate *)predicate
                       sectionNameKeyPath:(NSString *)sectionNameKeyPath
                               fetchLimit:(NSInteger)fetchLimit
                                  success:(kDMCoreDataUtilsFRCSuccessBlock)success
                                     fail:(kDMCoreDataUtilsFRCErrorBlock)fail
{
    
    NSFetchRequest *fetchRequest = [self fetchRequestWithEntity:entity
                                                sortDescriptors:sortDescriptors
                                                      predicate:predicate
                                                     fetchLimit:fetchLimit];
    
    NSFetchedResultsController *FRC = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                          managedObjectContext:[self managedObjectContext]
                                                                            sectionNameKeyPath:sectionNameKeyPath
                                                                                     cacheName:nil];
    
    NSError *error = nil;
    
    if ([FRC performFetch:&error])
    {
        if (FRC.fetchedObjects.count > 0)
        {
            NSLog(@"FETCHED %lud %@ RECORDS", (unsigned long)FRC.fetchedObjects.count, entity);
        }
        else
        {
            NSLog(@"0 %@ RECORDS FETCHED", entity);
        }
        
        success(FRC, predicate);
    }
    else
    {
        NSLog(@"FETCHING ERROR: \nEntity : %@ \nError : %@", entity, error.localizedDescription);
        fail(error, FRC);
    }
    
}

/**
 entity Entity name
 sortDescriptors An array of sort descriptors
 predicate Predicate to filter fetch request
 sectionNameKeyPath Key for section headers
 success success block which returns the initialised FRC and predicate used to filter the fetch request
 fail an error block which returns an error and FRC
 */
+ (void) fetchResultsControllerWithEntity:(NSString *)entity
                          sortDescriptors:(NSArray *)sortDescriptors
                                predicate:(NSPredicate *)predicate
                       sectionNameKeyPath:(NSString *)sectionNameKeyPath
                                  success:(kDMCoreDataUtilsFRCSuccessBlock)success
                                     fail:(kDMCoreDataUtilsFRCErrorBlock)fail
{
    [self fetchResultsControllerWithEntity:entity
                           sortDescriptors:sortDescriptors
                                 predicate:predicate
                        sectionNameKeyPath:sectionNameKeyPath
                                fetchLimit:0
                                   success:success
                                      fail:fail];
}

/**
 entity Entity name
 sortDescriptors An array of sort descriptors
 predicate Predicate to filter fetch request
 fetchLimit limits the number of results returned, 0 indicates no limit
 success success block which returns the initialised FRC and predicate used to filter the fetch request
 fail an error block which returns an error and FRC
 */
+ (void) fetchResultsControllerWithEntity:(NSString *)entity
                          sortDescriptors:(NSArray *)sortDescriptors
                                predicate:(NSPredicate *)predicate
                               fetchLimit:(NSInteger)fetchLimit
                                  success:(kDMCoreDataUtilsFRCSuccessBlock)success
                                     fail:(kDMCoreDataUtilsFRCErrorBlock)fail
{
    [self fetchResultsControllerWithEntity:entity
                           sortDescriptors:sortDescriptors
                                 predicate:predicate
                        sectionNameKeyPath:nil
                                fetchLimit:fetchLimit
                                   success:success
                                      fail:fail];
}

/**
 entity Entity name
 sortDescriptors An array of sort descriptors
 fetchLimit limits the number of results returned, 0 indicates no limit
 success success block which returns the initialised FRC and predicate used to filter the fetch request
 fail an error block which returns an error and FRC
 */
+ (void) fetchResultsControllerWithEntity:(NSString *)entity
                          sortDescriptors:(NSArray *)sortDescriptors
                               fetchLimit:(NSInteger)fetchLimit
                                  success:(kDMCoreDataUtilsFRCSuccessBlock)success
                                     fail:(kDMCoreDataUtilsFRCErrorBlock)fail
{
    [self fetchResultsControllerWithEntity:entity
                           sortDescriptors:sortDescriptors
                                 predicate:nil
                        sectionNameKeyPath:nil
                                fetchLimit:fetchLimit
                                   success:success
                                      fail:fail];
}

/**
 entity Entity name
 predicate Predicate to filter fetch request
 fetchLimit limits the number of results returned, 0 indicates no limit
 success success block which returns the initialised FRC and predicate used to filter the fetch request
 fail an error block which returns an error and FRC
 */
+ (void) fetchResultsControllerWithEntity:(NSString *)entity
                                predicate:(NSPredicate *)predicate
                               fetchLimit:(NSInteger)fetchLimit
                                  success:(kDMCoreDataUtilsFRCSuccessBlock)success
                                     fail:(kDMCoreDataUtilsFRCErrorBlock)fail
{
    [self fetchResultsControllerWithEntity:entity
                           sortDescriptors:nil
                                 predicate:predicate
                        sectionNameKeyPath:nil
                                fetchLimit:fetchLimit
                                   success:success
                                      fail:fail];
}


/**
 entity Entity name
 sortDescriptors An array of sort descriptors
 predicate Predicate to filter fetch request
 success success block which returns the initialised FRC and predicate used to filter the fetch request
 fail an error block which returns an error and FRC
 */
+ (void) fetchResultsControllerWithEntity:(NSString *)entity
                          sortDescriptors:(NSArray *)sortDescriptors
                                predicate:(NSPredicate *)predicate
                                  success:(kDMCoreDataUtilsFRCSuccessBlock)success
                                     fail:(kDMCoreDataUtilsFRCErrorBlock)fail
{
    [self fetchResultsControllerWithEntity:entity
                           sortDescriptors:sortDescriptors
                                 predicate:predicate
                        sectionNameKeyPath:nil
                                fetchLimit:0
                                   success:success
                                      fail:fail];
}

/**
 entity Entity name
 sortDescriptors An array of sort descriptors
 success success block which returns the initialised FRC and predicate used to filter the fetch request
 fail an error block which returns an error and FRC
 */
+ (void) fetchResultsControllerWithEntity:(NSString *)entity
                          sortDescriptors:(NSArray *)sortDescriptors
                                  success:(kDMCoreDataUtilsFRCSuccessBlock)success
                                     fail:(kDMCoreDataUtilsFRCErrorBlock)fail
{
    [self fetchResultsControllerWithEntity:entity
                           sortDescriptors:sortDescriptors
                                 predicate:nil
                        sectionNameKeyPath:nil
                                fetchLimit:0
                                   success:success
                                      fail:fail];
}

/**
 entity Entity name
 predicate Predicate to filter fetch request
 success success block which returns the initialised FRC and predicate used to filter the fetch request
 fail an error block which returns an error and FRC
 */
+ (void) fetchResultsControllerWithEntity:(NSString *)entity
                                predicate:(NSPredicate *)predicate
                                  success:(kDMCoreDataUtilsFRCSuccessBlock)success
                                     fail:(kDMCoreDataUtilsFRCErrorBlock)fail
{
    [self fetchResultsControllerWithEntity:entity
                           sortDescriptors:nil
                                 predicate:predicate
                        sectionNameKeyPath:nil
                                fetchLimit:0
                                   success:success
                                      fail:fail];
}

/**
 entity Entity name
 fetchLimit limits the number of results returned, 0 indicates no limit
 success success block which returns the initialised FRC and predicate used to filter the fetch request
 fail an error block which returns an error and FRC
 */
+ (void) fetchResultsControllerWithEntity:(NSString *)entity
                               fetchLimit:(NSInteger)fetchLimit
                                  success:(kDMCoreDataUtilsFRCSuccessBlock)success
                                     fail:(kDMCoreDataUtilsFRCErrorBlock)fail
{
    [self fetchResultsControllerWithEntity:entity
                           sortDescriptors:nil
                                 predicate:nil
                        sectionNameKeyPath:nil
                                fetchLimit:fetchLimit
                                   success:success
                                      fail:fail];
}


/**
 entity Entity name
 success success block which returns the initialised FRC and predicate used to filter the fetch request
 fail an error block which returns an error and FRC
 */
+ (void) fetchResultsControllerWithEntity:(NSString *)entity
                                  success:(kDMCoreDataUtilsFRCSuccessBlock)success
                                     fail:(kDMCoreDataUtilsFRCErrorBlock)fail
{
    [self fetchResultsControllerWithEntity:entity
                           sortDescriptors:nil
                                 predicate:nil
                        sectionNameKeyPath:nil
                                fetchLimit:0
                                   success:success
                                      fail:fail];
}


#pragma mark - Fetched Arrays

/**
 entity Entity name
 sortDescriptors An array of sort descriptors
 predicate Predicate to filter fetch request
 fetchLimit limits the number of results returned, 0 indicates no limit
 success success block which returns the initialised Array, fetch request and predicate used to filter the fetch request
 fail an error block which returns an error and fetch request
 */
+ (void)fetchObjectsFromEntity:(NSString *)entity
               sortDescriptors:(NSArray *)sortDescriptors
                     predicate:(NSPredicate *)predicate
                    fetchLimit:(NSInteger)fetchLimit
                       success:(kDMCoreDataUtilsFetchedObjectsSuccessBlock)success
                          fail:(kDMCoreDataUtilsFetchObjectsErrorBlock)fail
{
    NSFetchRequest *fetchRequest = [self fetchRequestWithEntity:entity
                                                sortDescriptors:sortDescriptors
                                                      predicate:predicate
                                                     fetchLimit:fetchLimit];
    
    NSError *error = nil;
    
    NSArray *fetchedObjects = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    
    if (!error)
    {
        if (fetchedObjects.count > 0)
        {
            NSLog(@"FETCHED %lud %@ RECORDS", (unsigned long)fetchedObjects.count, entity);
        }
        else
        {
            NSLog(@"0 %@ RECORDS FETCHED", entity);
        }
        
        if (success)
        {
            success(fetchRequest, fetchedObjects, predicate);
        }
    }
    else
    {
        NSLog(@"FETCHING ERROR: \nEntity : %@ \nError : %@", entity, error.localizedDescription);
        
        if (fail)
        {
            fail(error, fetchRequest);
        }
    }
}

/**
 entity Entity name
 sortDescriptors An array of sort descriptors
 predicate Predicate to filter fetch request
 success success block which returns the initialised Array, fetch request and predicate used to filter the fetch request
 fail an error block which returns an error and fetch request
 */
+ (void) fetchObjectsFromEntity:(NSString *)entity
                sortDescriptors:(NSArray *)sortDescriptors
                      predicate:(NSPredicate *)predicate
                        success:(kDMCoreDataUtilsFetchedObjectsSuccessBlock)success
                           fail:(kDMCoreDataUtilsFetchObjectsErrorBlock)fail
{
    [self fetchObjectsFromEntity:entity
                 sortDescriptors:sortDescriptors
                       predicate:predicate
                      fetchLimit:0
                         success:success
                            fail:fail];
    
}

/**
 entity Entity name
 sortDescriptors An array of sort descriptors
 fetchLimit limits the number of results returned, 0 indicates no limit
 success success block which returns the initialised Array, fetch request and predicate used to filter the fetch request
 fail an error block which returns an error and fetch request
 */
+ (void) fetchObjectsFromEntity:(NSString *)entity
                sortDescriptors:(NSArray *)sortDescriptors
                     fetchLimit:(NSInteger)fetchLimit
                        success:(kDMCoreDataUtilsFetchedObjectsSuccessBlock)success
                           fail:(kDMCoreDataUtilsFetchObjectsErrorBlock)fail
{
    [self fetchObjectsFromEntity:entity
                 sortDescriptors:sortDescriptors
                       predicate:nil
                      fetchLimit:fetchLimit
                         success:success
                            fail:fail];
    
}
/**
 entity Entity name
 predicate Predicate to filter fetch request
 fetchLimit limits the number of results returned, 0 indicates no limit
 success success block which returns the initialised Array, fetch request and predicate used to filter the fetch request
 fail an error block which returns an error and fetch request
 */
+ (void) fetchObjectsFromEntity:(NSString *)entity
                      predicate:(NSPredicate *)predicate
                     fetchLimit:(NSInteger)fetchLimit
                        success:(kDMCoreDataUtilsFetchedObjectsSuccessBlock)success
                           fail:(kDMCoreDataUtilsFetchObjectsErrorBlock)fail
{
    [self fetchObjectsFromEntity:entity
                 sortDescriptors:nil
                       predicate:predicate
                      fetchLimit:fetchLimit
                         success:success
                            fail:fail];
    
}
/**
 entity Entity name
 sortDescriptors An array of sort descriptors
 success success block which returns the initialised Array, fetch request and predicate used to filter the fetch request
 fail an error block which returns an error and fetch request
 */
+ (void) fetchObjectsFromEntity:(NSString *)entity
                sortDescriptors:(NSArray *)sortDescriptors
                        success:(kDMCoreDataUtilsFetchedObjectsSuccessBlock)success
                           fail:(kDMCoreDataUtilsFetchObjectsErrorBlock)fail
{
    [self fetchObjectsFromEntity:entity
                 sortDescriptors:sortDescriptors
                       predicate:nil
                      fetchLimit:0
                         success:success
                            fail:fail];
    
}

/**
 entity Entity name
 predicate Predicate to filter fetch request
 success success block which returns the initialised Array, fetch request and predicate used to filter the fetch request
 fail an error block which returns an error and fetch request
 */
+ (void) fetchObjectsFromEntity:(NSString *)entity
                      predicate:(NSPredicate *)predicate
                        success:(kDMCoreDataUtilsFetchedObjectsSuccessBlock)success
                           fail:(kDMCoreDataUtilsFetchObjectsErrorBlock)fail
{
    [self fetchObjectsFromEntity:entity
                 sortDescriptors:nil
                       predicate:predicate
                      fetchLimit:0
                         success:success
                            fail:fail];
    
}

/**
 entity Entity name
 fetchLimit limits the number of results returned, 0 indicates no limit
 success success block which returns the initialised Array, fetch request and predicate used to filter the fetch request
 fail an error block which returns an error and fetch request
 */
+ (void) fetchObjectsFromEntity:(NSString *)entity
                     fetchLimit:(NSInteger)fetchLimit
                        success:(kDMCoreDataUtilsFetchedObjectsSuccessBlock)success
                           fail:(kDMCoreDataUtilsFetchObjectsErrorBlock)fail
{
    [self fetchObjectsFromEntity:entity
                 sortDescriptors:nil
                       predicate:nil
                      fetchLimit:fetchLimit
                         success:success
                            fail:fail];
    
}
/**
 entity Entity name
 success success block which returns the initialised Array, fetch request and predicate used to filter the fetch request
 fail an error block which returns an error and fetch request
 */
+ (void) fetchObjectsFromEntity:(NSString *)entity
                        success:(kDMCoreDataUtilsFetchedObjectsSuccessBlock)success
                           fail:(kDMCoreDataUtilsFetchObjectsErrorBlock)fail
{
    [self fetchObjectsFromEntity:entity
                 sortDescriptors:nil
                       predicate:nil
                      fetchLimit:0
                         success:success
                            fail:fail];
    
}


#pragma mark - Fetched Request

+ (NSFetchRequest *) fetchRequestWithEntity:(NSString *)entity
                            sortDescriptors:(NSArray *)sortDescriptors
                                  predicate:(NSPredicate *)predicate
                                 fetchLimit:(NSInteger)fetchLimit
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entity
                                                         inManagedObjectContext:[self managedObjectContext]];
    
    [fetchRequest setEntity:entityDescription];
    
    NSMutableArray *descriptors = [NSMutableArray array];
    
    if (sortDescriptors)
    {
        for (NSSortDescriptor *descriptor in sortDescriptors)
        {
            [descriptors addObject:descriptor];
        }
    }
    
    [fetchRequest setSortDescriptors:descriptors];
    
    if (predicate)
    {
        [fetchRequest setPredicate:predicate];
    }
    
    if (fetchLimit > 0)
    {
        [fetchRequest setFetchLimit:fetchLimit];
        
    }
    
    return fetchRequest;
}

@end
