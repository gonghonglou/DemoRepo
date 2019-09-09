//
//  HLQRCodeViewController.m
//  HLCodeScanDemo
//
//  Created by gonghonglou on 16/8/9.
//  Copyright © 2016年 gonghonglou. All rights reserved.
//

#import "HLQRCodeViewController.h"

@interface HLQRCodeViewController ()

// 输入框
@property(nonatomic, strong) UITextField *textField;
// 显示二维码图片
@property(nonatomic, strong) UIImageView *imageView;
// 中心图片
@property(nonatomic, strong) UIImageView *centerView;

@end

@implementation HLQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"QRCodeCreat";
    self.view.backgroundColor = [UIColor whiteColor];
    // 布局
    [self lauoutUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.imageView.image = nil;
    self.textField.text = @"gonghonglou.com";
    self.centerView.hidden = YES;
}

#pragma mark - 按钮布局
- (void)lauoutUI {
    // 显示二维码图片
    self.imageView = [UIImageView new];
    self.imageView.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.1];
    [self.imageView setFrame:CGRectMake(0, 0, 300, 300)];
    self.imageView.center = self.view.center;
    [self.view addSubview:self.imageView];
    // 输入框
    self.textField = [UITextField new];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.frame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y-85, 240, 35);
    self.textField.text = @"gonghonglou.com";
    [self.view addSubview:self.textField];
    // 完成按钮
    UIButton *resignBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [resignBtn setFrame:CGRectMake(self.textField.frame.origin.x+235, self.textField.frame.origin.y, 65, 35)];
    resignBtn.layer.cornerRadius = 4.0;
    [resignBtn setTitle:@"放弃键盘" forState:UIControlStateNormal];
    [resignBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [resignBtn setBackgroundColor:[UIColor grayColor]];
    [resignBtn addTarget:self action:@selector(resignKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resignBtn];
    // 生成二维码并做些处理
    UIButton *presentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [presentBtn setFrame:CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y+350, 300, 50)];
    presentBtn.layer.cornerRadius = 10;
    [presentBtn setTitle:@"生成二维码并做些处理" forState:UIControlStateNormal];
    [presentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [presentBtn setBackgroundColor:[UIColor grayColor]];
    [presentBtn addTarget:self action:@selector(presenrAlertController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:presentBtn];
    // 中心图片
    self.centerView = [UIImageView new];
    self.centerView.image = [UIImage imageNamed:@"centerSignImage"];
    self.centerView.frame = CGRectMake(120, 120, 60, 60);
    self.centerView.layer.cornerRadius = 6.0;
    self.centerView.layer.masksToBounds = YES;
    [self.imageView addSubview:self.centerView];
    self.centerView.hidden = YES;
}

// 完成按钮
- (void)resignKeyboard {
    [self.textField resignFirstResponder];
}

// 生成二维码并做些处理
- (void)presenrAlertController {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"生成二维码"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       self.imageView.image = [self generateQRCode:self.textField.text width:300 height:300];
                                                       
                                                    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"二维码上色（前景＋背景）"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        self.imageView.image = [self gaveColor:self.textField.text width:300 height:300];
                                                    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"二维码上色（随意上色）"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        self.imageView.image = [self generateQRCode:self.textField.text width:300 height:300];
                                                        self.imageView.image = [self imageBlackToTransparent:[self getSaveImage]];
                                                    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"添加中心图片"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        self.centerView.hidden = NO;
                                                    }];
    UIAlertAction *action5 = [UIAlertAction actionWithTitle:@"保存图片"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        UIImageWriteToSavedPhotosAlbum([self getSaveImage], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
                                                    }];
    [alertController addAction:cancel];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [alertController addAction:action4];
    [alertController addAction:action5];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 生成二维码方法
- (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height {
    CIImage *qrcodeImage;
    NSData *data = [code dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    qrcodeImage = [filter outputImage];
    
    // 消除模糊
    CGFloat scaleX = width / qrcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = height / qrcodeImage.extent.size.height;
    CIImage *transformedImage = [qrcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    return [UIImage imageWithCIImage:transformedImage];
}

#pragma mark - 二维码上色方法
- (UIImage *)gaveColor:(NSString *)code width:(CGFloat)width height:(CGFloat)height {
    NSData *data = [code dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    //上色
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage",filter.outputImage,
                             @"inputColor0",[CIColor colorWithCGColor:[UIColor purpleColor].CGColor], // 前景色
                             @"inputColor1",[CIColor colorWithCGColor:[UIColor cyanColor].CGColor], // 背景色
                             nil];
    CIImage *qrcodeImage = colorFilter.outputImage;
    
    // 消除模糊
    CGFloat scaleX = width / qrcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = height / qrcodeImage.extent.size.height;
    CIImage *transformedImage = [qrcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    return [UIImage imageWithCIImage:transformedImage];
}

#pragma mark -  返回需要保存的image方法
- (UIImage *)getSaveImage {
    // 开启位图上下文
    UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, NO, 0);
    // 获取绘图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 将图片渲染的上下文中
    [self.imageView.layer renderInContext:context];
    // 获取上下文中的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭位图上下文
    UIGraphicsEndImageContext();
    //
    return image;
}

#pragma mark -  指定回调方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *string;
    if(!error){
        string = @"保存成功";
        NSLog(@"save success");
    }else{
        string = @"保存失败";
        NSLog(@"save failed");
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:string
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"完成"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


#pragma mark - 二维码随意上色
// 颜色变化
void ProviderReleaseData (void *info, const void *data, size_t size) {
    free((void *)data);
}
- (UIImage *)imageBlackToTransparent:(UIImage *)image {
    // 分配内存
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t *rgbImageBuf = (uint32_t *)malloc(bytesPerRow * imageHeight);
    
    // 创建context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t *pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++) {
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900) {
            // 改变下面的代码，将图片转成想要的颜色
            uint8_t *ptr = (uint8_t *)pCurPtr;
            if (i<pixelNum/2) {
                ptr[3] = 1; //0~255
                ptr[2] = 200;
                ptr[1] = 200;
            } else {
                ptr[3] = 200; //0~255
                ptr[2] = 1;
                ptr[1] = 200;
            }
        } else { // 白色 255,255,255
            uint8_t *ptr = (uint8_t *)pCurPtr;
            ptr[0] = 0;
        }
    }
    
    // 将内存转成image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight,ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider, NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage *resultUIImage = [UIImage imageWithCGImage:imageRef];
    
    // 释放
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    return resultUIImage;
}

@end
