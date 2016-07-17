//
//  ViewController.swift
//  MailSendTest
//
//  Created by ImaedaToshiharu on 2016/07/14.
//  Copyright © 2016年 ImaedaToshiharu All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTapCreateMail(sender: AnyObject) {
        if MFMailComposeViewController.canSendMail()==false {
            print("Email Send Failed")
            return
        }
        
        let mailViewController:MFMailComposeViewController = MFMailComposeViewController()
        let toRecipients:[String] = ["for.to.mail@gmail.com"]
        let CcRecipients:[String] = []
        let BccRecipients:[String] = []
        
        mailViewController.mailComposeDelegate = self
        mailViewController.setSubject("メールの件名")
        
        // 添付ファイル
        let image:UIImage = UIImage(named: "sample.jpg")!
        let imageData:NSData = UIImageJPEGRepresentation(image, 1.0)!
        mailViewController.addAttachmentData(imageData, mimeType: "image/jpeg", fileName: "image")
        
        mailViewController.setToRecipients(toRecipients)        // Toアドレスの表示
        mailViewController.setCcRecipients(CcRecipients)        // Ccアドレスの表示
        mailViewController.setBccRecipients(BccRecipients)      // Bccアドレスの表示
        mailViewController.setMessageBody("メールの本文", isHTML: false)
        self.presentViewController(mailViewController, animated: true, completion: nil)
    }
    
    @IBAction func onTapGoToSetting(sender: AnyObject) {
        let url:NSURL = NSURL(string: UIApplicationOpenSettingsURLString)!
        UIApplication.sharedApplication().openURL(url)
    }
    
    // MARK: - MFMailComposeViewControllerDelegate
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("キャンセルされました")
            break
        case MFMailComposeResultSaved.rawValue:
            print("下書きとして保存")
            break
        case MFMailComposeResultSent.rawValue:
            print("送信成功")
            break
        case MFMailComposeResultFailed.rawValue:
            print("送信失敗")
            break
        default:
            break
        }
        
        // メーラーを閉じる
        controller.dismissViewControllerAnimated(true, completion: nil)
    }

}

