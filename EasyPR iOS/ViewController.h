//
//  ViewController.h
//  EasyPR iOS
//
//  Created by zhoushiwei on 15/1/30.
//  Copyright (c) 2015年 zhoushiwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UIPopoverControllerDelegate,UIToolbarDelegate> {
    UIPopoverController *popoverController;
    UIImageView *imageView;
    UIImageView *textView;
    UILabel *textLabel;
    UIImage* image;
    cv::CascadeClassifier faceCascade;
    cv::Mat source_image;
}
@property (nonatomic, retain) UILabel *textLabel;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIImageView *textView;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *loadButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

-(IBAction)loadButtonPressed:(id)sender;
-(IBAction)loadButtonCameraPressed:(id)sender;
-(IBAction)saveButtonPressed:(id)sender;
-(UIImage*)plateRecognition:(cv::Mat&)src;
@end
