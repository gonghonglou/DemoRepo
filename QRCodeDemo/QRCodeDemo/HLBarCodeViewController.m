
//
//  HLBarCodeViewController.m
//  HLCodeScanDemo
//
//  Created by gonghonglou on 16/8/9.
//  Copyright © 2016年 gonghonglou. All rights reserved.
//

#import "HLBarCodeViewController.h"

@interface HLBarCodeViewController ()

// 输入框
@property(nonatomic, strong) UITextField *textField;
// 显示条形码图片
@property(nonatomic, strong) UIImageView *imageView;

@end

@implementation HLBarCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"BarCodeCreat";
    self.view.backgroundColor = [UIColor whiteColor];
    // 布局
    [self lauoutUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.imageView.image = nil;
    self.textField.text = @"1234567890";
}

#pragma mark - 生成条码图片
- (UIImage *)generateBarCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height {
    CIImage *barcodeImage;
    NSData *data = [code dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    
    [filter setValue:data forKey:@"inputMessage"];
    barcodeImage = [filter outputImage];
    
    // 消除模糊
    CGFloat scaleX = width / barcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = height / barcodeImage.extent.size.height;
    CIImage *transformedImage = [barcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    return [UIImage imageWithCIImage:transformedImage];
}


#pragma mark - 按钮布局
#pragma mark - 按钮布局
- (void)lauoutUI {
    // 显示条形码图片
    self.imageView = [UIImageView new];
    self.imageView.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.1];
    [self.imageView setFrame:CGRectMake(0, 0, 300, 300)];
    self.imageView.center = self.view.center;
    [self.view addSubview:self.imageView];
    // 输入框
    self.textField = [UITextField new];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.frame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y-85, 240, 35);
    self.textField.text = @"1234567890";
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
    // 生成条形码
    UIButton *presentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [presentBtn setFrame:CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y+350, 300, 50)];
    presentBtn.layer.cornerRadius = 10;
    [presentBtn setTitle:@"生成条形码/保存到相册" forState:UIControlStateNormal];
    [presentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [presentBtn setBackgroundColor:[UIColor grayColor]];
    [presentBtn addTarget:self action:@selector(presenrAlertController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:presentBtn];
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
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"生成条形码"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        self.imageView.image = [self generateBarCode:self.textField.text width:300 height:300];
                                                    }];
    UIAlertAction *action5 = [UIAlertAction actionWithTitle:@"保存图片"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        UIImageWriteToSavedPhotosAlbum([self getSaveImage], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
                                                    }];
    [alertController addAction:cancel];
    [alertController addAction:action1];
    [alertController addAction:action5];
    [self presentViewController:alertController animated:YES completion:nil];
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



@end