//
//  NewCustomVC.swift
//  NickelFoxDemo
//
//  Created by Ruchin Somal on 03/01/19.
//  Copyright © 2019 Ruchin Somal. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class NewCustomVC: UIViewController {
    @IBOutlet weak var backView: UIView!
    let playerController = AVPlayerViewController()
    var appDelegate: AppDelegate?
    var fullScreen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        let urlStr = "https://video.xx.fbcdn.net/v/t42.9040-2/50019562_2337643219805761_5016032566298279936_n.mp4?_nc_cat=1&efg=eyJybHIiOjQ4NiwicmxhIjo1MTIsInZlbmNvZGVfdGFnIjoic3ZlX3NkIn0%3D&rl=486&vabr=270&_nc_ht=video-yyz1-1.xx&oh=db56203af50d2c22a65153ce58ace53d&oe=5C30D2EC"
        playVideo(urlStr: urlStr)
    }
    
    private func playVideo(urlStr: String) {
        guard let url = URL(string: urlStr) else {
            debugPrint("video.mp4 not found")
            return
        }
        let player = AVPlayer(url: url)
        playerController.player = player
        playerController.delegate = self
        playerController.view.frame = backView.bounds // your frame here
        self.addChild(playerController)
        self.backView.insertSubview(playerController.view, at: 0)
        player.play()
        NotificationCenter.default.addObserver(self, selector: #selector(self.finishVideo), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
//        playerController.addObserver(self, forKeyPath: "videoBounds", options: NSKeyValueObservingOptions.new, context: nil)
//        self.playerController.goFullScreen()
    }
    
    @objc func finishVideo() {
        print("Video Finished")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if(UIDevice.current.orientation.isLandscape) {
            if !self.playerController.entersFullScreenWhenPlaybackBegins {
//            self.playerController.goFullScreen()
            }
        } else {
            self.playerController.videoGravity = .resizeAspect
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "videoBounds" {
            if let rect = change?[.newKey] as? NSValue {
                if let newrect = rect.cgRectValue as CGRect? {
                    if newrect.size.height <= 200 {
                        print("normal screen")
                        if fullScreen {
                            fullScreen = false
                        appDelegate?.shouldRotate = true
                        }
                    } else {
                        fullScreen = true
                        print("full screen")
                    }
                }
            }
        }
    }

}

extension NewCustomVC: AVPlayerViewControllerDelegate {
    func playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart(_ playerViewController: AVPlayerViewController) -> Bool {
        print("playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart")
        return true
    }
    func playerViewControllerDidStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
        print("playerViewControllerDidStopPictureInPicture")
    }
    func playerViewControllerDidStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
        print("playerViewControllerDidStartPictureInPicture")
    }
    func playerViewControllerWillStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
        print("playerViewControllerWillStopPictureInPicture")
    }
    func playerViewControllerWillStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
        print("playerViewControllerWillStartPictureInPicture")
    }
    func playerViewController(_ playerViewController: AVPlayerViewController, failedToStartPictureInPictureWithError error: Error) {
        print("failedToStartPictureInPictureWithError")
    }
    func playerViewController(_ playerViewController: AVPlayerViewController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        print("restoreUserInterfaceForPictureInPictureStopWithCompletionHandler")
    }
}
extension AVPlayerViewController {
    
    func goFullScreen() {
        let selectorName: String = {
            if #available(iOS 11.3, *) {
                return "_transitionToFullScreenAnimated:interactive:completionHandler:"
            } else if #available(iOS 11, *) {
                return "_transitionToFullScreenAnimated:completionHandler:"
            } else {
                return "_transitionToFullScreenViewControllerAnimated:completionHandler:"
            }
        }()
        let selectorToForceFullScreenMode = NSSelectorFromString(selectorName)
        if self.responds(to: selectorToForceFullScreenMode) {
            self.perform(selectorToForceFullScreenMode, with: true, with: nil)
        }
    }
}
