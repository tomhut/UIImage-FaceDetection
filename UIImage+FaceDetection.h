#import <UIKit/UIKit.h>

@interface UIImage (FaceDetection)

- (NSArray *)facesWithAccuracy :(NSString *)detectorAccuracy;

@end
