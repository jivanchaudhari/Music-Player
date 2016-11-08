//
//  ViewController.h
//  JCAudioPlayer
//
//  Created by Student P_02 on 04/11/16.
//  Copyright © 2016 Jivan Chaudhari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface ViewController : UIViewController
{
    AVAudioPlayer *audioPlayer;
    
    BOOL isPlaying;
    UISlider *slider;
    NSTimer *timer;
    
}
@property (strong, nonatomic) IBOutlet UIImageView *imageArtWork;

@property (strong, nonatomic) IBOutlet UISlider *sliderDuration;

@property (strong, nonatomic) IBOutlet UILabel *labelTitle;

@property (strong, nonatomic) IBOutlet UIButton *buttonPlay;
@property (strong, nonatomic) IBOutlet UILabel *labelArites;
@property (strong, nonatomic) IBOutlet UILabel *labelAlbumName;

@property (strong, nonatomic) IBOutlet UILabel *labelSliderValueMinimum;

@property (strong, nonatomic) IBOutlet UILabel *labelSliderMaximumValue;


- (IBAction)actionPlay:(id)sender;
- (IBAction)sliderControl:(id)sender;


- (IBAction)actionStop:(id)sender;

@end

