#import <UIKit/UIKit.h>

@interface UIImage (FaceDetection)

- (NSArray *)facesWithAccuracy :(NSString *)detectorAccuracy;
- (CIFaceFeature *)largestFaceWithAccuracy :(NSString *)detectorAccuracy;
- (UIImage *)croppedAroundLargestFaceWithAccuracy :(NSString *)detectorAccuracy;
- (CGRect)boundsOfAllFacesWithAccuracy :(NSString *)detectorAccuracy;
@end
