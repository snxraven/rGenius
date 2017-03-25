#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UITextView *desc;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [self.ninja name];
    [self.photo setImageWithURL:[NSURL URLWithString:self.ninja.photo]
    placeholderImage:[UIImage imageNamed:@"300-300.jpg"]];
    self.desc.text = self.ninja.desc;
}

@end
