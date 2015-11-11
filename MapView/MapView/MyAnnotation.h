//
//  MyAnnotation.h
//  MapView
//
//  Created by zero on 15/11/11.
//  Copyright © 2015年 zerorobot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MyAnnotation : NSObject<MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy,) NSString *subtitle;
@property(nonatomic,strong)NSString *imageName;
@end
