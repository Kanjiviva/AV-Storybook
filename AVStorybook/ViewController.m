//
//  ViewController.m
//  AVStorybook
//
//  Created by Steve on 2015-09-11.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVAudioRecorderDelegate , AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *displayView;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) AVAudioRecorder *audioRecorder;

@property (strong, nonatomic) NSDictionary *recordSettings;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapRecognizer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    NSString *fileName = [NSString stringWithFormat:@"%@_%@", [[NSProcessInfo processInfo] globallyUniqueString], @"file.aac"];
    self.page.audio = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:fileName]];
    
    
    self.recordSettings = @{
                            AVFormatIDKey:@(kAudioFormatMPEG4AAC),
                            AVLinearPCMBitDepthKey:@16,
                            AVLinearPCMIsBigEndianKey:@0,
                            AVLinearPCMIsFloatKey:@0,
                            AVNumberOfChannelsKey:@2,
                            AVSampleRateKey:@44100
                            };
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.displayView.image = self.page.image;
    self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:self.page.audio settings:self.recordSettings error:nil];
//    NSLog(@"%@ - error %@, reocrder: %@", self.page.audio, error, self.audioRecorder);
}

- (IBAction)cameraBtn:(id)sender {
    
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    
    UIAlertController *view = [UIAlertController
                                 alertControllerWithTitle:nil
                                 message:nil
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *photo = [UIAlertAction
                         actionWithTitle:@"Photo Library"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             //Do some thing here
                             pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//                             [view dismissViewControllerAnimated:YES completion:nil];
                             [self presentViewController:pickerController animated:YES completion:nil];
                             
                         }];
    UIAlertAction *camera = [UIAlertAction
                             actionWithTitle:@"Camera"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                                 [self presentViewController:pickerController animated:YES completion:nil];
                                 
                             }];
    
    UIAlertAction *cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction * action)
                             {
                                 
                                [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [view addAction:photo];
    
    [view addAction:cancel];
    
    if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)]) {
        [view addAction:camera];
    }
    
    pickerController.delegate = self;
    
    [self presentViewController:view animated:YES completion:nil];
    
}


- (IBAction)microphoneBtn:(UIButton *)sender {
    
//    NSError *error = nil;
    
    if (self.audioRecorder.isRecording) {
        
        [self.audioRecorder stop];
//        self.audioRecorder = nil;
    } else {
        
        
        
        [self.audioRecorder record];
    }
    
    [sender setSelected:!sender.selected];
}
- (IBAction)tapRecognizer:(id)sender {
    CGPoint tapLocation = [self.tapRecognizer locationInView:self.displayView];
    UIImageView *hitView = (UIImageView *)[self.displayView hitTest:tapLocation withEvent:nil];
    
    if ([hitView isKindOfClass:[UIImageView class]]) {
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.page.audio error:nil];
        [self.audioPlayer play];
    }
    
    
    
}

#pragma mark - UIImagePickerController Delegate -

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.page.image = info[UIImagePickerControllerOriginalImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
