//
//  HLCodeScanViewController.m
//  HLCodeScanDemo
//
//  Created by gonghonglou on 16/7/31.
//  Copyright © 2016年 gonghonglou. All rights reserved.
//

#import "HLCodeScanViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface HLCodeScanViewController () <AVCaptureMetadataOutputObjectsDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

// 设备
@property(nonatomic, strong) AVCaptureDevice *device;
// 会话
@property(nonatomic, strong) AVCaptureSession *session;
// 输入流
@property(nonatomic, strong) AVCaptureDeviceInput *input;
// 输出流
@property(nonatomic, strong) AVCaptureMetadataOutput *output;
// 绘制层
@property(nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
// 背景视图
@property(nonatomic, strong) UIView *scanView;
// 扫描框
@property(nonatomic, strong) UIImageView *imageView;
// 是否开灯
@property(nonatomic, assign) BOOL lightOn;
// 开灯按钮
@property(nonatomic, strong) UIButton *lightBtn;

@end

@implementation HLCodeScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CodeScan";
    // 视图布局
    [self lauoutUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 初始化设置
    [self codeScanSetting];
    // 开始会话
    [self.session startRunning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 停止会话
    [self.session stopRunning];
    self.session = nil;
}

#pragma mark - 初始化设置
- (void)codeScanSetting {
    // 获取相机权限状态
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusAuthorized) {
        NSLog(@"相机允许状态");
    } else if (authStatus == AVAuthorizationStatusDenied) {
        NSLog(@"相机不允许状态，可以弹出一个alertview提示用户在隐私设置中开启权限");
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        NSLog(@"系统还未知是否访问，第一次开启相机时");
    }
    
    // 1.获取AVCaptureDevice实例
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2.初始化输入流
    NSError *error;
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
    if (!self.input) {
        NSLog(@"%@", [error localizedDescription]);
        return;
    }
    
    // 3.初始化输出流
    AVCaptureMetadataOutput *captureMetadataOutput = [AVCaptureMetadataOutput new];
    // 3.1设置代理及所在线程
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    // 3.2设置扫描区域
    [captureMetadataOutput setRectOfInterest:[self scanPlace]];
   
    // 4.创建会话
    self.session = [AVCaptureSession new];
    // 4.1添加输入流
    [self.session addInput:self.input];
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    // 4.2添加输出流
    if ([self.session canAddOutput:captureMetadataOutput]) {
        [self.session addOutput:captureMetadataOutput];
    }
    // 3.3设置扫码格式
    captureMetadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeUPCECode,
                                                  AVMetadataObjectTypeCode39Code,
                                                  AVMetadataObjectTypeCode39Mod43Code,
                                                  AVMetadataObjectTypeEAN13Code,
                                                  AVMetadataObjectTypeEAN8Code,
                                                  AVMetadataObjectTypeCode93Code,
                                                  AVMetadataObjectTypeCode128Code,
                                                  AVMetadataObjectTypePDF417Code,
                                                  AVMetadataObjectTypeQRCode, // 二维码
                                                  AVMetadataObjectTypeAztecCode];
    
    // 5创建输出对象
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.previewLayer setFrame:self.scanView.layer.bounds];
    [self.scanView.layer addSublayer:self.previewLayer];
}

#pragma mark - 代理方法处理输出流
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        NSString *result = metadataObj.stringValue;
        if (!result) {
            result = @"未发现有效二维码／条形码";
        }
        //
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[metadataObj type]
                                                                                 message:result
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"完成"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           [self closeScanQRCode];
                                                       }];
        [alertController addAction:cancel];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - 返回扫描区域
- (CGRect)scanPlace {
    CGFloat scanX = self.imageView.frame.origin.y/self.view.frame.size.height;
    CGFloat scanY = self.imageView.frame.origin.x/self.view.frame.size.width;
    CGFloat scanWidth = self.imageView.frame.size.height/self.view.frame.size.height;
    CGFloat scanHeight = self.imageView.frame.size.width/self.view.frame.size.width;
    NSLog(@"扫描区域Rect：\n     x = %f \n     y = %f \n width = %f \nheight = %f", scanX, scanY, scanWidth, scanHeight);
    
    return CGRectMake(scanX, scanY, scanWidth, scanHeight);
}

#pragma mark - 开灯或关灯
- (void)turnLight {
    // 判断允许设置
    if ([self.device hasTorch]) {
        [self.device lockForConfiguration:nil];
        if (!self.lightOn) {
            self.lightOn = YES;
            [self.device setTorchMode:AVCaptureTorchModeOn];
            [self.lightBtn setTitle:@"关灯" forState:UIControlStateNormal];
        } else {
            self.lightOn = NO;
            [self.device setTorchMode:AVCaptureTorchModeOff];
            [self.lightBtn setTitle:@"开灯" forState:UIControlStateNormal];
        }
        [self.device unlockForConfiguration];
    }
}

#pragma mark - 打开相册
- (void)openPhotoLibrary {
    UIImagePickerController *photoPicker = [UIImagePickerController new];
    photoPicker.delegate = self;
    // 打开的相册类型
    photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:photoPicker animated:YES completion:NULL];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:^{
        // 读取二维码
        UIImage *sourceImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        CIContext *context = [CIContext contextWithOptions:nil];
        CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
        CIImage *image = [CIImage imageWithCGImage:sourceImage.CGImage];
        NSArray *array = [detector featuresInImage:image];
        CIQRCodeFeature *feature = [array firstObject];
        NSString *result = feature.messageString;
        if (!result) {
            result = @"未发现有效二维码／条形码";
        }
        //
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:result
                                                                                 message:nil
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"完成"
                                                         style:UIAlertActionStyleCancel
                                                       handler:nil];
        [alertController addAction:cancel];
        [self presentViewController:alertController animated:YES completion:nil];

        NSLog(@"result:%@", result);
    }];
}

#pragma mark - 关闭此页面
- (void)closeScanQRCode {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 按钮布局
- (void)lauoutUI {
    // 背景视图，为添加AVCaptureVideoPreviewLayer
    self.scanView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.scanView];
    // 扫描框
    self.imageView = [UIImageView new];
    [self.imageView setFrame:CGRectMake(0, 0, 300, 300)];
    self.imageView.center = self.view.center;
    self.imageView.image = [UIImage imageNamed:@"QRCodeImage"];
    [self.view addSubview:self.imageView];
    // 开灯按钮
    self.lightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.lightBtn setFrame:CGRectMake(50, 100, 50, 50)];
    self.lightBtn.layer.cornerRadius = 25;
    [self.lightBtn setTitle:@"开灯" forState:UIControlStateNormal];
    [self.lightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.lightBtn setBackgroundColor:[UIColor grayColor]];
    [self.lightBtn addTarget:self action:@selector(turnLight) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.lightBtn];
    // 相册按钮
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [photoBtn setFrame:CGRectMake(150, 100, 50, 50)];
    photoBtn.layer.cornerRadius = 25;
    [photoBtn setTitle:@"相册" forState:UIControlStateNormal];
    [photoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [photoBtn setBackgroundColor:[UIColor grayColor]];
    [photoBtn addTarget:self action:@selector(openPhotoLibrary) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:photoBtn];

}

@end
