//
//  ViewController.m
//  CustomAnnotation
//
//  Created by mac on 15-11-16.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "HMAnnotation.h"
#import "LSPAnnotationView.h"
@interface ViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)clickBtn;

@property (strong,nonatomic) CLGeocoder *code;
@property (strong,nonatomic) CLLocationManager *mgr;
@end

@implementation ViewController

- (CLGeocoder *)code
{
    if (_code == nil) {
        _code = [[CLGeocoder alloc] init];
    }
    return _code;
}

- (CLLocationManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [[CLLocationManager alloc] init];
    }
    return _mgr;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    [self settingMapView];
    
    
}

- (void)settingMapView
{
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    self.mapView.delegate = self;
    self.mapView.rotateEnabled = NO;
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        [self.mgr requestAlwaysAuthorization];
    }
}

#pragma mark--MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    /*
    static NSString *ID = @"cell";
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (pin == nil) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:ID];
    }
    pin.animatesDrop = YES;
    pin.canShowCallout = YES;
    */
    LSPAnnotationView *pin = [LSPAnnotationView annotationViewWithMapView:mapView];
    pin.annotation = annotation;
    
    return pin;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //反地理编码
    [self.code reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *mark = [placemarks firstObject];
        userLocation.title = mark.name;
        userLocation.subtitle = mark.locality;
        
    }];
    
    //位置区域设置
    /*
    CLLocationCoordinate2D center = userLocation.location.coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.001, 0.002);
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    [self.mapView setRegion:region animated:YES];
     */
    //中心点设置
    [self.mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//点击按钮会添加大头针
- (IBAction)clickBtn {
    
    HMAnnotation *annotation = [[HMAnnotation alloc] init];
    annotation.title = @"太阳宫";
    annotation.subtitle = @"北京朝阳区";
    CGFloat latitude = 36.821199 + arc4random_uniform(20);
    CGFloat longitude = 116.858776 + arc4random_uniform(20);
    annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    annotation.icon = @"category_1";
    
    [self.mapView addAnnotation:annotation];
    
}
@end
