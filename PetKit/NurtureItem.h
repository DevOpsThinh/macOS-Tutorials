//
//  NurtureItem.h
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 12/12/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// An enumeration that is favorable for Swifty.
/// NS_CLOSED_ENUM let we define a Swift-bridgeable enum represented
/// by the type in the first argument named as the second argument.
/// Provide a nice way to achieve this level of granularity, using NS_SWIFT_NAME
typedef NS_CLOSED_ENUM(NSInteger, NurtureItemKind) {
    NurtureItemKindStrenuousness,
    NurtureItemKindFood,
    NurtureItemKindSleep,
    NurtureItemKindDiaper,
    NurtureItemKindMoment,
    NurtureItemKindAwake
} NS_SWIFT_NAME(NurtureItem.Kind);

@interface NurtureItem : NSObject
// MARK: - PROPERTIES
@property (nonatomic, assign) NurtureItemKind kind;
@property (nonatomic, strong) NSDate * date;
@property (nonatomic, strong) NSUUID * _Nullable attachmentId;

// MARK: - INITIALIZERS
- (NurtureItem * ) initWithKind: (NurtureItemKind) kind;

- (NurtureItem *) initWithKind: (NurtureItemKind) kind
                       date: (NSDate *) date;

- (NurtureItem *) initWithKind: (NurtureItemKind) kind
                       date: (NSDate * _Nullable) date
               attachmentId: (NSUUID * _Nullable) attachmentId;
@end
// MARK: - GLOBAL FUNCTIONS
/// A `NurtureItemKindDescription` global function
NSString * NurtureItemKindDescription(NurtureItemKind)
NS_SWIFT_NAME(getter:NurtureItemKind.description(self:));

NS_ASSUME_NONNULL_END
