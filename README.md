# MeowSheet

[![CI Status](https://img.shields.io/travis/alan5899f/MeowSheet.svg?style=flat)](https://travis-ci.org/alan5899f/MeowSheet)
[![Version](https://img.shields.io/cocoapods/v/MeowSheet.svg?style=flat)](https://cocoapods.org/pods/MeowSheet)
[![License](https://img.shields.io/cocoapods/l/MeowSheet.svg?style=flat)](https://cocoapods.org/pods/MeowSheet)
[![Platform](https://img.shields.io/cocoapods/p/MeowSheet.svg?style=flat)](https://cocoapods.org/pods/MeowSheet)

## Requirements

● iOS 13+ 
● Xcode 12+
● Swift 5+

## Installation

MeowSheet is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MeowSheet', :git => "https://github.com/alan5899f/MeowSheet.git", :tag => '1.0.0'
```

## Example 

Step1:
-- You need inherit (PresentationDelegate) and set presentation hight px.

```ruby 
    extension ViewController: PresentationDelegate {
        func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
            let presentationController = PresentationController(presentedViewController: presented, presenting: presenting)
            presentationController.presentationType = .fixed(300)
            return presentationController
        }
    }
```

Step2: 
-- You should call presentMeowSheet for present viewController.

```ruby 
    let vc = ViewController2()
    presentMeowSheet(controller: vc)
```

## Author

alan5899f, alan5899f@gmail.com

## License

MeowSheet is available under the MIT license. See the LICENSE file for more info.
