#import <UIKit/UIKit.h>

@interface UIImage (FaceDetection)

- (NSArray *)facesWithAccuracy :(NSString *)detectorAccuracy;
- (CIFaceFeature *)largestFaceWithAccuracy :(NSString *)detectorAccuracy;

@end
