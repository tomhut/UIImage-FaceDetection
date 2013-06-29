#import "UIImage+FaceDetection.h"

@implementation UIImage (FaceDetection)

- (NSArray *)facesWithAccuracy :(NSString *)detectorAccuracy {
    CIImage *coreImageRepresentation = [[CIImage alloc] initWithImage:self];
    
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:[NSDictionary dictionaryWithObject:detectorAccuracy forKey:CIDetectorAccuracy]];
    
    NSArray *features = [detector featuresInImage:coreImageRepresentation];
    
    NSMutableArray *faces = [[NSMutableArray alloc] init];
    
    for (CIFaceFeature *face in features) {
        [faces addObject:face];
    }
        
    return [faces copy];
}

@end