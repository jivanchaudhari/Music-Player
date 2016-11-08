//
//  ViewController.m
//  JCAudioPlayer
//
//  Created by Student P_02 on 04/11/16.
//  Copyright © 2016 Jivan Chaudhari. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    isPlaying = false;
    
    self.sliderDuration.userInteractionEnabled = YES;
    
    self.sliderDuration.minimumValue = 0;
    self.sliderDuration.value = 0;
    
    [self.sliderDuration setThumbImage:[UIImage imageNamed:@"thumb"] forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)startTimer {
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateDurationSlider) userInfo:nil repeats:YES];
    
    
    [self.sliderDuration setValue:audioPlayer.currentTime];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateDuration) userInfo:nil repeats:YES];

}
-(void)updateDuration{
    self.labelSliderMaximumValue.text = [NSString stringWithFormat:@"%0.02f",audioPlayer.currentTime];
    NSLog(@" hi %f",audioPlayer.currentTime);

}

-(void)updateDurationSlider {
    
    if (self.sliderDuration.value == audioPlayer.duration) {
        timer = nil;

        
    }
    
    self.sliderDuration.value = audioPlayer.currentTime;
    
}
-(void)timeDuration {
    
 
}
-(BOOL)initilizeAudioPlayer {
    
    BOOL status = false;
    
    NSURL *musicURL = [[NSBundle mainBundle]URLForResource:@"myMusic" withExtension:@"mp3"];
    
    if (musicURL != nil) {
        
        NSError *error;
        
        audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:musicURL error:&error];
        
        if (error != nil) {
            
            NSLog(@"%@",error.localizedDescription);
            
        }
        else {
            
            self.sliderDuration.maximumValue = audioPlayer.duration;
            
            status = true;
            
        }
    }
    
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:musicURL options:nil];
    
    
    CMTime audioDuration = asset.duration;
    float audioDurationSeconds = CMTimeGetSeconds(audioDuration);

    
    
    
        NSDateComponentsFormatter *componentFormatter = [[NSDateComponentsFormatter alloc] init];
    
        componentFormatter.unitsStyle = NSDateComponentsFormatterUnitsStylePositional;
        componentFormatter.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorDropAll;
    
        NSString *formattedString = [componentFormatter stringFromTimeInterval:audioDurationSeconds];
        NSLog(@"%@",formattedString); // 5:26
    
    
    self.labelSliderValueMinimum.text = formattedString;
    
    
    NSArray *metadata = [asset commonMetadata];
    
    NSString *titleOfSong;
    
    NSString *aritistOfSong;
    NSString *albumNameOfSong;


    for (AVMetadataItem *item in metadata) {
        
        if ([[item commonKey] isEqualToString:@"title"]) {
            
            titleOfSong = (NSString *)[item value];
            
        }
        if ([[item commonKey] isEqualToString:@"artist"]) {
            
            aritistOfSong = (NSString *)[item value];
            
        }
        if ([[item commonKey] isEqualToString:@"albumName"]) {
            
            albumNameOfSong = (NSString *)[item value];
            
        }
        
    }
    self.labelTitle.text = titleOfSong;
    
    
    self.labelArites.text = aritistOfSong;
    self.labelAlbumName.text = albumNameOfSong;
    
    
    NSArray *keys = [NSArray arrayWithObjects:@"commonMetadata", nil];
    [asset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
        NSArray *artworks = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata
                                                           withKey:AVMetadataCommonKeyArtwork
                                                          keySpace:AVMetadataKeySpaceCommon];
        
        for (AVMetadataItem *item in artworks) {
            if ([item.keySpace isEqualToString:AVMetadataKeySpaceID3]) {
                
                NSData *data = [item.value copyWithZone:nil];
                UIImage *image = [UIImage imageWithData:data];
                
                self.imageArtWork.image = image;

            } else if ([item.keySpace isEqualToString:AVMetadataKeySpaceiTunes]) {
                self.imageArtWork.image = [UIImage imageWithData:[item.value copyWithZone:nil]];
            }
        }
    }];
    
    
    

    return  status;
    
}



- (IBAction)actionPlay:(id)sender {
    
   UIButton *button = sender;
    
    
    if (button.tag == 101) {
        
        if (isPlaying) {
        
            [audioPlayer play];
            [self startTimer];
            
        
    }
    else {
        if ([self initilizeAudioPlayer]) {
            
            [audioPlayer play];
            [self startTimer];

            isPlaying = true;
            
        }
        else {
            NSLog(@"Something is wrong in music player.");
            
        }
    }
        
        [button setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
        button.tag = 102;
        
    }
    else if (button.tag == 102) {
        [audioPlayer pause];
        
        [timer  invalidate];

        button.tag = 101;
        [button setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        
    }
    
}
//
//- (IBAction)sliderControl:(id)sender {

    
    //
//    [self initilizeAudioPlayer];
//    
//    UISlider *localSlider=sender;
//    float value;
//    value=localSlider.value;
//    self.labelSliderMaximumValue .text=[NSString stringWithFormat:@"%0.02f",localSlider.value];
//
//
//}
- (IBAction)actionStop:(id)sender {
    
    
    [audioPlayer stop];
    isPlaying = false;
    
    [self.buttonPlay setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
   self.buttonPlay.tag = 101;


}
@end
