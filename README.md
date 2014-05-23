DataDetector
============

What is NSDataDetector?

NSDataDetector is a handy class which can accurately match data types found in complicated expressions. Just pass in your strings, and the API will tell whether it is an address, a phone number, a link or a date. See also this great article that inspired me in wringing this demo app: NSDataDetector on NSHipster

How it works?

Run the project on the Simulator or a real device. Note that the minimum deployment target is iOS 7.0. In the ViewController.m check out the - (IBAction)stringChanged:(UITextField*)sender method. The data detection work is done via the NSDataDetector enumerateMatchesInString: API call. The only precondition is to properly initialize the NSDataDetector instance (see ViewController viewDidLoad method).

Authors and Contributors

Karoly Nyisztor (@Carlos001)

Support or Contact

carlos@nyisztorkaroly.org 
www.leakka.com
