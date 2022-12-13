//
//  Nurture.m
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 12/12/2022.
//

#import "Nurture.h"

NSString * _Nonnull const NurtureStorageFilename = @"petnurture.data";

@implementation Nurture

- (instancetype)init {
  self = [super init];

  if (self) {
      self.storageUrl = [
          [[NSFileManager defaultManager]
           URLForDirectory:NSDocumentDirectory
           inDomain:NSUserDomainMask
           appropriateForURL:nil
           create:true
           error:nil]

          URLByAppendingPathComponent: NurtureStorageFilename
      ];
  }
    return self;
}

- (BOOL)petSleeping {
    NSArray <NurtureItem *> *nurture = [self loadNurtureItems];

    NSInteger sleepIndex = [nurture indexOfObjectPassingTest:^BOOL(NurtureItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return obj.kind == NurtureItemKindSleep;
  }];

  NSInteger awakeIndex = [nurture indexOfObjectPassingTest:^BOOL(NurtureItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      return obj.kind == NurtureItemKindAwake;
  }];
    return sleepIndex < awakeIndex;
}

- (NSArray <NurtureItem *> *) loadNurtureItems {
    NSError *error;

    if (![[NSFileManager defaultManager] fileExistsAtPath: self.storageUrl.path]) {
        [[NSFileManager defaultManager] createFileAtPath:self.storageUrl.path contents:nil attributes:@{}];
  }

  NSString *content = [NSString stringWithContentsOfURL:self.storageUrl encoding:NSUTF8StringEncoding error:&error];

  if (error) {
      NSLog(@"Something went wrong: %@", error.localizedDescription);
      return @[];
  }

    NSMutableArray <NurtureItem *> *result = [@[] mutableCopy];
    [content enumerateLinesUsingBlock:^(NSString * _Nonnull line, BOOL * _Nonnull stop) {
        NSArray <NSString *> *components = [line componentsSeparatedByString:@","];
        if (components.count != 3) { return; }

        NurtureItem *item = [
            [NurtureItem alloc]
            initWithKind:(NurtureItemKind) [components[0] intValue]
            date:[NSDate dateWithTimeIntervalSince1970:[components[1] doubleValue]]
            attachmentId:[[NSUUID alloc] initWithUUIDString:components[2]]];

        [result insertObject:item atIndex:0];
  }];
    return result;
}

- (NurtureItem *) addNurtureItemOfKind: (NurtureItemKind) kind {
    NurtureItem *nurtureItem = [
        [NurtureItem alloc]
        initWithKind:kind
        date:[[NSDate new] dateByAddingTimeInterval:-1]
        attachmentId:nil];
  return [self addNurtureItem:nurtureItem];
}

- (NurtureItem *) addNurtureItem: (NurtureItem *) item {
  NSDate *date = item.date;
  NSTimeInterval interval = [date timeIntervalSince1970];
  NSString *line = [NSString stringWithFormat:@"%ld,%f,%@\n", (long)item.kind, interval, item.attachmentId == nil ? @"" : item.attachmentId];

  NSFileHandle *handle = [NSFileHandle fileHandleForWritingToURL:self.storageUrl error:nil];

  [handle seekToEndOfFile];
  [handle writeData:[line dataUsingEncoding:NSUTF8StringEncoding] error:nil];
  [handle closeFile];

  return item;
}

- (void) addMomentOnPresenter: (UIViewController *) presenter
                   completion: (void (^ _Nullable)(NurtureItem *)) completion {
    PHPickerConfiguration *configuration = [[PHPickerConfiguration alloc] init];
    configuration.selectionLimit = 1;
    configuration.filter = PHPickerFilter.imagesFilter;

    PHPickerViewController *picker = [[PHPickerViewController alloc] initWithConfiguration: configuration];
    picker.delegate = self;
    self.pickerCompletion = completion;

    [presenter presentViewController:picker animated:true completion:nil];
}

- (void)picker:(PHPickerViewController *)picker didFinishPicking:(NSArray<PHPickerResult *> *)results {
    if (results.count == 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [picker dismissViewControllerAnimated:true completion:nil];
        });
        return;
    }

    PHPickerResult *result = results[0];

    if (result == nil) {
        return;
    }

    [result.itemProvider loadObjectOfClass:[UIImage self]
                       completionHandler:^(__kindof id<NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {
        UIImage *image = object;

        if(error != nil || image == nil) {
            NSLog(@"Something went wrong %@", error.localizedDescription);
            return;
        }

        NSUUID *attachmentId = [self storeImage:image];

        if(!attachmentId) { return; }

        dispatch_async(dispatch_get_main_queue(), ^{
            [picker dismissViewControllerAnimated:true completion:nil];
            NurtureItem *nurtureItem = [
                [NurtureItem alloc] initWithKind:NurtureItemKindMoment
                date:[[NSDate new] dateByAddingTimeInterval:-1]
                attachmentId:attachmentId];

            self.pickerCompletion([self addNurtureItem:nurtureItem]);
        });
    }];
}

- (NSUUID * _Nullable) storeImage:(UIImage * _Nonnull) image {
    NSError *error;

    NSUUID *attachmentId = [NSUUID new];
    CGFloat ratio = 600 / image.size.height;
    CGSize newSize = CGSizeMake(
                                image.size.width * ratio,
                                image.size.height * ratio);
    UIImage *resizedimage = [[[UIGraphicsImageRenderer alloc] initWithSize: newSize] imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
        [image drawInRect: CGRectMake(0, 0, newSize.width, newSize.height)];
    }];

    NSData *imageData = UIImageJPEGRepresentation(resizedimage, 0.75);
    NSURL *imageURL = [[[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:true error:&error] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", attachmentId.UUIDString]];

    if(error != nil) {
        NSLog(@"Failed constructing URL: %@", error.localizedDescription);
        return nil;
    }

    [imageData writeToURL:imageURL atomically:true];
    return attachmentId;
}
@end
