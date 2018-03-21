
#import <UIKit/UIKit.h>
#import "MacroDefine.h"
#import "UIView+Extension.h"
#import "UPSHttpNetWorkTool.h"

@interface CommonUtils : NSObject

+ (UILabel*)createLabelWithText:(NSString*)string frame:(CGRect)frame;

+ (UITextView*)createTextViewWithText:(NSString*)string frame:(CGRect)frame;

+ (UITextField*)createTextFieldWithText:(NSString*)string frame:(CGRect)frame;

+ (UIButton*)createButtonWithText:(NSString*)string frame:(CGRect)frame;

@end
