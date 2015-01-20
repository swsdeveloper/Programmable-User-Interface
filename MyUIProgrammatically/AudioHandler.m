//
//  AudioHandler.m
//  MyUIProgrammatically
//
//  Created by Steven Shatz on 1/20/15.
//  Copyright (c) 2015 Steven Shatz. All rights reserved.
//

#import "AudioHandler.h"

@implementation AudioHandler

- (AVAudioPlayer *)setupAudioPlayer1 {
    NSString *audioFileName = @"Scream";
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource: audioFileName ofType: @"wav"];
    NSURL *soundFileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    NSError *error = nil;
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: soundFileURL error: &error];
    if (!error) {
        [audioPlayer setVolume:0.5];
        [audioPlayer prepareToPlay];
    } else {
        audioPlayer = nil;
        NSLog(@"Error in creating '%@' audio player: %@", audioFileName, [error description]);
    }
    return audioPlayer;
}

- (AVAudioPlayer *)setupAudioPlayer2 {
    NSString *audioFileName = @"Machinery";
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource: audioFileName ofType: @"wav"];
    NSURL *soundFileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    NSError *error = nil;
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: soundFileURL error: &error];
    if (!error) {
        [audioPlayer setVolume:1.0];
        audioPlayer.enableRate = YES;
        audioPlayer.rate = 2.0;
        [audioPlayer prepareToPlay];
    } else {
        audioPlayer = nil;
        NSLog(@"Error in creating '%@' audio player: %@", audioFileName, [error description]);
    }
    return audioPlayer;
}

- (AVAudioPlayer *)setupAudioPlayer3 {
    NSString *audioFileName = @"ButtonPress";
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource: audioFileName ofType: @"wav"];
    NSURL *soundFileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    NSError *error = nil;
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: soundFileURL error: &error];
    if (!error) {
        [audioPlayer setVolume:1.0];
        [audioPlayer prepareToPlay];
    } else {
        audioPlayer = nil;
        NSLog(@"Error in creating '%@' audio player: %@", audioFileName, [error description]);
    }
    return audioPlayer;
}

@end
