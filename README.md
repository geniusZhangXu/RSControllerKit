# RSControllerKit

[![CI Status](https://img.shields.io/travis/geniusZhangXu/RSControllerKit.svg?style=flat)](https://travis-ci.org/geniusZhangXu/RSControllerKit)
[![Version](https://img.shields.io/cocoapods/v/RSControllerKit.svg?style=flat)](https://cocoapods.org/pods/RSControllerKit)
[![License](https://img.shields.io/cocoapods/l/RSControllerKit.svg?style=flat)](https://cocoapods.org/pods/RSControllerKit)
[![Platform](https://img.shields.io/cocoapods/p/RSControllerKit.svg?style=flat)](https://cocoapods.org/pods/RSControllerKit)

## Example

```
/// RSView
let rsView = RSView()
    
/// RSButton
let rsButton = RSButton.init("image")

/// RSLabel
let rsLabel = RSLabel.init(frame: CGRect.zero)

/// RSImageView
let rsImageView = RSImageView.init(rsImageName: "image")

/// RSScrollStackView
let rsScrollStackView = RSScrollStackView()
rsScrollStackView.rsStackView.addArrangedSubview(rsImageView)

/// RSViewController
let rsViewController = RSViewController()
rsViewController.rsReturnBtnImage = "image"

/// RSWebController
let rsWebController = RSWebController("load-url")

/// RSNavigationController
let rsNavigationController = RSNavigationController(rootViewController: rsViewController)
```

## Requirements

## Installation

RSControllerKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RSControllerKit'
```

## Author

Mr.RisingSun, 13535471825@163.com

## License

RSControllerKit is available under the MIT license. See the LICENSE file for more info.
