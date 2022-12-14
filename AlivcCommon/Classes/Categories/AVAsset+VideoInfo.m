//
//  AVAsset+VideoInfo.m
//  AliyunVideo
//
//  Created by dangshuai on 17/1/13.
//  Copyright (C) 2010-2017 Alibaba Group Holding Limited. All rights reserved.
//

#import "AVAsset+VideoInfo.h"

@implementation AVAsset (VideoInfo)

- (CGSize)avAssetNaturalSize {
    AVAssetTrack *assetTrackVideo;
    NSArray *videoTracks = [self tracksWithMediaType:AVMediaTypeVideo];
    if (videoTracks.count) {
        assetTrackVideo = videoTracks[0];
    }
    CGAffineTransform trackTrans = assetTrackVideo.preferredTransform;
    CGSize size = CGSizeApplyAffineTransform(assetTrackVideo.naturalSize, trackTrans);
    return CGSizeMake(fabs(size.width), fabs(size.height));
}

- (float)frameRate {
    AVAssetTrack *assetTrackVideo;
    NSArray *videoTracks = [self tracksWithMediaType:AVMediaTypeVideo];
    if (videoTracks.count) {
        assetTrackVideo = videoTracks[0];
    }
    return assetTrackVideo.nominalFrameRate;
}

- (CGFloat)avAssetVideoTrackDuration {
    
    NSArray *videoTracks = [self tracksWithMediaType:AVMediaTypeVideo];
    if (videoTracks.count) {
        AVAssetTrack *track = videoTracks[0];
        return CMTimeGetSeconds(CMTimeRangeGetEnd(track.timeRange));
    }
    
    NSArray *audioTracks = [self tracksWithMediaType:AVMediaTypeAudio];
    if (audioTracks.count) {
        AVAssetTrack *track = audioTracks[0];
        return CMTimeGetSeconds(CMTimeRangeGetEnd(track.timeRange));
    }
    
    return -1;
}

- (CGFloat)avAssetAudioTrackDuration {
    NSArray *audioTracks = [self tracksWithMediaType:AVMediaTypeAudio];
    if (audioTracks.count) {
        AVAssetTrack *track = audioTracks[0];
        return CMTimeGetSeconds(CMTimeRangeGetEnd(track.timeRange));
    }
    
    return -1;
}

- (NSString *)title {
    NSArray<AVMetadataItem *> *artists = [AVMetadataItem metadataItemsFromArray:self.commonMetadata withKey:AVMetadataCommonKeyTitle keySpace:AVMetadataKeySpaceCommon];
    if (artists.count) {
        return (NSString *)[artists[0] value];
    }
    return nil;
}

- (NSString *)artist {
    NSArray<AVMetadataItem *> *artists = [AVMetadataItem metadataItemsFromArray:self.commonMetadata withKey:AVMetadataCommonKeyArtist keySpace:AVMetadataKeySpaceCommon];
    if (artists.count) {
        return (NSString *)[artists[0] value];
    }
    return nil;
}
@end
