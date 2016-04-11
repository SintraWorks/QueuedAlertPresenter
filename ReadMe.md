QueuedAlertPresenter
====

A QueuedAlertPresenter serializes the presentation of alerts. Use it when your code may present alerts in rapid succession, to ensure all alerts will be presented.

Using QueuedAlertPresenter instead of UIAlertController directly, ensures your user gets to see all the alerts your code creates.

To present an alert create an instance of AlertInfo then add it to the sharedAlertPresenter with addAlert(alertInfo).
AlertInfo holds the information for an individual alert you want to present.

![Sample Alert](https://sintraworks.github.io/QueuedAlertPresenter/images/QueuedAlertPresenter2.png)

QueuedAlertPresenter is written in **Swift**.

Usage
====

```swift
func showAlert() {
    let action = AlertAction(title: "Hit me", style: .Default, enabled: true, isPreferredAction: true, handler: nil)
    let alertInfo = AlertInfo(title: "Success", message: "Hey, this is alert nº \(i)", actions: [action])
    QueuedAlertPresenter.sharedAlertPresenter.addAlert(alertInfo)
}
```

You can call addAlert() from any thread. See scheduleAlertsMultiThreaded() in ViewController.swift for an example.

###Integration

To use QueuedAlertPresenter simply drag the files QueuedAlertPresenter.swift and UIViewController+Helpers.swift into your project.

###Requirements

| Compile Time  | Runtime       |
| :------------ | :------------ |
| Xcode 7       | iOS 8         |
| iOS 9 SDK     |               

## License (MIT License)
Copyright (c) 2016 Antonio Nunes

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
