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

- (CGRect)boundsOfAllFacesWithAccuracy :(NSString *)detectorAccuracy {
    NSArray *faces = [self facesWithAccuracy:detectorAccuracy];

    CGRect faceBounds = CGRectMake(0, 0, 0, 0);
    CGRect newBounds = CGRectMake(0, 0, 0, 0);
    NSUInteger faceNumber = 0;
    for (CIFaceFeature *face in faces) {
        if (faceNumber == 0) {
            faceBounds = face.bounds;
            newBounds = faceBounds;
        }

        else {
            if (face.bounds.origin.x < faceBounds.origin.x) {
                newBounds.origin.x = face.bounds.origin.x;
                newBounds.size.width = (faceBounds.size.width + (newBounds.origin.x + faceBounds.origin.x));
            }
            if ((face.bounds.origin.x + face.bounds.size.width) > (faceBounds.origin.x + faceBounds.size.width)) {
                newBounds.size.width = (face.bounds.size.width + faceBounds.origin.x);
            }

            if ((face.bounds.origin.y + face.bounds.size.height) > (faceBounds.origin.y + faceBounds.size.height)) {
                newBounds.size.height = (face.bounds.origin.y + face.bounds.size.height);
            }

            if (face.bounds.origin.y < faceBounds.origin.y) {
                newBounds.origin.y = face.bounds.origin.y;
                newBounds.size.height = ((faceBounds.origin.y - face.bounds.origin.y) +  faceBounds.size.height);
            }

        }
        faceBounds = newBounds;
        faceNumber++;
    }
    return faceBounds;
}


@end