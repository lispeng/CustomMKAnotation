//
//  LSPAnnotationView.h
//  CustomAnnotation
//
//  Created by mac on 15-11-16.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface LSPAnnotationView : MKAnnotationView
+ (instancetype)annotationViewWithMapView:(MKMapView *)mapView;
@end
