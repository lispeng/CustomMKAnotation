//
//  LSPAnnotationView.m
//  CustomAnnotation
//
//  Created by mac on 15-11-16.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPAnnotationView.h"
#import "HMAnnotation.h"
@implementation LSPAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.canShowCallout = YES;
    }
    return self;
}

+ (instancetype)annotationViewWithMapView:(MKMapView *)mapView
{
    static NSString *ID = @"LSPAnnotationView";
    LSPAnnotationView *annotationView = (LSPAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (annotationView == nil) {
        annotationView = [[LSPAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:ID];
    }
    return annotationView;
}

- (void)setAnnotation:(HMAnnotation *)annotation
{
    [super setAnnotation:annotation];
    self.image = [UIImage imageNamed:annotation.icon];
}
@end
