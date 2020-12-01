//
//  Artist.h
//  FavoriteArtists
//
//  Created by Bohdan Tkachenko on 11/30/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Artist : NSObject

@property (nonatomic, readonly, copy) NSString *artistName;
@property (nonatomic, readonly) int formedYear;
@property (nonatomic, readonly, copy) NSString *biography;
@property (nonatomic, readonly, copy) NSDictionary *dictionaryValues;

- (instancetype)initWithArtistName:(NSString *)aName
                        formedYear:(int)aYear
                         biography:(NSString *)aBiography;

- (nullable instancetype)initWithSearchResults:(NSDictionary *)dictionary;

- (instancetype)initFromStore:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
