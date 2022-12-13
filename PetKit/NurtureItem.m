//
//  NurtureItem.m
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 12/12/2022.
//

#import "NurtureItem.h"

@implementation NurtureItem

- (NurtureItem * _Nonnull) initWithKind: (NurtureItemKind) kind {
    self = [super init];

    if (self) {
        self.kind = kind;
        self.date = [[NSDate new] dateByAddingTimeInterval: -1];
    }
    return self;
}

- (NurtureItem * _Nonnull) initWithKind: (NurtureItemKind) kind date:(NSDate *)date {
    self = [super init];

    if (self) {
        self.kind = kind;
        self.date = date;
    }
    return self;
}

- (NurtureItem * _Nonnull)initWithKind:(NurtureItemKind)kind date:(NSDate *)date attachmentId:(NSUUID *)attachmentId {
    self = [super init];
    if (self) {
        self.kind = kind;
        self.date = date == nil ? [[NSDate new] dateByAddingTimeInterval:-1] : date;
        self.attachmentId = attachmentId;
    }
    return self;
}

NSString * _Nonnull NurtureItemKindDescription(NurtureItemKind kind) {
    switch (kind) {
        case NurtureItemKindFood:
            return @"Food";
        case NurtureItemKindStrenuousness:
            return @"Strenuousness";
        case NurtureItemKindDiaper:
            return @"Diaper";
        case NurtureItemKindSleep:
            return @"Sleeping";
        case NurtureItemKindAwake:
            return @"Awake";
        case NurtureItemKindMoment:
            return @"A moment";
        default:
            break;
    }
}
@end
