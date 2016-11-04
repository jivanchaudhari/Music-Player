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
    
}
@property (strong, nonatomic) IBOutlet UIImageView *imageArtWork;

@property (strong, nonatomic) IBOutlet UIButton *buttonPlay;

- (IBAction)actionPlay:(id)sender;


- (IBAction)actionStop:(id)sender;

@end

