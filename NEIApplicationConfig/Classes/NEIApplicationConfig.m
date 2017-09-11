//
//  NEIApplicationConfig.m
//  Pods
//
//  Created by ghost on 11/28/16.
//
//

#import "NEIApplicationConfig.h"

#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>

@interface NEIApplicationConfig () {}
- (id)initWithDictionary:(NSDictionary *)dictionary;
@property(nonatomic, readonly) NSMutableDictionary *config;

@end

@implementation NEIApplicationConfig

static NEIApplicationConfig *sharedInstance = nil;

- (id)initWithDictionary:(nullable NSDictionary *)dictionary {
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    if (self = [super init]) {
        if (dictionary) {
            _config = [NSMutableDictionary dictionaryWithDictionary:[NEIApplicationConfig defaults].config];
            [_config addEntriesFromDictionary:dictionary];
        } else {
            NSString *configPath = nil;
            if ([[NSFileManager defaultManager] fileExistsAtPath:(configPath = [[NSBundle mainBundle] pathForResource:@"ApplicationConfig" ofType:@"plist"])]) {
                _config = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:configPath]];
            } else {
                _config = [NSMutableDictionary dictionary];
            }

#if DEBUG
            if ([[NSFileManager defaultManager] fileExistsAtPath:(configPath = [[NSBundle mainBundle] pathForResource:@"ApplicationConfig.debug" ofType:@"plist"])]) {
                [self.config addEntriesFromDictionary:[NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:configPath]]];
            }
#endif

#if TARGET_OS_SIMULATOR
            if ([ [NSFileManager defaultManager ] fileExistsAtPath: (configPath = [[NSBundle mainBundle] pathForResource:@"ApplicationConfig.simulator" ofType:@"plist"]) ] ) {
                NSLog(@"IOS Simulator configuration enabled");
                [self.config addEntriesFromDictionary: [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:configPath]]];
            }
#else
            NSLog(@"IOS Simulator configuration disabled");
#endif


            if(bundleIdentifier && [self.config[bundleIdentifier] isKindOfClass:[NSDictionary class]]) {
                NSDictionary * bundleDictionary = self.config[bundleIdentifier];
                [self.config addEntriesFromDictionary:bundleDictionary];
            }
        }
    }
    return self;
}

- (id)init {
    if (self = [self initWithDictionary:nil]) {
        return self;
    }

    return nil;
}

+ (nonnull NEIApplicationConfig *)configWithDictionary:(nullable NSDictionary *)dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}

+ (nonnull NEIApplicationConfig *)configWithScope:(nullable NSString *)scope {
    NSDictionary *lastScope = [self defaults].config; // starting from the root
    NSArray *scopes = [scope componentsSeparatedByString:@"::"];
    for (NSString *scopeKey in scopes) {
        lastScope = [lastScope isKindOfClass:[NSDictionary class]] ? [lastScope objectForKey:scopeKey] : nil;
    }
    return [self configWithDictionary:lastScope];
}

+ (nonnull NSObject *)objectForKey:(nonnull NSString *)key value:(NSObject *)default_value {
    return [[self defaults] objectForKey:key value:default_value];
}

+ (float)floatForKey:(nonnull NSString *)key value:(float)default_value {
    return [[self defaults] floatForKey:key value:default_value];
}

+ (NSInteger)intForKey:(nonnull NSString *)key value:(NSInteger)default_value {
    return [[self defaults] intForKey:key value:default_value];
}

+ (BOOL)booleanForKey:(nonnull NSString *)key value:(BOOL)default_value {
    return [[self defaults] booleanForKey:key value:default_value];
}

+ (nullable UIFont *)fontWithName:(nonnull NSString *)name {
    return [[self defaults] fontWithName:name];
}

+ (nullable CTFontRef)createFontWithName:(nonnull NSString *)name {
    return [[self defaults] createFontWithName:name];
}

+ (nonnull NSString *)stringForKey:(nonnull NSString *)key value:(nonnull NSString *)default_value {
    return [[self defaults] stringForKey:key value:default_value];
}

+ (nullable NSString *)stringForKey:(nonnull NSString *)key {
    return (NSString *) [[self defaults] objectForKey:key];
}

+ (nullable NSObject *)objectForKey:(nonnull NSString *)key {
    return [[self defaults] objectForKey:key];
}

+ (nonnull NSArray *)allKeys {
    return [[self defaults] allKeys];
}

+ (nullable Class)classForKey:(nonnull NSString *)key value:(nonnull NSString *)value {
    return [[self defaults] classForKey:key value:value];
}

+ (nullable Class)classForKey:(nonnull NSString *)key {
    return [[self defaults] classForKey:key defaultValue:nil];
}

+ (nonnull NEIApplicationConfig *)defaults {
    @synchronized (self) {
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
        }
    }

    return sharedInstance;
}

#pragma mark - Instance Methods

+ (nonnull NEIApplicationConfig *)setObject:(id)object forKey:(nonnull NSString *)key {
    return [[self defaults] setObject:object forKey:key];
}

- (nonnull NEIApplicationConfig *)setObject:(id)value forKey:(nonnull NSString *)key {
    self.config[key] = value;
    return self;
}



- (nonnull NSString *)stringForKey:(nonnull NSString *)key value:(nonnull NSString *)default_value {
    NSObject *val = [self objectForKey:key];
    if (! [val isKindOfClass:[NSString class]])
        return [self interpolateValue:self.config[default_value] keys:nil];
    return [self interpolateValue: (NSString *)self.config[val] keys:nil];
}

- (nullable NSString *)stringForKey:(nonnull NSString *)key {
    NSObject *val = [self objectForKey:key];
    if (! [val isKindOfClass:[NSString class]])
        return nil;
    return [self interpolateValue:(NSString*)val keys:nil];
}

- (float)floatForKey:(nonnull NSString *)key value:(float)default_value {
    NSNumber *val = (NSNumber *) [self objectForKey:key];
    if (val)
        return [val floatValue];
    return default_value;
}

- (nullable UIFont *)fontWithName:(nonnull NSString *)name {
    NSString *fntname = [self stringForKey:[NSString stringWithFormat:@"font.%@.name", name] value:@"Arial"];
    CGFloat fntsize = [self floatForKey:[NSString stringWithFormat:@"font.%@.size", name] value:12];
    UIFont *font = [UIFont fontWithName:fntname size:fntsize];
    if (font)
        return font;
    return [UIFont fontWithName:@"Arial" size:fntsize];
}

- (nullable CTFontRef)createFontWithName:(nonnull NSString *)name {
    NSString *fntname = [self stringForKey:[NSString stringWithFormat:@"font.%@.name", name] value:@"Arial"];
    CGFloat fntsize = [self floatForKey:[NSString stringWithFormat:@"font.%@.size", name] value:12];
    CTFontRef ctFont = CTFontCreateWithName((__bridge CFStringRef) fntname, fntsize, NULL);
    if (ctFont)
        return ctFont;
    return CTFontCreateWithName((CFStringRef) @"Arial", fntsize, NULL);
}

- (nonnull  NSArray *)allKeys {
    return [self.config allKeys];
}

- (nullable Class)classForKey:(nonnull NSString *)key value:(NSString *)value {
    return [self classForKey:key defaultValue:value];
}

- (nullable Class)classForKey:(nonnull NSString *)key defaultValue:(NSString *)value {
    NSString *className = [self stringForKey:key value:value];
    Class class = NSClassFromString(className);
    return class;
}

+ (nullable Class)classForKey:(nonnull NSString *)key defaultValue:(NSString *)value {
    return [[self defaults] classForKey:key defaultValue:value];
}

- (nullable Class)classForKey:(nonnull NSString *)key {
    return [self classForKey:key defaultValue:nil];
}

- (NSInteger)intForKey:(nonnull NSString *)key value:(NSInteger)default_value {
    NSNumber *val = (NSNumber *) [self objectForKey:key];
    if (val)
        return [val intValue];
    return default_value;
}

- (BOOL)booleanForKey:(nonnull NSString *)key value:(BOOL)default_value {
    NSNumber *val = (NSNumber *) [self objectForKey:key];
    if (val)
        return [val boolValue];
    return default_value;
}

- (nonnull NSObject *)objectForKey:(nonnull NSString *)key value:(nonnull NSObject *)default_value {
    NSObject *val = [self objectForKey:key];
    if (!val) return default_value;
    return val;
}
- (nullable NSObject *)objectForKey:(nonnull NSString *)key {
    return self.config[key];
}
#pragma mark - Subscripting

- (id)objectForKeyedSubscript:(NSString*)key {
    return self.config[key];
}

- (void)setObject:(id)obj forKeyedSubscript:(NSString *)key {
    self.config[key] = obj;
}

- (NSString *) interpolateValue:(nonnull NSString *) value keys: (nullable NSMutableDictionary*) dictionary {

    return value;
    /*
    // TODO: Should interpolate :value for {KEY}
    NSScanner *scanner = [NSScanner scannerWithString:value];
    NSMutableString *buffer = [NSMutableString string];
    NSString *container;
    NSString *currentKey;
    scanner.charactersToBeSkipped =  // skip nothing, only replace characters in {}
            [NSCharacterSet characterSetWithCharactersInString:@""];

    BOOL foundOpen = NO;
    BOOL foundClose = NO;
    while(![scanner isAtEnd] ) {
        container = NULL;
        if([scanner scanUpToString:@"{" intoString:&container]) { // can things before {
            foundOpen = YES;
            if(scanner.scanLocation >= value.length && container ) { // no opening brace
                [buffer appendString:container];
            }
        } else if([scanner scanString:@"{" intoString:&container]) {
            foundOpen = YES;
        } else if(foundOpen && [scanner scanUpToString:@"}" intoString:&container]) {
            NSString *foundKey = [self stringForKey:container];
            NSString *cachedValue = dictionary[foundKey];
            NSString *finalValue = cachedValue ? cachedValue : [self interpolateValue:foundKey keys:dictionary];
            dictionary[foundKey] = finalValue;
            if(finalValue)
                [buffer appendString:finalValue];
            else
                [buffer appendString:foundKey];
        } else if(foundOpen && [scanner scanString:@"}" intoString:&container]) {

        }


        // conditions:
        // {} doesn't exist
        // {} first character
        // there is no closing }
    }

    return buffer; */
}

#pragma mark - Deallocation

- (void)dealloc {
    _config = nil;
}
@end
