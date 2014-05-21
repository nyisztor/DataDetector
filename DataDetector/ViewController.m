//
//  ViewController.m
//  DataDetector
//
//  Created by Nyisztor Karoly on 2014.05.20..
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *stringTypeLabel;

- (IBAction)stringChanged:(UITextField *)sender;

@end

@implementation ViewController
{
    NSDataDetector* m_Detector; ///< data detector instance
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Init our NSDataDetector
    // We configure it to recognize addresses, web links, phone numbers and dates - we cover the full range
    NSError* error = nil;
    m_Detector = [[NSDataDetector alloc] initWithTypes:(NSTextCheckingTypeAddress | NSTextCheckingTypeLink | NSTextCheckingTypePhoneNumber | NSTextCheckingTypeDate ) error:&error];
    if( !m_Detector )
    {
        NSLog( @"Could not initialize NSDataDetector. Description: %@", error.localizedDescription );
    }
}

/**
 *  Gets called when user enters a string in the text field
 *
 *  @param sender the UITextField, see Main.storyboard
 */
- (IBAction)stringChanged:(UITextField*)sender
{
    // The option NSMatchingReportCompletion ensures that the block gets called for each match operation.
    // If a data type is identified, the detection process is stopped (we set the stop condition to true)
    [m_Detector enumerateMatchesInString:sender.text
                                 options:NSMatchingReportCompletion/*kNilOptions*/
                                   range:NSMakeRange(0, [sender.text length])
                              usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop)
     {
#ifdef DEBUG
         NSLog( @"Result %@", result );
#endif

         NSString* string = sender.text;
         
         if( result.range.length < string.length )
         {
             string = [string substringWithRange:result.range];
         }

         NSString* description = @"Failed to detect";
         
         switch (result.resultType)
         {
             case NSTextCheckingTypePhoneNumber:
             {
                 description = [NSString stringWithFormat:@"%@ is a phone number", string];
                 _stringTypeLabel.text = description;
                 *stop = YES;
             } break;
                 
             case NSTextCheckingTypeAddress:
             {
                 description = [NSString stringWithFormat:@"%@ is an address", string];
                 _stringTypeLabel.text = description;
                 *stop = YES;
             } break;
             
             case NSTextCheckingTypeLink:
             {
                 description = [NSString stringWithFormat:@"%@ is a link", string];
                 _stringTypeLabel.text = description;
                 *stop = YES;
             } break;
             
             case NSTextCheckingTypeDate:
             {
                 description = [NSString stringWithFormat:@"%@ is a date", string];
                 _stringTypeLabel.text = description;
                 *stop = YES;
             } break;
                 
             default:
             {
                 _stringTypeLabel.text = description;
             }
         }
         
#ifdef DEBUG
         NSLog( @"%@", description );
#endif
     }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
