//
//  ViewController.m
//  FileManager
//
//  Created by Crystal on 2017/4/5.
//  Copyright © 2017年 crystal. All rights reserved.
//

#import "ViewController.h"
#import "FileManager.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[FileManager defaultManager] createFileDirectory];
    [[FileManager defaultManager] postFilesToBackStage];

    dispatch_queue_t currentQueue = dispatch_queue_create("writeFile.concurrent.queue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(currentQueue, ^(){
        [[FileManager defaultManager] writeContentWith:@"a1111" rebotId:@"A01"];
    });
    dispatch_async(currentQueue, ^(){
        [[FileManager defaultManager] writeContentWith:@"a2222" rebotId:@"A01"];
    });
    dispatch_async(currentQueue, ^(){
        [[FileManager defaultManager] writeContentWith:@"b1111111111" rebotId:@"B01"];
    });
    dispatch_async(currentQueue, ^(){
        [[FileManager defaultManager] writeContentWith:@"c1111111111" rebotId:@"C01"];
    });
    dispatch_async(currentQueue, ^(){
        [[FileManager defaultManager] writeContentWith:@"a3333" rebotId:@"A01"];
    });
    dispatch_async(currentQueue, ^(){
        [[FileManager defaultManager] writeContentWith:@"a4444" rebotId:@"A01"];
    });
    dispatch_async(currentQueue, ^(){
        [[FileManager defaultManager] writeContentWith:@"a5555" rebotId:@"A01"];
    });
    dispatch_async(currentQueue, ^(){
        [[FileManager defaultManager] writeContentWith:@"a6666" rebotId:@"A01"];
    });    dispatch_async(currentQueue, ^(){
        [[FileManager defaultManager] writeContentWith:@"b2222" rebotId:@"B01"];
    });    dispatch_async(currentQueue, ^(){
        [[FileManager defaultManager] writeContentWith:@"b3333" rebotId:@"B01"];
    });
    
    dispatch_async(currentQueue, ^(){
        [[FileManager defaultManager] writeContentWith:@"c2222" rebotId:@"C01"];
    });
    
}

- (IBAction)clickWrite:(id)sender {
    if (self.textView.text.length) {
        [[FileManager defaultManager] writeContentWith:self.textView.text rebotId:@"A01"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
