MVVM ARC Demo
============

I writing some MVVM and ARC demo. Very conducive to learning.

Contents
----------

##### Demo_01

![Demo_01](Demo_01/screenshot.gif " Demo_01")

ViewControler.h
```Objective-C
@interface ViewController () {
    ViewModel *_viewModel;
}

@property (strong, nonatomic) IBOutlet UITextField *leftOperandTF;      // 左操作数TextField
@property (strong, nonatomic) IBOutlet UITextField *rightOperandTF;     // 右操作数TextField
@property (strong, nonatomic) IBOutlet UISegmentedControl *operationSC; // 操作符SegmentedControl
@property (strong, nonatomic) IBOutlet UILabel *resultLabel;            // 显示结果的Label

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _viewModel = [[ViewModel alloc] init];
    
    RAC(_viewModel, leftOperandValue) = self.leftOperandTF.rac_textSignal;
    RAC(_viewModel, rightOperandValue) = self.rightOperandTF.rac_textSignal;
    RAC(_viewModel, basicOperator) = [self.operationSC rac_newSelectedSegmentIndexChannelWithNilValue:@0];
    RAC(self.resultLabel, text) = RACObserve(_viewModel, resultString);
}

@end
```

ViewModel.h
```Objective-C
@interface ViewModel() {
    
}

@property (strong, nonatomic, readwrite) NSString *leftOperandValue;
@property (strong, nonatomic, readwrite) NSString *rightOperandValue;
@property (assign, nonatomic, readwrite) BasicOperator basicOperator;
@property (strong, nonatomic, readwrite) NSString *resultString;
@property (strong, nonatomic, readwrite) RACCommand *calculateCommand;

@end

@implementation ViewModel


- (instancetype)init {
    if (self = [super init]) {
        @weakify(self);
        RAC(self, resultString) = [RACSignal combineLatest:@[RACObserve(self, leftOperandValue),RACObserve(self, rightOperandValue), RACObserve(self, basicOperator)] reduce:^id(NSString *v1, NSString *v2){
            @strongify(self);
            if(v1.length > 0 && v2.length > 0) {
                return [self p_calculate];
            } else {
                return nil;
            }
        }];
    }
    return self;
}

- (NSString *)p_calculate {
    NSDecimalNumber *left = [NSDecimalNumber decimalNumberWithString:self.leftOperandValue];
    NSDecimalNumber *right = [NSDecimalNumber decimalNumberWithString:self.rightOperandValue];
    switch (self.basicOperator) {
        case BasicOperatorAdd:
            self.resultString = [left decimalNumberByAdding:right].stringValue;
            break;
        case BasicOperatorSubstract:
            self.resultString = [left decimalNumberBySubtracting:right].stringValue;
            break;
        case BasicOperatorMultiply:
            self.resultString = [left decimalNumberByMultiplyingBy:right].stringValue;
            break;
        case BasicOperatorDivide:
            self.resultString = [left decimalNumberByDividingBy:right].stringValue;
            break;
        default:
            self.resultString = @"未知结果";
    }
    
    return self.resultString;
}

@end
```

License
----------------

Licensed under [MIT](LICENSE) 'cause why not. 
