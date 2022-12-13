//
//  Nurture.h
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 12/12/2022.
//

#import <Foundation/Foundation.h>
#import <PetKit/NurtureItem.h>
#import <PhotosUI/PhotosUI.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const NurtureStorageFilename;

NS_REFINED_FOR_SWIFT
@interface Nurture : NSObject <PHPickerViewControllerDelegate>
// MARK: - PROPERTIES

@property (nonatomic, strong) NSURL *storageUrl;
@property (nonatomic, copy, nullable) void (^pickerCompletion)(NurtureItem *);

// Configured Swifty names for both of these entitites
@property (nonatomic, readonly) BOOL petSleeping NS_SWIFT_NAME(isPetSleeping);

// MARK: - METHODS
- (NSArray <NurtureItem *> *) loadNurtureItems;
- (NurtureItem *) addNurtureItem: (NurtureItem *) item;
- (NurtureItem *) addNurtureItemOfKind: (NurtureItemKind) kind;

- (NSUUID * _Nullable) storeImage:(UIImage *) image NS_SWIFT_NAME(storeImage(_:));

- (void) addMomentOnPresenter: (UIViewController *) presenter
                   completion: (void (^ _Nullable)(NurtureItem *)) completion NS_SWIFT_UNAVAILABLE("Use `ImagePicker` instead");
@end

NS_ASSUME_NONNULL_END
