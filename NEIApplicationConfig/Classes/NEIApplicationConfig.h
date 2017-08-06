//
//  NEIApplicationConfig.h
//  Pods
//
//  Created by ghost on 11/28/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#define ApplicationConfig NEIApplicationConfig

@interface NEIApplicationConfig : NSObject

+ (nonnull NEIApplicationConfig *)defaults;

+ (nonnull NEIApplicationConfig *)setObject:(nullable id)object forKey:(nonnull NSString *)key NS_SWIFT_NAME(set(value:key:));

+ (nullable NSObject *)objectForKey:(nonnull NSString *)key NS_SWIFT_NAME( get(objectForKey:) );

+ (nonnull NSArray *)allKeys  NS_SWIFT_NAME(keys());

+ (nonnull NSObject *)objectForKey:(nonnull NSString *)key value:(nonnull NSObject *)value  NS_SWIFT_NAME( get(objectForKey:defaultValue:) );

+ (nonnull NSString *)stringForKey:(nonnull NSString *)key value:(nonnull NSString *)default_value  NS_SWIFT_NAME( get(stringForKey:defaultValue:));

+ (nullable NSString *)stringForKey:(nonnull NSString *)key  NS_SWIFT_NAME( get(stringForKey:) );

+ (nullable Class)classForKey:(nonnull NSString *)key value:(nullable NSString *)value NS_SWIFT_NAME(get(classForKey:defaultValue:));

+ (nullable Class)classForKey:(nonnull NSString *)key NS_SWIFT_NAME(get(classForKey:));

+ (BOOL)booleanForKey:(nonnull NSString *)key value:(BOOL)default_value  NS_SWIFT_NAME(get(boolforKey:defaultValue:));

+ (NSInteger)intForKey:(nonnull NSString *)key value:(NSInteger)default_value   NS_SWIFT_NAME(get(intForKey:defaultValue:));

+ (float)floatForKey:(nonnull NSString *)key value:(float)default_value   NS_SWIFT_NAME(get(floatForKey:defaultValue:));

+ (nullable CTFontRef)createFontWithName:(nonnull NSString *)name ;

+ (nullable UIFont *)fontWithName: (nonnull NSString *)name  NS_SWIFT_NAME(font(named:));

+ (nonnull NEIApplicationConfig *)configWithScope:(nullable NSString *)scope NS_SWIFT_NAME(with(scope:));

+ (nonnull NEIApplicationConfig *)configWithDictionary:(nullable NSDictionary *)dictionary  NS_SWIFT_NAME(with(dictionary:));

#pragma mark - Instance Methods

- (nonnull NEIApplicationConfig *)setObject:(nullable id)value forKey:(nonnull NSString *)key NS_SWIFT_NAME(set(object:forKey:));

- (nullable NSObject *)objectForKey:(nonnull NSString *)key  NS_SWIFT_NAME(get(objectForKey:));

- (nonnull NSString *)stringForKey:(nonnull NSString *)key value:(nonnull NSString *)default_value  NS_SWIFT_NAME(get(stringForKey:defaultValue:));

- (nullable NSString *)stringForKey:(nonnull NSString *)key NS_SWIFT_NAME(get(stringForKey:));

- (float)floatForKey:(nonnull NSString *)key value:(float)default_value NS_SWIFT_NAME(get(floatForKey:value:));

- (nullable UIFont *)fontWithName:(nonnull NSString *)name  NS_SWIFT_NAME(font(named:));

- (nullable CTFontRef)createFontWithName:(nonnull NSString *)name ;

- (nonnull NSArray *)allKeys  NS_SWIFT_NAME(keys());

- (nullable Class)classForKey:(nonnull NSString *)key value:(nonnull NSString *)value NS_SWIFT_NAME(get(classForKey:defaultValue:));

- (BOOL)booleanForKey:(nonnull NSString *)key value:(BOOL)default_value  NS_SWIFT_NAME(get(booleanForKey:defaultValue:));

- (NSInteger)intForKey:(nonnull NSString *)key value:(NSInteger)default_value  NS_SWIFT_NAME(get(intForKey:defaultValue:));

- (nonnull NSObject *)objectForKey:(nonnull NSString *)key value:(nonnull NSObject *)default_value;

#pragma mark -

- (nullable id)objectForKeyedSubscript:(nonnull NSString*)key;
- (void)setObject:(nullable id)obj forKeyedSubscript:(nonnull NSString *)key;

@end
