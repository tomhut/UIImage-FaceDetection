#import "UIImage+FaceDetection.h"

@implementation UIImage (FaceDetection)

- (NSArray *)facesWithAccuracy :(NSString *)detectorAccuracy {
    CIImage *coreImageRepresentation = [[CIImage alloc] initWithImage:self];

    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:[NSDictionary dictionaryWithObject:detectorAccuracy forKey:CIDetectorAccuracy]];

    NSArray *features = [detector featuresInImage:coreImageRepresentation];

    return features;
}

- (CIFaceFeature *)largestFaceWithAccuracy :(NSString *)detectorAccuracy {
    
    NSArray *faces = [self facesWithAccuracy:detectorAccuracy];
    
    float currentLargestWidth = 0;
    CIFaceFeature *largestFace;
    
    for (CIFaceFeature *face in faces) {
        if (face.bounds.size.width > currentLargestWidth) {
            largestFace = face;
            currentLargestWidth = face.bounds.size.width;
        }
    }
    
    return largestFace;
}

- (UIImage *)croppedAroundLargestFaceWithAccuracy :(NSString *)detectorAccuracy {
    CIFaceFeature *largestFace = [self largestFaceWithAccuracy:detectorAccuracy];

    CIImage *coreImage = [[CIImage alloc] initWithImage:self];
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *faceImage =
    [coreImage imageByCroppingToRect:largestFace.bounds];
    UIImage *croppedImage = [UIImage imageWithCGImage:[context createCGImage:faceImage
                                                                    fromRect:faceImage.extent]];

    return croppedImage;
}

@end