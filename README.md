# MeowSheet

[![CI Status](https://img.shields.io/travis/alan5899f/MeowSheet.svg?style=flat)](https://travis-ci.org/alan5899f/MeowSheet)
[![Version](https://img.shields.io/cocoapods/v/MeowSheet.svg?style=flat)](https://cocoapods.org/pods/MeowSheet)
[![License](https://img.shields.io/cocoapods/l/MeowSheet.svg?style=flat)](https://cocoapods.org/pods/MeowSheet)
[![Platform](https://img.shields.io/cocoapods/p/MeowSheet.svg?style=flat)](https://cocoapods.org/pods/MeowSheet)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

MeowSheet is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MeowSheet'
```

## Author

alan5899f, alan5899f@gmail.com

## License

MeowSheet is available under the MIT license. See the LICENSE file for more info.

## Example 

Step1:
-- You need inherit (PresentationDelegate) and set presentation hight px.

extension ViewController: PresentationDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = PresentationController(presentedViewController: presented, presenting: presenting)
        presentationController.presentationType = .fixed(300)
        return presentationController
    }
}

Step2: 
-- You should call presentMeowSheet for present viewController.

let vc = ViewController2()
presentMeowSheet(controller: vc)
