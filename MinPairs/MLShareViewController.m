//
//  MLShareViewController.m
//  MinPairs
//
//  Created by Oleksiy Martynov on 5/12/14.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLShareViewController.h"
#import <Social/Social.h>
@interface MLShareViewController ()

@end

@implementation MLShareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Share";
    if(_socialMessage==NULL)
    {
        self.socialMessage=@"Improve your english with MinPairs app.";
    }
    if(_socialImage==NULL)
    {
        self.socialImage=[UIImage imageNamed:@"shareImage"];
    }
    
}
-(IBAction)onDoneButton:(id)sender
{
    if(self.isModal)
    {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    else
    {
        int i = (int)self.navigationController.viewControllers.count-2;
        UIViewController *back= [self.navigationController.viewControllers objectAtIndex:i];
        [self.navigationController popToViewController:back animated:YES];
    }
}
- (IBAction)onFbBtnShare:(id)sender
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbView = [SLComposeViewController
                                           composeViewControllerForServiceType:SLServiceTypeFacebook];

        [fbView setInitialText:self.socialMessage];
        [fbView addImage:self.socialImage];
        [self presentViewController:fbView animated:YES completion:nil];
    }
    else
    {
        [self showAlert:@"Facebook"];
    }
}
- (IBAction)onTwitterBtn:(id)sender
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *twitterView = [SLComposeViewController
                                                composeViewControllerForServiceType:SLServiceTypeTwitter];

        [twitterView setInitialText:self.socialMessage];
        [twitterView addImage:self.socialImage];
        [self presentViewController:twitterView animated:YES completion:nil];
    }
    else
    {
        [self showAlert:@"Twitter"];
    }
}
- (IBAction)onWeiboBtnClick:(id)sender
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo])
    {
        SLComposeViewController *weiboView = [SLComposeViewController
                                              composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
 
        [weiboView setInitialText:self.socialMessage];
        [weiboView addImage:self.socialImage];
        [self presentViewController:weiboView animated:YES completion:nil];
    }
    else
    {
        [self showAlert:@"Weibo"];
    }
}
- (IBAction)onEmailBtnClick:(id)sender
{
    if([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController* mailView = [[MFMailComposeViewController alloc] init];
        if (mailView)
        {
            mailView.mailComposeDelegate=self;
            NSString* subject = [NSString stringWithFormat:@"MinPair App"];
            [mailView setSubject:subject];

            [mailView setMessageBody:self.socialMessage isHTML:NO];
            NSData *data = UIImagePNGRepresentation(self.socialImage);
            NSString * attachmentName = [NSString stringWithFormat:@"img.png"];
            [mailView addAttachmentData:data mimeType:@"image/png" fileName:attachmentName];
            [self presentViewController:mailView animated:YES completion:nil];
        }
    }
    else
    {
        [self showAlert:@"Email"];
    }
}
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"Email sent");
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)showAlert:(NSString*)serviceName
{
    NSString* title = [NSString stringWithFormat:@"No %@ account on your device.",serviceName];
    NSString* msg =[NSString stringWithFormat:@"To share you must sign into your %@ account from your device settings page.",serviceName];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
