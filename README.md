![SDRecordButton](https://dl.dropboxusercontent.com/s/9954jio68aqu5t6/sdrecordbutton2.png?dl=0)

[![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/sebyddd/SDRecordButton?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)     


# SDRecordButton
An animated UIButton subclass, meant to be used as a recording button. Clean, highly customizable, lightweight.

## Add to your project
 
There are 2 ways you can add SDRecordButton to your project:
 
### Manual installation
 
 Simply import the 'SDRecordButton' into your project then import the following in the class you want to use it: 
 ```objective-c
       #import "SDRecordButton.h";
 ```      
### Installation with CocoaPods

CocoaPods is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like SDRecordButton in your projects. See the "[Getting Started](http://guides.cocoapods.org/syntax/podfile.html)" guide for more information.

### Podfile
```ruby
        platform :ios, '6.0'
        pod "SDRecordButton", "~> "1.0"
```

## Demo
![SDRecordButton](https://dl.dropboxusercontent.com/s/crzbg43r26euip9/demo.gif?dl=0)

## Detecting recording state

SDRecordButton makes use of UIButton's target property to detect state changes. In your view controller add the following targets to your button instance:
```objective-c
    [recordButton addTarget:self action:@selector(recording) forControlEvents:UIControlEventTouchDown];
    [recordButton addTarget:self action:@selector(pausedRecording) forControlEvents:UIControlEventTouchUpInside];
    [recordButton addTarget:self action:@selector(pausedRecording) forControlEvents:UIControlEventTouchUpOutside];

```
For examples, check out the demo project. 

## Available properties & methods
```objective-c
    buttonColor // UIColor - Main color of the button
    progressColor // UIColor - Color of the progress layer
   
```
```
	// Update loading progress of the button. From 0.0 to 1.0.
 	- (void)setProgress:(CGFloat)progress; 
```

## License
Usage is provided under the [MIT License](http://http//opensource.org/licenses/mit-license.php). See LICENSE for the full details.