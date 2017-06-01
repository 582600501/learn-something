//
//  Product+CoreDataProperties.h
//  
//
//  Created by Crystal on 16/8/31.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Product.h"

NS_ASSUME_NONNULL_BEGIN

@interface Product (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *brand;
@property (nullable, nonatomic, retain) NSString *capacity;
@property (nullable, nonatomic, retain) NSString *cateName;
@property (nullable, nonatomic, retain) NSString *company;
@property (nullable, nonatomic, retain) NSString *country;
@property (nullable, nonatomic, retain) NSString *doyenComment;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *other_name;
@property (nullable, nonatomic, retain) NSString *price;
@property (nullable, nonatomic, retain) NSString *address_china;
@property (nullable, nonatomic, retain) NSString *approval;
@property (nullable, nonatomic, retain) NSString *efficacy;
@property (nullable, nonatomic, retain) NSSet<Composition *> *composition;

@end

@interface Product (CoreDataGeneratedAccessors)

- (void)addCompositionObject:(Composition *)value;
- (void)removeCompositionObject:(Composition *)value;
- (void)addComposition:(NSSet<Composition *> *)values;
- (void)removeComposition:(NSSet<Composition *> *)values;

@end

NS_ASSUME_NONNULL_END
