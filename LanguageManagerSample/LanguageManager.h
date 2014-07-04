//
//  LanguageManager.h
//  Ryx
//
//  Created by Paweł Sporysz on 04.07.2014.
//  Copyright (c) 2014 Paweł Sporysz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LanguageManager : NSObject

/**
 *  Language for app.
 */
@property (strong, nonatomic) NSString *appLanguage;

/**
 *  Registered default language.
 */
@property (strong, nonatomic, readonly) NSString *defaultLanguage;

/**
 *  Registered available languages.
 */
@property (strong, nonatomic, readonly) NSArray *languages;

/**
 *  Default manager.
 *
 *  @return Default manager
 */
+ (id)sharedManager;

/**
 *  Register languages which be available in app.
 *
 *  @param languages       Languages to register. It should contains strings describing languages, for example "en", "pl" etc.
 *  @param defaultLanguage Choose one language from previous parameter and set it as default language. It causes default language is used when none languages it setted. For nil parameter default language is English (en).
 */
-(void)registerAvailableLanguages:(NSArray*)languages withDefaultLanguage:(NSString*)defaultLanguage;

/**
 *  Passed block invokes every time when appLanguage changes.
 *
 *  @param block Block to refresh UI.
 */
-(void)registerRefreshUIBlock:(void(^)())block;

@end
