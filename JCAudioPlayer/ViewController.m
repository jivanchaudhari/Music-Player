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
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            status = true;
            
        }
    }
    
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:musicURL options:nil];
    
    NSArray *titles = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyTitle keySpace:AVMetadataKeySpaceCommon];
    NSArray *artists = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyArtist keySpace:AVMetadataKeySpaceCommon];
    NSArray *albumNames = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyAlbumName keySpace:AVMetadataKeySpaceCommon];
    
    AVMetadataItem *title = [titles objectAtIndex:0];
    AVMetadataItem *artist = [artists objectAtIndex:0];
    AVMetadataItem *albumName = [albumNames objectAtIndex:0];
    
    
    NSArray *keys = [NSArray arrayWithObjects:@"commonMetadata", nil];
    [asset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
        NSArray *artworks = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata
                                                           withKey:AVMetadataCommonKeyArtwork
                                                          keySpace:AVMetadataKeySpaceCommon];
        
        for (AVMetadataItem *item in artworks) {
            if ([item.keySpace isEqualToString:AVMetadataKeySpaceID3]) {
                //                NSDictionary *d = [item.value copyWithZone:nil];
                
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
    
    if ([button.currentImage isEqual:[UIImage imageNamed:@"play.png"]]) {
        
        if (isPlaying) {
        
            [audioPlayer play];
        
    }
    else {
        if ([self initilizeAudioPlayer]) {
            
            [audioPlayer play];
            isPlaying = true;
            
        }
        else {
            NSLog(@"Something is wrong in music player.");
            
        }
    }
        [button setImage:[UIImage imageNamed:@"puase.png"] forState:UIControlStateNormal];
    }
    else if ([button.currentImage isEqual:[UIImage imageNamed:@"puase.png"]]) {
        [audioPlayer pause];
        
        [button setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        
    }
    
}

- (IBAction)actionStop:(id)sender {
    
    
    [audioPlayer stop];
    isPlaying = false;
    
    [self.buttonPlay setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];


}
@end
