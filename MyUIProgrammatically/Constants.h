//
//  Constants.h
//  ManualMemoryManagementDemo
//
//  Created by Steven Shatz on 10/27/14.
//  Copyright (c) 2014 Steven Shatz. All rights reserved.
//

#import <Foundation/Foundation.h>

// The next define strips off the date/time stamp and current directory info from the start of each NSLog line
#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

// Set DEBUG to YES to enable debugging; NO to disable it
#define MYDEBUG YES


/*                                 Definitions:
 
 Selector - a Selector is the name of a method. Some selectors are: alloc, init, release, dictionaryWithObjectsAndKeys:, setObject:forKey:, etc. Note that the colon is part of the selector;
    it's how we identify that this method requires parameters.
 
    You can work with selectors directly in Cocoa. They have the type SEL:  SEL aSelector = @selector(doSomething:) or SEL aSelector = NSSelectorFromString(@"doSomething:");
 
 Message - a message is a selector and the arguments you are sending with it. If I say [dictionary setObject:obj forKey:key], then the "message" is the selector setObject:forKey: plus the arguments obj and key. Messages can be encapsulated in an NSInvocation object for later invocation. Messages are sent to a receiver
     (ie, the object that "receives" the message).
 
 Method - a method is a combination of a selector and an implementation (and accompanying metadata). The "implementation" is the actual block of code; it's a function pointer (an IMP - aka Implementation). An actual method can be retrieved internally using a Method struct (retrievable from the runtime).
 
 Method Signature - a method signature represents the data types returned by and accepted by a method. They can be represented at runtime via an NSMethodSignature and (in some cases) a raw char*.
 
 Implementation - the actual executable code of a method. Its type at runtime is an IMP, and it's really just a function pointer. iOS 4.3 includes a new ability to turn a block into an IMP. This is really cool. */


//                                 Example of Root VC Creation:
//
//self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//SimpleTableViewController *controller = [[SimpleTableViewController alloc] init];
//[[self window] setRootViewController:controller];
//self.window.backgroundColor = [UIColor whiteColor];
//[self.window makeKeyAndVisible];

//                                 Example of CGRect access:
//
//CGRect frame = self.view.frame;
//CGFloat x = CGRectGetMinx(frame);
//CGFloat y = CGRectGetMiny(frame);
//CGFloat width = CGRectGetWidth(frame);
//CGFloat height = CGRectGetHeight(frame);
//CGRect frame = CGRectMake(0.0, 0.0, width, height);

//                                 Examples of Literals:
//
//NSArray *names = @[@"Brian", @"Matt", @"Chris"];
//NSDictionary *managers = @{@"iPhone" : @"Brian", @"iPad" : @"Matt", @"Mobile Web" : @"Chris"};
//NSNumber shouldUseLiterals = @YES;
//NSNumber buildingZipCode = @10024;

//                                 Examples of Constants:
//
//static NSString * const NYTAboutViewControllerCompanyName = @"The New York Times Company";
//static const CGFloat NYTImageThumbnailHeight = 50.0;
// Note: For int, use enum instead of const

//                                 Examples of Code Blocks (aka Closures):
// Starts with ^ (caret) and ends with ;
// eg: ^{ return ... }; }
// Define a block as:  int (^simpleBlock)(void); --> simpleBlock is a block that takes no i/p and returns an int
// Assign a block to the above variable as: simpleBlock = ^{ return ...; };
// Invoke the block:  simpleBlock();
// The above as a Block literal:  ^ int (void) { return ...; }
// More complex example:
//    double (^multiplyTwoValues)(double, double) =
//        ^(double firstValue, double secondValue) {
//            return firstValue * secondValue;
//        };
//    double result = multiplyTwoValues(2,4);
// A block captures (and therefore can reference) the current value of a variable used in the same method in which
//  the block was defined. It only captures the value that was in effect at the time the block was created.
//  (see: __block for a way to change the value of a captured variable)
// Warning: Be careful using Self inside a block - easy to create a strong reference cycle. Instead of passing
//  self, create and pass a weak version of self - eg: MyClass * __weak weakSelf = self;

//                                 Examples of Enums:
//
// typedef enum _NamedEnumeration {
//    NEitemOne = 0,
//    NEitemTwo = 1
// } NamedEnumerations;
//
// enum {
//    NEItemA = 0,
//    NEItemB = 1 << 0,     // 1 << 0 = shift a 1-bit 0 positions left
//    NEItemC = 1 << 1      // 1 << 1 = shift a 1-bit 1 position left
// };

//                                 Useful rules:
//
// For BOOL, always test (isAwesome) or (!isAwesome); never test if (isAwesome == NO) [which is redundant]
//   and never test if (isAwesome == YES) [because YES is only = to 1, but BOOL vars can be up to 8 bits!]
//
// When a method returns an Error parm by reference, switch on the method's result; not on the error [since
//   if there is no error, the error parm could contain garbage]
//
// Use properties instead of ivars
// Do not use prefixes when naming Methods or fields in a Structure
//
// IBOutlets: from File's Owner to top level objects should be STRONG; all others should be WEAK (or ASSIGN)
// IBAction methods should call another method in the program rather than do stuff directly
//
// Properties with mutable counterparts (e.g. NSString) should prefer copy instead of strong. Why?
//   Even if you declared a property as NSString somebody might pass in an instance of an NSMutableString
//   and then change it without you noticing that.

//                                  Memory Management:
//
// NARC: You must Release if New (init), Alloc, Retain, or Copy
// Retain: do so immediately when you acquire an object that you do not Own
// Init:    self = [super init]; if (self) { ... }; return self;
// Dealloc: [_thing release]; ...; [super dealloc];
// Getter:  return _thing;
// Setter:  [newThing retain]; [_thing release]; _thing = newThing;

//                                  Properties:
//
// If name is Noun or Verb: @property (assign) NSString *title;
// If name is Adjective:    @property (assign, getter=isEditable) BOOL editable;
// Only access _ivars directly in Init and Dealloc methods
// Declare ivars using: @private or @protected
// If you synthesize ivars: use @synthesize varName = _varName;
// A property defined Publicly (eg: readonly) in a *.h file, can be re-defined Privately (eg: readwrite) in the @interface section of the *.m file

//                                  Introspection:
// isKindOfClass:className
// respondsToSelector:methodName
// conformsToProtocol:protocolName

//                                  Testing Boolean Values:
//
// Do not cast or convert general integral values directly to BOOL. Common mistakes include casting or converting an array's size, a pointer value,
//   or the result of a  bitwise logic operation to a BOOL which, depending on the value of the last byte of the integral result, could still result in a NO value.
//- (BOOL)isBold {
//    return ([self fontTraits] & NSFontBoldTrait) ? YES : NO; }
//- (BOOL)isValid {
//    return [self stringValue] != nil; }
//- (BOOL)isEnabled {
//    return [self isValid] && [self isBold]; }

//                                  NSUserDefaults:
//
// Saving Defaults:
//  NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:employee];  // Convert (archive) all properties of this |employee| object into NSData
//  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];  // Get current standard defaults file (if 1st time for a user, create the default set)
//  [defaults setObject:encodedObject forKey:@"NSUDS-SAVE-DATA"]; // add our NSData object to the default file (replacing any earlier object with the same key)
//  [defaults synchronize];  // Update defaults file on disk (and in cache). The run-time system automatically calls this, so it would eventually be saved anyhow
//
// Reading Defaults:
//  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];  // Fetch our NSData object data from NSUserDefaults
//  NSData *encodedObject = [defaults objectForKey:@"NSUDS-SAVE-DATA"];  // Get the object (an Employee) which corresponds to the specified key
//  Employee *employee = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];  // Convert (unarchive) the previously archived |employee| instance
//      back into its component Employee properties











