//
//  ViewController.m
//  EasyPR iOS
//
//  Created by zhoushiwei on 15/1/30.
//  Copyright (c) 2015年 zhoushiwei. All rights reserved.
//
#import "ViewController.h"
#import "UIImageCVMatConverter.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize imageView;
@synthesize loadButton;
@synthesize saveButton;
@synthesize popoverController;
@synthesize toolbar;

- (NSInteger)supportedInterfaceOrientations
{
    //only portrait orientation
    return UIInterfaceOrientationMaskPortrait;
}



- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [popoverController dismissPopoverAnimated:YES];
    }
    else
    {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    UIImage* temp = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    UIImage *temp_image=[UIImageCVMatConverter scaleAndRotateImageBackCamera:temp];
    source_image=[UIImageCVMatConverter cvMatFromUIImage:temp_image];
    imageView.image = temp_image;
    [saveButton setEnabled:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [popoverController dismissPopoverAnimated:YES];
    }
    else
    {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)loadButtonPressed:(id)sender {
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    if (![UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypePhotoLibrary])
        return;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        if ([self.popoverController isPopoverVisible])
        {
            [self.popoverController dismissPopoverAnimated:YES];
        }
        else
        {
            if ([UIImagePickerController isSourceTypeAvailable:
                 UIImagePickerControllerSourceTypePhotoLibrary])
            {
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                self.popoverController = [[UIPopoverController alloc]
                                          initWithContentViewController:picker];
                
                popoverController.delegate = self;
                
                [self.popoverController
                 presentPopoverFromBarButtonItem:sender
                 permittedArrowDirections:UIPopoverArrowDirectionUp
                 animated:YES];
            }
        }
    }
    else
    {
        [self presentViewController:picker animated:YES completion:nil];
    }
}

- (IBAction)loadButtonCameraPressed:(id)sender {
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    if (![UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera])
        return;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        if ([self.popoverController isPopoverVisible])
        {
            [self.popoverController dismissPopoverAnimated:YES];
        }
        else
        {
            if ([UIImagePickerController isSourceTypeAvailable:
                 UIImagePickerControllerSourceTypeCamera])
            {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                self.popoverController = [[UIPopoverController alloc]
                                          initWithContentViewController:picker];
                
                popoverController.delegate = self;
                
                [self.popoverController
                 presentPopoverFromBarButtonItem:sender
                 permittedArrowDirections:UIPopoverArrowDirectionUp
                 animated:YES];
            }
        }
    }
    else
    {
        [self presentViewController:picker animated:YES completion:nil];
    }
}

- (IBAction)saveButtonPressed:(id)sender {
    if (image != nil)
    {
        UIImageWriteToSavedPhotosAlbum(image, self, nil, NULL);
        //Alert window
        UIAlertView *alert = [UIAlertView alloc];
        alert = [alert initWithTitle:@"Gallery info"
                             message:@"The image was saved to the Gallery!"
                            delegate:self
                   cancelButtonTitle:@"Continue"
                   otherButtonTitles:nil];
        [alert show];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect bounds = [UIScreen mainScreen].bounds;
    imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height);
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:imageView];
    toolbar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, bounds.size.height- 44, bounds.size.width, 44)];
    [toolbar setBackgroundColor:[UIColor clearColor]];
    //   toolbar.barStyle=UIBarStyleDefault;
    toolbar.tintColor=[UIColor blackColor];
    toolbar.translucent=YES;
    //   [toolbar setTranslucent:YES];
    [self.toolbar setBackgroundImage:[UIImage new]
                  forToolbarPosition:UIBarPositionAny
                          barMetrics:UIBarMetricsDefault];
    toolbar.delegate=self;
    UIBarButtonItem*barItem0 = [[UIBarButtonItem alloc]
                                initWithTitle:@"嘴巴"
                                style:UIBarButtonItemStylePlain
                                target:self
                                action:@selector(startCaptureButtonPressed:)];
    UIBarButtonItem*barItem1 = [[UIBarButtonItem alloc]
                                
                                initWithTitle:@"眼睛"
                                
                                style:UIBarButtonItemStylePlain
                                
                                target:self
                                
                                action:@selector(stopCaptureButtonPressed:)];
    UIBarButtonItem*TrainingItem= [[UIBarButtonItem alloc]
                                   
                                   initWithTitle:@"识别"
                                   
                                   style:UIBarButtonItemStylePlain
                                   
                                   target:self
                                   
                                   action:@selector(TraningPressed:)];
    UIBarButtonItem*flexitem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem*albumitem=[[UIBarButtonItem alloc]
                               
                               initWithTitle:@"相册"
                               style:UIBarButtonItemStylePlain
                               
                               target:self
                               
                               action:@selector(loadButtonPressed:)];
    
    UIBarButtonItem*cameraitem=[[UIBarButtonItem alloc]
                                
                                initWithTitle:@"相机"
                                style:UIBarButtonItemStylePlain
                                
                                target:self
                                
                                action:@selector(loadButtonCameraPressed:)];
  
    
    [toolbar setItems:[NSArray arrayWithObjects:barItem0 ,flexitem,barItem1 ,flexitem,TrainingItem ,flexitem,albumitem,flexitem,cameraitem,
                       flexitem, nil]];
    [self.view addSubview:toolbar];
    
    // Do any additional setup after loading the view, typically from a nib
    toolbar.autoresizingMask = UIViewAutoresizingNone;
  
    
    [saveButton setEnabled:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end