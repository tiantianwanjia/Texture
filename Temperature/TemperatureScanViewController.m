//
//  TemperatureScanViewController.m
//  Temperature
//
//  Created by muma on 2020/3/2.
//  Copyright © 2020 yuanwenxue. All rights reserved.
//

#import "TemperatureScanViewController.h"
#import "TemperatureUserInterfaceViewController.h"
#import <Photos/Photos.h>

static CGFloat scanTime = 3.0;
static CGFloat borderLineWidth = 0.5;
static CGFloat cornerLineWidth = 1.5;
static CGFloat scanLineWidth = 42;
static NSString *const scanLineAnimationName = @"scanLineAnimation";

@interface TemperatureScanViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (nonatomic , strong) AVCaptureDeviceInput *deviceInput;
@property (nonatomic , strong) AVCaptureMetadataOutput *dataOurput;
@property (nonatomic , strong) AVCaptureSession *session;
@property (nonatomic , strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic , strong) AVCaptureDevice *device;

@property (nonatomic , strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) UIView *scanLine;
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic , strong) UIView *maskView;
/**
 上下移动的扫描线的颜色
 */
@property (nonatomic, strong) UIColor *scanLineColor;

/**
 四角的线的颜色
 */
@property (nonatomic, strong) UIColor *cornerLineColor;

/**
 扫描边框的颜色，默认为白色
 */
@property (nonatomic, strong) UIColor *borderLineColor;


@property (nonatomic , strong) UIView *loadContenView;
/**
 是否显示上下移动的扫描线，默认为YES
 */
@property (nonatomic, assign, getter=isShowScanLine) BOOL showScanLine;

/**
 是否显示边框，默认为NO
 */
@property (nonatomic, assign, getter=isShowBorderLine) BOOL showBorderLine;

/**
 是否显示四角，默认为YES
 */
@property (nonatomic, assign, getter=isShowCornerLine) BOOL showCornerLine;

@property (nonatomic , strong) NSString *signCodeString;

@property (nonatomic , assign) CGFloat totalScale;
@property (nonatomic , strong) NSString *signTimeStr;


@end

@implementation TemperatureScanViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   if (_session) {
        [self showScanLine:self.isShowScanLine];
        [self.session startRunning];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.totalScale = 1.0;
    [self setDeviceVideoZoomFacter];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",@[@""][9]);
    self.totalScale = 1.0;
    //再次增加，只是想提交这一个文件2222222
    
    self.view.backgroundColor = WhiteColor;
    
    [self setUI];
    
    UIButton *returenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returenButton.frame = CGRectMake(0, 20, 50, 50);
    [returenButton setImage:[UIImage imageNamed:@"nav_return"] forState:0];
    [returenButton addTarget:self action:@selector(handlReturenmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returenButton];
    
}

- (void)setUI{
   
    self.view.backgroundColor = WhiteColor;
    _loadContenView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _loadContenView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_loadContenView];
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [self.loadContenView addGestureRecognizer:pinchGestureRecognizer];
    
    _signCodeString = @"";
    _showScanLine = YES;
    _showCornerLine = YES;
    _showBorderLine = YES;
    
    if (![self isCameraAvailable]){
        [MBProgressHUD showError:@"设备无相机" toView:self.view];
        return;
    }
    
    if (![self isRearCameraAvailable] && ![self isFrontCameraAvailable]) {
        [MBProgressHUD showError:@"相机出错" toView:self.view];
        return;
    }

    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
        if (granted){// 用户同意授权
            dispatch_async(dispatch_get_main_queue(), ^{
            
                [self connectionWithMediaType:AVMediaTypeVideo formConnections:[[self dataOurput] connections]];
                
                [self.deviceInput.device lockForConfiguration:nil];
                if ([self.device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance]) {
                    [self.deviceInput.device setWhiteBalanceMode:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance];
                }
                if (self.device.isFocusPointOfInterestSupported && [self.device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
                    [self.deviceInput.device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
                }
                if ([self.device isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure]) {
                    [self.deviceInput.device setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
                }
                [self.deviceInput.device unlockForConfiguration];
                
                
                [self.loadContenView.layer insertSublayer:self.previewLayer above:0];
                [self.session startRunning];
                
                [self.view addSubview:self.maskView];
                [self.view addSubview:self.middleView];
                [self.middleView addSubview:self.scanLine];
                
                
                if (self.isShowBorderLine){
                    [self addScanBorderLine];
                }
                if (self.isShowCornerLine) {
                    [self addCornerLines];
                }
                [self showScanLine:self.isShowScanLine];
           
                UILabel *interLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 205) / 2, SCREEN_HEIGHT / 2 + (SCREEN_WIDTH * 3/4 / 2) + 10 , 205, 16)];
                interLabel.text = @"将二维码/条形码放入框内，即可自动扫描";
                interLabel.textAlignment = NSTextAlignmentCenter;
                interLabel.font = Font(10);
                interLabel.textColor = RGB(0x999999);
                interLabel.backgroundColor = RGBAColor(0, 0, 0, 0.2);
                [self.view addSubview:interLabel];
            });
        }else {// 用户拒绝授权
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"请打开麦克风访问权限" toView:[UIApplication sharedApplication].windows[0]];
            });
        }
    }];
}

#pragma mark -- 默认一个可扫描范围
- (CGRect)scanRect{
    CGSize scanSize = CGSizeMake(SCREEN_WIDTH * 3/4, SCREEN_WIDTH * 3/4);
    CGRect scanRect = CGRectMake((SCREEN_WIDTH - scanSize.width)/2, (SCREEN_HEIGHT - scanSize.height)/2, scanSize.width, scanSize.height);
    return scanRect;
}

#pragma mark -- AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
   
    if (metadataObjects.count == 0) {
        [MBProgressHUD showError:@"未识别二维码" toView:self.view];
        return;
    }
    
    AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
    NSString *result = [metadataObject stringValue];
    NSString *type = [metadataObject type];
    
    //自动聚焦放大
    AVMetadataMachineReadableCodeObject *obj = (AVMetadataMachineReadableCodeObject *)[_previewLayer transformedMetadataObjectForMetadataObject:metadataObjects.lastObject];
    [self changeVideoScale:obj];
    

    WeakMySelf
    [self.session stopRunning];
    
    [_deviceInput.device lockForConfiguration:nil];
    if ([_device lockForConfiguration:nil]) {
        [_device setVideoZoomFactor:1.0];
        [_device unlockForConfiguration];
    }
    
    self.totalScale = 1.0;
    [self setDeviceVideoZoomFacter];
    //信息处理
    [self showScanLine:NO];
    if ([type hasSuffix:@"QRCode"]) {//二维码
            [NetRequest GET:ScanQrCoder parameterOtherPassString:result success:^(id responseObject) {
                if (!responseObject[@"staff"]) {
                    [MBProgressHUD showError:@"该二维码不存在" toView:self.view];
                    return;
                }
                if ([responseObject[@"times"] intValue] > 1) {
                    [MBProgressHUD showError:@"此证当前已在园区系统记录" toView:self.view];
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    TemperatureUserInterfaceViewController *inetVc = [TemperatureUserInterfaceViewController new];
                    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:responseObject[@"staff"]];
                    userDic[@"staffId"] = result;
                    inetVc.userInfoerDic = userDic;
                    inetVc.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self presentViewController:inetVc animated:YES completion:^{
                           
                    }];
                });

        } failure:^(NSError *error) {
            
        }];
    }
}

#pragma mark -- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSString *result = [self messageFromQRCodeImage:image];
    if (result.length != 0) {
        [MBProgressHUD showError:@"未识别二维码" toView:self.view];
        return;
    }
    //信息处理
    NSLog(@"相册识别二维码输出信息===%@",result);
}

#pragma mark -- 识别相册图片中二维码
- (NSString *)messageFromQRCodeImage:(UIImage *)image{
    if (!image) {
        return nil;
    }
    CIContext *context = [CIContext contextWithOptions:nil];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    CIImage *ciImage = [CIImage imageWithCGImage:image.CGImage];
    NSArray *features = [detector featuresInImage:ciImage];
    
    if (features.count == 0) {
        return nil;
    }
    
    CIQRCodeFeature *feature = features.firstObject;
    return feature.messageString;
}

#pragma mark - bezierPath
- (void)addScanBorderLine{
    CGRect borderRect = CGRectMake(self.scanRect.origin.x + borderLineWidth, self.scanRect.origin.y + borderLineWidth, self.scanRect.size.width - 2*borderLineWidth, self.scanRect.size.height - 2*borderLineWidth);
    UIBezierPath *scanBezierPath = [UIBezierPath bezierPathWithRect:borderRect];
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.path = scanBezierPath.CGPath;
    lineLayer.lineWidth = borderLineWidth;
    lineLayer.strokeColor = self.borderLineColor.CGColor;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    [self.view.layer addSublayer:lineLayer];
}

- (void)addCornerLines{
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = cornerLineWidth;
    lineLayer.strokeColor = self.cornerLineColor.CGColor;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    CGFloat halfLineLong = self.scanRect.size.width / 12;
    UIBezierPath *lineBezierPath = [UIBezierPath bezierPath];
    
    CGFloat spacing = cornerLineWidth/2;
    
    CGPoint leftUpPoint = (CGPoint){self.scanRect.origin.x + spacing ,self.scanRect.origin.y + spacing};
    [lineBezierPath moveToPoint:(CGPoint){leftUpPoint.x,leftUpPoint.y + halfLineLong}];
    [lineBezierPath addLineToPoint:leftUpPoint];
    [lineBezierPath addLineToPoint:(CGPoint){leftUpPoint.x + halfLineLong,leftUpPoint.y}];
    lineLayer.path = lineBezierPath.CGPath;
    [self.view.layer addSublayer:lineLayer];
    
    
    CGPoint leftDownPoint = (CGPoint){self.scanRect.origin.x + spacing,self.scanRect.origin.y + self.scanRect.size.height - spacing};
    [lineBezierPath moveToPoint:(CGPoint){leftDownPoint.x,leftDownPoint.y - halfLineLong}];
    [lineBezierPath addLineToPoint:leftDownPoint];
    [lineBezierPath addLineToPoint:(CGPoint){leftDownPoint.x + halfLineLong,leftDownPoint.y}];
    lineLayer.path = lineBezierPath.CGPath;
    [self.view.layer addSublayer:lineLayer];
    
    CGPoint rightUpPoint = (CGPoint){self.scanRect.origin.x + self.scanRect.size.width - spacing,self.scanRect.origin.y + spacing};
    [lineBezierPath moveToPoint:(CGPoint){rightUpPoint.x - halfLineLong,rightUpPoint.y}];
    [lineBezierPath addLineToPoint:rightUpPoint];
    [lineBezierPath addLineToPoint:(CGPoint){rightUpPoint.x,rightUpPoint.y + halfLineLong}];
    lineLayer.path = lineBezierPath.CGPath;
    [self.view.layer addSublayer:lineLayer];
    
    CGPoint rightDownPoint = (CGPoint){self.scanRect.origin.x + self.scanRect.size.width - spacing,self.scanRect.origin.y + self.scanRect.size.height - spacing};
    [lineBezierPath moveToPoint:(CGPoint){rightDownPoint.x - halfLineLong,rightDownPoint.y}];
    [lineBezierPath addLineToPoint:rightDownPoint];
    [lineBezierPath addLineToPoint:(CGPoint){rightDownPoint.x,rightDownPoint.y - halfLineLong}];
    lineLayer.path = lineBezierPath.CGPath;
    [self.view.layer addSublayer:lineLayer];
}


- (void)showScanLine:(BOOL)showScanLine{
    if (showScanLine) {
        [self addScanLineAnimation];
    }
    else{
        [self removeScanLineAnimation];
    }
}

- (void)addScanLineAnimation{
    self.scanLine.hidden = NO;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.fromValue = @(- scanLineWidth);
    animation.toValue = @(self.scanRect.size.height - scanLineWidth);
    animation.duration = scanTime;
    animation.repeatCount = OPEN_MAX;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.scanLine.layer addAnimation:animation forKey:scanLineAnimationName];
}


- (void)removeScanLineAnimation{
    [self.scanLine.layer removeAnimationForKey:scanLineAnimationName];
    self.scanLine.hidden = YES;
}

- (CGRect)scanRectOfInterest{
    CGRect scanRect = [self scanRect];
    scanRect = CGRectMake(scanRect.origin.y / SCREEN_HEIGHT, scanRect.origin.x / SCREEN_WIDTH, scanRect.size.height / SCREEN_HEIGHT, scanRect.size.width / SCREEN_WIDTH);
    return scanRect;
}

// 处理缩放手势
- (void)pinchView:(UIPinchGestureRecognizer *)recognizer
{
    CGFloat scale = recognizer.scale;
    //放大情况
    if(scale > 1.0){
        if(self.totalScale > 10.0) return;
    }
    
    //缩小情况
    if (scale < 1.0) {
        if (self.totalScale < 1.05) return;
    }
    
    //self.loadContenView.transform = CGAffineTransformScale(self.loadContenView.transform, scale, scale);
    self.totalScale *=scale;
    recognizer.scale = 1.0;
    [self setDeviceVideoZoomFacter];
   
}

- (void)setDeviceVideoZoomFacter{
    NSError *error = nil;
    [self.device lockForConfiguration:&error];
    if (!error) {
        if (self.totalScale < 1.0) {
             self.device.videoZoomFactor = 1.0;
        }else{
             self.device.videoZoomFactor = self.totalScale;
        }
    }else
    {
        NSLog(@"error = %@", error);
    }
    [self.device unlockForConfiguration];
}

#pragma mark -- 下面三个方法是放大二维码
- (void)changeVideoScale:(AVMetadataMachineReadableCodeObject *)obj{
    NSArray *array = obj.corners;
    CGPoint point = CGPointZero;
    int index = 0;
    CFDictionaryRef dict = (__bridge CFDictionaryRef)(array[index++]);
    CGPointMakeWithDictionaryRepresentation(dict, &point);
    CGPoint point2 = CGPointZero;
    CGPointMakeWithDictionaryRepresentation((__bridge CFDictionaryRef)array[2], &point2);
    CGFloat scace = 250 / (point2.x - point.x);
    if (scace > 1) {
        for (CGFloat i = 1.0; i <= scace; i = i + 0.001) {
            [self setVideoScale:i];
        }
    }
    return;
}

- (void)setVideoScale:(CGFloat)scale{
    [_deviceInput.device lockForConfiguration:nil];
    
    AVCaptureConnection *videoConnection = [self connectionWithMediaType:AVMediaTypeVideo formConnections:[[self dataOurput] connections]];
    CGFloat maxScaleAndCropFactor = ([[self.dataOurput connectionWithMediaType:AVMediaTypeVideo] videoMaxScaleAndCropFactor]) / 16;
    if (scale > maxScaleAndCropFactor) {
        scale = maxScaleAndCropFactor;
        //CGFloat zoom = scale / videoConnection.videoScaleAndCropFactor;
        videoConnection.videoScaleAndCropFactor = scale;
        [_deviceInput.device unlockForConfiguration];
        if ([_device lockForConfiguration:nil]) {
            [_device setVideoZoomFactor:2.0];
            [_device unlockForConfiguration];
        }
    }
}


- (AVCaptureConnection *)connectionWithMediaType:(NSString *)mediaType formConnections:(NSArray *)connections{
    for (AVCaptureConnection *connection in connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:mediaType]) {
                return connection;
            }
        }
    }
    return nil;
}

- (AVCaptureDevice *)device{
    if (!_device) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}

- (AVCaptureDeviceInput *)deviceInput{
    if (!_deviceInput) {
        NSError *error;
        _deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
        if (error) {
        }
    }
    return _deviceInput;
}

- (AVCaptureMetadataOutput *)dataOurput{
    if (!_dataOurput) {
        _dataOurput = [[AVCaptureMetadataOutput alloc] init];
        [_dataOurput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        _dataOurput.rectOfInterest = [self scanRectOfInterest];
    }
    return _dataOurput;
}

- (AVCaptureSession *)session{
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
        [_session setSessionPreset:(SCREEN_HEIGHT < 500 ? AVCaptureSessionPreset640x480 : AVCaptureSessionPreset1920x1080)];
        if ([_session canAddInput:self.deviceInput]) {
            [_session addInput:self.deviceInput];
        }
        
        if ([_session canAddOutput:self.dataOurput]) {
            [_session addOutput:self.dataOurput];
            //AVMetadataObjectTypeQRCode为二维码，其余的都为条形码
            self.dataOurput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                                    AVMetadataObjectTypeEAN13Code,
                                                    AVMetadataObjectTypeEAN8Code,
                                                    AVMetadataObjectTypeUPCECode,
                                                    AVMetadataObjectTypeCode39Code,
                                                    AVMetadataObjectTypeCode39Mod43Code,
                                                    AVMetadataObjectTypeCode93Code,
                                                    AVMetadataObjectTypeCode128Code,
                                                    AVMetadataObjectTypePDF417Code];
        }
    }
    return _session;
}

- (AVCaptureVideoPreviewLayer *)previewLayer{
    if (!_previewLayer) {
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _previewLayer.frame = [UIScreen mainScreen].bounds;
    }
    return _previewLayer;
}

- (UIImagePickerController *)imagePicker{
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    return _imagePicker;
}

- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _maskView.backgroundColor = RGBAColor(0, 0, 0, 0.5);
        UIBezierPath *bpath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) ];
        [bpath appendPath:[[UIBezierPath bezierPathWithRect:[self scanRect]] bezierPathByReversingPath]];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = bpath.CGPath;
        _maskView.layer.mask = shapeLayer;
        _maskView.userInteractionEnabled = NO;
    }
    return _maskView;
}

- (UIView *)middleView{
    if (!_middleView) {
        _middleView = [[UIView alloc]initWithFrame:self.scanRect];
        _middleView.clipsToBounds = YES;
        _middleView.userInteractionEnabled = NO;
    }
    return _middleView;
}

- (UIView *)scanLine{
    if (!_scanLine) {
        _scanLine = [[UIView alloc]initWithFrame:CGRectMake(0,0, self.scanRect.size.width, scanLineWidth)];
        _scanLine.hidden = YES;
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.startPoint = CGPointMake(0.5, 0);
        gradient.endPoint = CGPointMake(0.5, 1);
        gradient.frame = _scanLine.layer.bounds;
        gradient.colors = @[(__bridge id)[self.scanLineColor colorWithAlphaComponent:0].CGColor,(__bridge id)[self.scanLineColor colorWithAlphaComponent:0.4f].CGColor,(__bridge id)self.scanLineColor.CGColor];
        gradient.locations = @[@0,@0.96,@0.97];
        [_scanLine.layer addSublayer:gradient];
    }
    return _scanLine;
}


- (UIColor *)cornerLineColor{
    if (!_cornerLineColor) {
        _cornerLineColor = RGB(0xFF8464);
    }
    return _cornerLineColor;
}

- (UIColor *)borderLineColor{
    if (!_borderLineColor) {
        _borderLineColor = [UIColor clearColor];
    }
    return _borderLineColor;
}

- (UIColor *)scanLineColor{
    if (!_scanLineColor) {
        _scanLineColor = RGB(0xFF8464);
    }
    return _scanLineColor;
}


//相机是否存在，比如早期iPad，模拟器，itouch
- (BOOL)isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
//前置摄像头是否正常
- (BOOL)isFrontCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}
//后置摄像头是否正常
- (BOOL)isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}


- (void)handlReturenmButtonAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    

}

@end
