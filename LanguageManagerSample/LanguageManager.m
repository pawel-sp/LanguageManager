//
//  KRLanguageManager.m
//  Ryx
//
//  Created by Paweł Sporysz on 04.07.2014.
//  Copyright (c) 2014 Paweł Sporysz. All rights reserved.
//

#import "LanguageManager.h"
#import <objc/runtime.h>

static const char _bundle=0;

@interface BundleEx : NSBundle
@end

@implementation BundleEx

-(NSString*)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName
{
    NSBundle* bundle=objc_getAssociatedObject(self, &_bundle);
    return bundle ? [bundle localizedStringForKey:key value:value table:tableName] : [super localizedStringForKey:key value:value table:tableName];
}

@end

@interface NSBundle()

@end

@implementation NSBundle (Language)

+(void)setLanguage:(NSString*)language
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      object_setClass([NSBundle mainBundle],[BundleEx class]);
                  });
    objc_setAssociatedObject([NSBundle mainBundle], &_bundle, language ? [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]] : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



static NSString * const LanguageManagerDefaultLangauge = @"en";

@end


@interface LanguageManager()
@property (strong, nonatomic, readwrite) NSString *defaultLanguage;
@property (strong, nonatomic, readwrite) NSArray *languages;
@property (strong, nonatomic) void(^refreshUIBlock)();
@end

@implementation LanguageManager
@synthesize appLanguage = _appLanguage;

+ (id)sharedManager
{
    static LanguageManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

-(void)registerRefreshUIBlock:(void (^)())block
{
    self.refreshUIBlock = block;
}

-(BOOL)isLanguageCorrect:(NSString*)langauge
{
    return [[NSLocale preferredLanguages] containsObject:langauge];
}

-(void)registerAvailableLanguages:(NSArray *)languages withDefaultLanguage:(NSString *)defaultLanguage
{
    if(!defaultLanguage)
        defaultLanguage = LanguageManagerDefaultLangauge;
    
    if(!languages || languages.count == 0)
    {
        [[NSException exceptionWithName:NSInvalidArgumentException
                                 reason:@"You need to set at least one language"
                               userInfo:nil] raise];
    }
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc]init];
    for(NSString *language in languages)
    {
        if([self isLanguageCorrect:language])
        {
            [mutableArray addObject:language];
        }
    }
    self.languages = mutableArray;
    
    self.defaultLanguage = ([self.languages containsObject:defaultLanguage]) ? defaultLanguage : LanguageManagerDefaultLangauge;
}

-(void)setAppLanguage:(NSString *)appLanguage
{
    if(!appLanguage || ![self.languages containsObject:appLanguage])
    {
        _appLanguage = LanguageManagerDefaultLangauge;
    }
    else
    {
        _appLanguage = appLanguage;
    }
    
    [NSBundle setLanguage:_appLanguage];
    if(self.refreshUIBlock)
    {
        self.refreshUIBlock();
    }
    
}

-(NSString *)appLanguage
{
    return (!_appLanguage) ? LanguageManagerDefaultLangauge : _appLanguage;
}

@end
