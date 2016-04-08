         //
//  ViewController.swift
//  QueuedAlertPresenter
//
//  Created by Antonio Nunes on 04/04/16.
//  Copyright © 2016 SintraWorks. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished
//  to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func scheduleAlerts(sender: UIButton) {
        let presenter = QueuedAlertPresenter.sharedAlertPresenter
        var action: AlertAction
        var alertInfo: AlertInfo
        
        for i in 1...4 {
            action = AlertAction(title: "Hit me", style: .Default, enabled: true, isPreferredAction: true, handler: nil)
            alertInfo = AlertInfo(title: "Success", message: "Hey, this is alert nº \(i)", actions: [action])
            presenter.addAlert(alertInfo)
        }
        
        action = AlertAction(title: "Done", style: .Default, enabled: true, isPreferredAction: true, handler: nil)
        alertInfo = AlertInfo(title: "Wonderful", message: "All alerts were shown in succession.", actions: [action])
        presenter.addAlert(alertInfo)
    }
    
    
    @IBAction func scheduleAlertsOnMainThread(sender: UIButton) {
        self.scheduleAlerts(sender)
    }

    
    @IBAction func scheduleAlertsOffMainThread(sender: UIButton) {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
            self.scheduleAlerts(sender)
        }
    }

    
    @IBAction func scheduleAlertsMultiThreaded(sender: UIButton) {
        let presenter = QueuedAlertPresenter.sharedAlertPresenter
        let op = NSBlockOperation()
        
        for i in 1...6 {
            op.addExecutionBlock({
                let action = AlertAction(title: "Hit me", style: .Default, enabled: true, isPreferredAction: true, handler: nil)
                let alertInfo = AlertInfo(title: "Success", message: "Hey, this is alert nº \(i)", actions: [action])
                presenter.addAlert(alertInfo)
            })
        }
        
        let finalOp = NSBlockOperation(block: {
            let action = AlertAction(title: "Done", style: .Default, enabled: true, isPreferredAction: true, handler: nil)
            let alertInfo = AlertInfo(title: "Wonderful", message: "All alerts were shown in succession.", actions: [action])
            presenter.addAlert(alertInfo)
        })
        
        finalOp.addDependency(op)
        
        let queue = NSOperationQueue()
        queue.addOperation(op)
        queue.addOperation(finalOp)
    }
}

