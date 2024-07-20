//
//  testSearchVC.m
//  LocalTool
//
//  Created by lofi on 2024/7/16.
//

#import "testSearchVC.h"
#import <LKUtils/LKMacroDefine.h>
#import <LKUIDisplayModule/UserAgreeVC.h>

@interface testSearchVC ()
@property (weak, nonatomic) IBOutlet UITextField *tf_search;

@end

@implementation testSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%lf",KScreen_Width);
    NSLog(@"%@_IPhoneX",Kis_IPhoneX ? @"is" : @"not");
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)actionCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionGotoUserAgree:(id)sender {
    UserAgreeVC * vc = [[UserAgreeVC alloc] init];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:NO completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
