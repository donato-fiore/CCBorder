@import Foundation;
@import UIKit;

@interface MTMaterialView : UIView
@end

@interface CCUIContentModuleContentContainerView : UIView {
	MTMaterialView *_moduleMaterialView;
}
@end

@interface MRUContinuousSliderView : UIView
@property (readonly, nonatomic) UIView *materialView;
@end

@interface FCUIActivityControl : UIView {
	MTMaterialView *_backgroundView;
}
@end

@interface MRUControlCenterView : UIView
@property (retain, nonatomic) UIView *materialView;
@end

@interface _FCUIAddActivityControl : UIView {
	MTMaterialView *_backgroundMaterialView;
}
@end

@interface MTMaterialView (Private)
- (id)_viewControllerForAncestor;
@end

@interface MediaControlsVolumeSliderView : UIView {
	UIView *_materialView;
}
@end

%hook CCUIContentModuleContentContainerView
// Most CC modules
- (void)layoutSubviews {
	%orig;
	MTMaterialView *matView = MSHookIvar<MTMaterialView *>(self, "_moduleMaterialView");
	if (!matView) return;

	[matView setAlpha:0.0];
	self.layer.borderWidth = 1.0;
	self.layer.borderColor = [UIColor whiteColor].CGColor;
	[self.layer setCornerRadius:matView.layer.cornerRadius];
}

%end

%hook MRUContinuousSliderView
// Volume slider iOS 16+
- (void)layoutSubviews {
	%orig;
	if (!self.materialView) return;

	[self.materialView setAlpha:0.0];
	self.layer.borderWidth = 1.0;
	self.layer.borderColor = [UIColor whiteColor].CGColor;
	[self.layer setCornerRadius:self.materialView.layer.cornerRadius];
}

%end

%hook MediaControlsVolumeSliderView
// Volume slider iOS 15-
- (void)layoutSubviews {
	%orig;
	
	MTMaterialView *matView = MSHookIvar<MTMaterialView *>(self, "_materialView");
	if (!matView) return;

	[matView setAlpha:0.0];
	self.layer.borderWidth = 1.0;
	self.layer.borderColor = [UIColor whiteColor].CGColor;
	[self.layer setCornerRadius:matView.layer.cornerRadius];
}

%end

%hook FCUIActivityControl
// 3d touch on focus
- (void)layoutSubviews {
	%orig;

	MTMaterialView *matView = MSHookIvar<MTMaterialView *>(self, "_backgroundView");
	if (!matView) return;

	[matView setAlpha:0.0];

	self.layer.borderWidth = 1.0;
	self.layer.borderColor = [UIColor whiteColor].CGColor;
	[self.layer setCornerRadius:matView.layer.cornerRadius];
}

%end

%hook MRUControlCenterView
// Music player

- (void)layoutSubviews {
	%orig;
	if (!self.materialView) return;

	[self.materialView setAlpha:0.0];
	self.layer.borderWidth = 1.0;
	self.layer.borderColor = [UIColor whiteColor].CGColor;
	[self.layer setCornerRadius:self.materialView.layer.cornerRadius];
}

%end

%hook _FCUIAddActivityControl
// tiny + button when 3d touching on dnd module
- (void)layoutSubviews {
	%orig;

	MTMaterialView *matView = MSHookIvar<MTMaterialView *>(self, "_backgroundMaterialView");
	if (!matView) return;

	[matView setAlpha:0.0];

	self.layer.borderWidth = 1.0;
	self.layer.borderColor = [UIColor whiteColor].CGColor;
	[self.layer setCornerRadius:matView.layer.cornerRadius];
}

%end

%hook MTMaterialView
// dnd module
- (void)layoutSubviews {
	%orig;
	if ([[self _viewControllerForAncestor] isKindOfClass:NSClassFromString(@"FCCCControlCenterModule")]) {
		[self setAlpha:0.0];

		self.superview.layer.borderWidth = 1.0;
		self.superview.layer.borderColor = [UIColor whiteColor].CGColor;
		[self.superview.layer setCornerRadius:self.layer.cornerRadius];
	}
}

%end