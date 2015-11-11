//
//  ViewController.m
//  MapView
//
//  Created by zero on 15/11/10.
//  Copyright © 2015年 zerorobot. All rights reserved.
//

#import "ViewController.h"
#import "MyAnnotation.h"

@interface ViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.zoomEnabled = YES;
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
//    self.mapView.region = MKCoordinateRegionMake((CLLocationCoordinate2D){23.08,113.15}, (MKCoordinateSpan){0.1,0.1});
    
    
    UIButton *addAnnotationBtn = [[UIButton alloc]initWithFrame:(CGRect){10,50,100,50}];
    
    [addAnnotationBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [addAnnotationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addAnnotationBtn setTitle:@"添加" forState:UIControlStateNormal];
//    [addAnnotationBtn setBackgroundColor:[UIColor whiteColor]];
    [addAnnotationBtn addTarget:self action:@selector(addAnnotationBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addAnnotationBtn];
}

/**
 *  添加自定义大头针
 */
-(void)addAnnotationBtnDidClick:(UIButton*)btn
{
    /**
      大头针数据模型
     */
    MyAnnotation *myAnnotation = [[MyAnnotation alloc]init];
    
    myAnnotation.coordinate = (CLLocationCoordinate2D){23.08,113.5};
    myAnnotation.title = @"测试1";
    myAnnotation.subtitle = @"次标题";
    myAnnotation.imageName = @"light_88";
    
    //  添加大头针，就会执行下面viewForAnnotation方法
    [self.mapView addAnnotation:myAnnotation];
}
#pragma mark  - MKMapViewDelegate

/**
 *  自定义大头针
 */
- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
   
    // 判断annotation的类型
    if (![annotation isKindOfClass:[MyAnnotation class]]) return nil;

    /**
     *  自定义大头针 类似 TableViewCell
     *  注：MKAnnotationView子类：MKPinAnnotationView
        * @property (nonatomic) MKPinAnnotationColor pinColor;
          大头针颜色
        * @property (nonatomic) BOOL animatesDrop;
          大头针第一次显示时是否从天而降
     */
    static NSString *ID = @"MyAnnotation";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if(annotationView == nil)
    {
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:ID];
        /**
         *  是否显示标注
         */
        annotationView.canShowCallout = YES;
        /**
         *  标注右边显示什么控件
         */
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
        /**
         *  标注左边显示什么控件
         */
        annotationView.leftCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
        /**
         *  标注的偏移量
         */
        annotationView.calloutOffset = (CGPoint){0,-10};
        /**
         *  是否第一添加从天而降
         */
        annotationView.animatesDrop = YES;
        
    }
    
    annotationView.annotation = annotation;
    // 设置图片
    MyAnnotation *myAnnotion = annotation;
    annotationView.image = [UIImage imageNamed:myAnnotion.imageName];
    return annotationView;
}

/**
 *  这两个方法是地图可见区域改变而执行。

 */
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    NSLog(@"--%s--%d",__FUNCTION__,__LINE__);
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"--%s--%d",__FUNCTION__,__LINE__);
}
/**
 *  这三个方法是加载地图
 */
//- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView
//{
//    NSLog(@"--%s--%d",__FUNCTION__,__LINE__);
//}
//- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
//    NSLog(@"--%s--%d",__FUNCTION__,__LINE__);
//}
//- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error{
//    NSLog(@"--%s--%d",__FUNCTION__,__LINE__);
//}

/**
 *  这两个方法在地图可见区域加载，如果可见区域加载过了，就不会执行这两个方法，它会从缓存中取出。
 */
//- (void)mapViewWillStartRenderingMap:(MKMapView *)mapView {
//    NSLog(@"--%s--%d",__FUNCTION__,__LINE__);
//}
//- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered
//{
//    NSLog(@"--%s--%d",__FUNCTION__,__LINE__);
//}

/**
 *  用户的位置变化
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"--%s--%d",__FUNCTION__,__LINE__);
    [mapView setCenterCoordinate:userLocation.coordinate animated:YES];
    
}
@end
