//
//  testSearchVC.m
//  LocalTool
//
//  Created by lofi on 2024/7/16.
//

#import "testSearchVC.h"
#import <LKUtils/LKMacroDefine.h>
#import <LKDisplayModule/UserAgreeVC.h>
#import <LKMediaKit/CWB.h>

@interface testSearchVC ()
@property (weak, nonatomic) IBOutlet UITextField *tf_search;

@end

@implementation testSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%lf",KScreen_Width);
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


@end
