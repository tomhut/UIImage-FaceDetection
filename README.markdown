## Description

UIImage+FaceDetection is an Objective-C category for `UIImage`. It gives `UIImage` the ability to return a 'CIFaceFeature' for each face found within the image.

## Use

1.  Add the CoreImage framework to your project
2.  Add the files 'UIImage+FaceDetection.h' & 'UIImage+FaceDetection.m' to your project
3.  Import the header using  `#import "UIImage+FaceDetection.h"`
4.  Call the `- (NSArray *)facesWithAccuracy :(NSString *)detectorAccuracy` method in the following way:

<pre>
UIImage *myImage = [UIImage imageNamed:@"exampleImage.png"];
NSArray *faces = [myImage facesWithAccuracy:CIDetectorAccuracyHigh];
</pre>

## Other Functions
Return the largest face from the image 
`- (CIFaceFeature *)largestFaceWithAccuracy :(NSString *)detectorAccuracy`

## Future

1.  Better handling when an invalid or nil 'CIDetectorAccuracy' is passed in.
2.  Return nil or error when no faces are found.
3.  Additional methods for returning smallest face.
4.  Additional methods for returning centre-most, left-most & right-most faces.
5.  Add podspec.

## License

Released under ISC (similar to 2-clause BSD)

http://wikipedia.org/wiki/ISC_license