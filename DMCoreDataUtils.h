//
//  DMCoreDataUtils.h
//  DMCoreDataUtils
//
//  Created by Hussain, Shabeer (UK - London) on 19/01/2016.
//  Copyright © 2016 Desert Monkey. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSFetchedResultsController;
@class NSFetchRequest;
@class NSManagedObjectModel;
@class NSManagedObject;

typedef void (^kDMCoreDataUtilsFRCSuccessBlock)(NSFetchedResultsController *FRC, NSPredicate *predicate);
typedef void (^kDMCoreDataUtilsFRCErrorBlock)(NSError *error, NSFetchedResultsController *FRC);

typedef void (^kDMCoreDataUtilsFetchedObjectsSuccessBlock)(NSFetchRequest *fetchRequest, NSArray *fetchedObjects, NSPredicate *predicate);
typedef void (^kDMCoreDataUtilsFetchObjectsErrorBlock)(NSError *error, NSFetchRequest *fetchRequest);

@interface DMCoreDataUtils : NSObject

#pragma mark - Print Managed Objects

/**
 Prints all the entities stored in Core Data for an NSMangedObjectModel
 
 @param model model to print all entities from
 */
+ (void) printAllEntitiesInManagedObjectModel:(NSManagedObjectModel *)model;

/**
 Prints all instances of an entity and their attributes attributes
 
 @param entity entity to print
 */
+ (void) printEntity:(NSString *)entity;

/**
 Prints all attributes of an NSManagedObject instance
 
 @param managedObject managedObject to print
 */
+ (void) printAttributesForManagedObject:(NSManagedObject *)managedObject;

#pragma mark - Fetch Results Controllers

/**
 Creates and returns a fetch results controller via a success block.
 
 @param entity Entity name
 
 @param sortDescriptors An array of sort descriptors
 @param predicate Predicate to filter fetch request
 @param sectionNameKeyPath Key for section headers
 @param fetchLimit limits the number of results returned, 0 indicates no limit
 
 @param success success block which returns the initialised FRC and predicate used to filter the fetch request
 @param fail an error block which returns an error and FRC
 */
+ (void) fetchResultsControllerWithEntity:(NSString *)entity
                          sortDescriptors:(NSArray *)sortDescriptors
                                predicate:(NSPredicate *)predicate
                       sectionNameKeyPath:(NSString *)sectionNameKeyPath
                               fetchLimit:(NSInteger)fetchLimit
                                  success:(kDMCoreDataUtilsFRCSuccessBlock)success
                                     fail:(kDMCoreDataUtilsFRCErrorBlock)fail;
/**
 Creates and returns a fetch results controller via a success block.
 
 @param entity Entity name
 
 @param sortDescriptors An array of sort descriptors
 @param predicate Predicate to filter fetch request
 @param sectionNameKeyPath Key for section headers
 
 @param success success block which returns the initialised FRC and predicate used to filter the fetch request
 @param fail an error block which returns an error and FRC
 */
+ (void) fetchResultsControllerWithEntity:(NSString *)entity
                          sortDescriptors:(NSArray *)sortDescriptors
                                predicate:(NSPredicate *)predicate
                       sectionNameKeyPath:(NSString *)sectionNameKeyPath
                                  success:(kDMCoreDataUtilsFRCSuccessBlock)success
                                     fail:(kDMCoreDataUtilsFRCErrorBlock)fail;

/**
 Creates and returns a fetch results controller via a success block.
 
 @param entity Entity name
 
 @param sortDescriptors An array of sort descriptors
 @param predicate Predicate to filter fetch request
 @param fetchLimit limits the number of results returned, 0 indicates no limit
 
 @param success success block which returns the initialised FRC and predicate used to filter the fetch request
 @param fail an error block which returns an error and FRC
 */
+ (void) fetchResultsControllerWithEntity:(NSString *)entity
                          sortDescriptors:(NSArray *)sortDescriptors
                                predicate:(NSPredicate *)predicate
                               fetchLimit:(NSInteger)fetchLimit
                                  success:(kDMCoreDataUtilsFRCSuccessBlock)success
                                     fail:(kDMCoreDataUtilsFRCErrorBlock)fail;

/**
 Creates and returns a fetch results controller via a success block.
 
 @param entity Entity name
 
 @param sortDescriptors An array of sort descriptors
 @param fetchLimit limits the number of results returned, 0 indicates no limit
 
 @param success success block which returns the initialised FRC and predicate used to filter the fetch request
 @param fail an error block which returns an error and FRC
 */
+ (void) fetchResultsControllerWithEntity:(NSString *)entity
                          sortDescriptors:(NSArray *)sortDescriptors
                               fetchLimit:(NSInteger)fetchLimit
                                  success:(kDMCoreDataUtilsFRCSuccessBlock)success
                                     fail:(kDMCoreDataUtilsFRCErrorBlock)fail;

/**
 Creates and returns a fetch results controller via a success block.
 
 @param entity Entity name
 
 @param predicate Predicate to filter fetch request
 @param fetchLimit limits the number of results returned, 0 indicates no limit
 
 @param success success block which returns the initialised FRC and predicate used to filter the fetch request
 @param fail an error block which returns an error and FRC
 */
+ (void) fetchResultsControllerWithEntity:(NSString *)entity
                                predicate:(NSPredicate *)predicate
                               fetchLimit:(NSInteger)fetchLimit
                                  success:(kDMCoreDataUtilsFRCSuccessBlock)success
                                     fail:(kDMCoreDataUtilsFRCErrorBlock)fail;


/**
 Creates and returns a fetch results controller via a success block.
 
 @param entity Entity name
 
 @param sortDescriptors An array of sort descriptors
 @param predicate Predicate to filter fetch request
 
 @param success success block which returns the initialised FRC and predicate used to filter the fetch request
 @param fail an error block which returns an error and FRC
 */
+ (void) fetchResultsControllerWithEntity:(NSString *)entity
                          sortDescriptors:(NSArray *)sortDescriptors
                                predicate:(NSPredicate *)predicate
                                  success:(kDMCoreDataUtilsFRCSuccessBlock)success
                                     fail:(kDMCoreDataUtilsFRCErrorBlock)fail;

/**
 Creates and returns a fetch results controller via a success block.
 
 @param entity Entity name
 
 @param sortDescriptors An array of sort descriptors
 
 @param success success block which returns the initialised FRC and predicate used to filter the fetch request
 @param fail an error block which returns an error and FRC
 */
+ (void) fetchResultsControllerWithEntity:(NSString *)entity
                          sortDescriptors:(NSArray *)sortDescriptors
                                  success:(kDMCoreDataUtilsFRCSuccessBlock)success
                                     fail:(kDMCoreDataUtilsFRCErrorBlock)fail;

/**
 Creates and returns a fetch results controller via a success block.
 
 @param entity Entity name
 
 @param predicate Predicate to filter fetch request
 
 @param success success block which returns the initialised FRC and predicate used to filter the fetch request
 @param fail an error block which returns an error and FRC
 */
+ (void) fetchResultsControllerWithEntity:(NSString *)entity
                                predicate:(NSPredicate *)predicate
                                  success:(kDMCoreDataUtilsFRCSuccessBlock)success
                                     fail:(kDMCoreDataUtilsFRCErrorBlock)fail;

/**
 Creates and returns a fetch results controller via a success block.
 
 @param entity Entity name
 
 @param fetchLimit limits the number of results returned, 0 indicates no limit
 
 @param success success block which returns the initialised FRC and predicate used to filter the fetch request
 @param fail an error block which returns an error and FRC
 */
+ (void) fetchResultsControllerWithEntity:(NSString *)entity
                               fetchLimit:(NSInteger)fetchLimit
                                  success:(kDMCoreDataUtilsFRCSuccessBlock)success
                                     fail:(kDMCoreDataUtilsFRCErrorBlock)fail;


/**
 Creates and returns a fetch results controller via a success block.
 
 @param entity Entity name
 
 @param success success block which returns the initialised FRC and predicate used to filter the fetch request
 @param fail an error block which returns an error and FRC
 */
+ (void) fetchResultsControllerWithEntity:(NSString *)entity
                                  success:(kDMCoreDataUtilsFRCSuccessBlock)success
                                     fail:(kDMCoreDataUtilsFRCErrorBlock)fail;

#pragma mark - Fetched Arrays

/**
 Creates and returns an array of fetched objects via a success block.
 
 @param entity Entity name
 
 @param sortDescriptors An array of sort descriptors
 @param predicate Predicate to filter fetch request
 @param fetchLimit limits the number of results returned, 0 indicates no limit
 
 @param success success block which returns the initialised Array, fetch request and predicate used to filter the fetch request
 @param fail an error block which returns an error and fetch request
 */
+ (void) fetchObjectsFromEntity:(NSString *)entity
                sortDescriptors:(NSArray *)sortDescriptors
                      predicate:(NSPredicate *)predicate
                     fetchLimit:(NSInteger)fetchLimit
                        success:(kDMCoreDataUtilsFetchedObjectsSuccessBlock)success
                           fail:(kDMCoreDataUtilsFetchObjectsErrorBlock)fail;

/**
 Creates and returns an array of fetched objects via a success block.
 
 @param entity Entity name
 
 @param sortDescriptors An array of sort descriptors
 @param predicate Predicate to filter fetch request
 
 @param success success block which returns the initialised Array, fetch request and predicate used to filter the fetch request
 @param fail an error block which returns an error and fetch request
 */
+ (void) fetchObjectsFromEntity:(NSString *)entity
                sortDescriptors:(NSArray *)sortDescriptors
                      predicate:(NSPredicate *)predicate
                        success:(kDMCoreDataUtilsFetchedObjectsSuccessBlock)success
                           fail:(kDMCoreDataUtilsFetchObjectsErrorBlock)fail;
/**
 Creates and returns an array of fetched objects via a success block.
 
 @param entity Entity name
 
 @param sortDescriptors An array of sort descriptors
 @param fetchLimit limits the number of results returned, 0 indicates no limit
 
 @param success success block which returns the initialised Array, fetch request and predicate used to filter the fetch request
 @param fail an error block which returns an error and fetch request
 */
+ (void) fetchObjectsFromEntity:(NSString *)entity
                sortDescriptors:(NSArray *)sortDescriptors
                     fetchLimit:(NSInteger)fetchLimit
                        success:(kDMCoreDataUtilsFetchedObjectsSuccessBlock)success
                           fail:(kDMCoreDataUtilsFetchObjectsErrorBlock)fail;
/**
 Creates and returns an array of fetched objects via a success block.
 
 @param entity Entity name
 
 @param predicate Predicate to filter fetch request
 @param fetchLimit limits the number of results returned, 0 indicates no limit
 
 @param success success block which returns the initialised Array, fetch request and predicate used to filter the fetch request
 @param fail an error block which returns an error and fetch request
 */
+ (void) fetchObjectsFromEntity:(NSString *)entity
                      predicate:(NSPredicate *)predicate
                     fetchLimit:(NSInteger)fetchLimit
                        success:(kDMCoreDataUtilsFetchedObjectsSuccessBlock)success
                           fail:(kDMCoreDataUtilsFetchObjectsErrorBlock)fail;
/**
 Creates and returns an array of fetched objects via a success block.
 
 @param entity Entity name
 
 @param sortDescriptors An array of sort descriptors
 
 @param success success block which returns the initialised Array, fetch request and predicate used to filter the fetch request
 @param fail an error block which returns an error and fetch request
 */
+ (void) fetchObjectsFromEntity:(NSString *)entity
                sortDescriptors:(NSArray *)sortDescriptors
                        success:(kDMCoreDataUtilsFetchedObjectsSuccessBlock)success
                           fail:(kDMCoreDataUtilsFetchObjectsErrorBlock)fail;
/**
 Creates and returns an array of fetched objects via a success block.
 
 @param entity Entity name
 
 @param predicate Predicate to filter fetch request
 
 @param success success block which returns the initialised Array, fetch request and predicate used to filter the fetch request
 @param fail an error block which returns an error and fetch request
 */
+ (void) fetchObjectsFromEntity:(NSString *)entity
                      predicate:(NSPredicate *)predicate
                        success:(kDMCoreDataUtilsFetchedObjectsSuccessBlock)success
                           fail:(kDMCoreDataUtilsFetchObjectsErrorBlock)fail;

/**
 Creates and returns an array of fetched objects via a success block.
 
 @param entity Entity name
 
 @param fetchLimit limits the number of results returned, 0 indicates no limit
 
 @param success success block which returns the initialised Array, fetch request and predicate used to filter the fetch request
 @param fail an error block which returns an error and fetch request
 */
+ (void) fetchObjectsFromEntity:(NSString *)entity
                     fetchLimit:(NSInteger)fetchLimit
                        success:(kDMCoreDataUtilsFetchedObjectsSuccessBlock)success
                           fail:(kDMCoreDataUtilsFetchObjectsErrorBlock)fail;
/**
 Creates and returns an array of fetched objects via a success block.
 
 @param entity Entity name
 
 @param success success block which returns the initialised Array, fetch request and predicate used to filter the fetch request
 @param fail an error block which returns an error and fetch request
 */
+ (void) fetchObjectsFromEntity:(NSString *)entity
                        success:(kDMCoreDataUtilsFetchedObjectsSuccessBlock)success
                           fail:(kDMCoreDataUtilsFetchObjectsErrorBlock)fail;

@end
