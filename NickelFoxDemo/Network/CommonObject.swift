//
//  CommonObject.swift
//  NickelFoxDemo
//
//  Created by Ruchin Somal on 07/12/18.
//  Copyright © 2018 Ruchin Somal. All rights reserved.
//

import Foundation

// To add shadow on any UIView element
func addShadowOnViews(_ view : UIView, color: UIColor, isRounded:Bool, cornerRadius:CGFloat) {
    view.layer.shadowColor = color.cgColor
    view.layer.shadowOffset = CGSize.zero
    view.layer.shadowRadius = 2
    view.layer.shadowOpacity = 0.9
    if isRounded {
    view.layer.cornerRadius = cornerRadius
    }
}

// To convert shape into rounded view
func roundedView(anyView: AnyObject,width: CGFloat) {
    anyView.layer.cornerRadius = width
    anyView.layer.masksToBounds = true
}

// To add border on view
func addBorderToView(anyView: AnyObject,width: CGFloat,color: UIColor) {
    anyView.layer.borderWidth = width
    anyView.layer.borderColor = color.cgColor
    anyView.layer.masksToBounds = true
}

// To show alert message
func showAlertView(title: String, message: String, ref:UIViewController) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
        //ref.dismiss(animated: true, completion: nil)
    }
    alertController.addAction(okAction)
    ref.present(alertController, animated: true, completion: nil)
}

// To convert hex code to UIColor
func hexStringToUIColor(hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

// To check email is valid or not
func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}

// To check email is valid or not
func isValidPincode(testStr:String) -> Bool {
    let pincodeRegEx = "^[1-9][0-9]{5}$"
    let pincodeTest = NSPredicate(format:"SELF MATCHES %@", pincodeRegEx)
    return pincodeTest.evaluate(with: testStr)
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
extension Float {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}

extension String {
    func removeSpaces() -> String {
        let str = self.replacingOccurrences(of: " ", with: "")
        return str
    }
    
    func isEmptyString() -> Bool {
        let tempStr = self.removeSpaces()
        if tempStr == "" {
            return true
        } else {
            return false
        }
    }
        var youtubeID: String? {
            let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
            
            let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let range = NSRange(location: 0, length: count)
            
            guard let result = regex?.firstMatch(in: self, options: [], range: range) else {
                return nil
            }
            
            return (self as NSString).substring(with: result.range)
        }
}
public extension UIDevice {
    
    var modelName: String {
        #if targetEnvironment(simulator)
        let DEVICE_IS_SIMULATOR = true
        #else
        let DEVICE_IS_SIMULATOR = false
        #endif
        
        var machineString : String = ""
        
        if DEVICE_IS_SIMULATOR {
            if let dir = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                machineString = dir
            }
        } else {
            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            machineString = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8, value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
        }
        switch machineString {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        default:                                        return machineString
        }
    }
}

extension CGFloat {
    static var random: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random, green: .random, blue: .random, alpha: 1.0)
    }
}

extension UIImage {
    func resize(withWidth newWidth: CGFloat, newHeight: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

func imageOrientation(_ src:UIImage)->UIImage {
    if src.imageOrientation == UIImage.Orientation.up {
        return src
    }
    var transform: CGAffineTransform = CGAffineTransform.identity
    switch src.imageOrientation {
    case UIImage.Orientation.down, UIImage.Orientation.downMirrored:
        transform = transform.translatedBy(x: src.size.width, y: src.size.height)
        transform = transform.rotated(by: CGFloat(Double.pi))
        break
    case UIImage.Orientation.left, UIImage.Orientation.leftMirrored:
        transform = transform.translatedBy(x: src.size.width, y: 0)
        transform = transform.rotated(by: CGFloat(Double.pi/2))
        break
    case UIImage.Orientation.right, UIImage.Orientation.rightMirrored:
        transform = transform.translatedBy(x: 0, y: src.size.height)
        transform = transform.rotated(by: CGFloat(-Double.pi/2))
        break
    case UIImage.Orientation.up, UIImage.Orientation.upMirrored:
        break
    }
    
    switch src.imageOrientation {
    case UIImage.Orientation.upMirrored, UIImage.Orientation.downMirrored:
        transform.translatedBy(x: src.size.width, y: 0)
        transform.scaledBy(x: -1, y: 1)
        break
    case UIImage.Orientation.leftMirrored, UIImage.Orientation.rightMirrored:
        transform.translatedBy(x: src.size.height, y: 0)
        transform.scaledBy(x: -1, y: 1)
    case UIImage.Orientation.up, UIImage.Orientation.down, UIImage.Orientation.left, UIImage.Orientation.right:
        break
    }
    
    let ctx:CGContext = CGContext(data: nil, width: Int(src.size.width), height: Int(src.size.height), bitsPerComponent: (src.cgImage)!.bitsPerComponent, bytesPerRow: 0, space: (src.cgImage)!.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
    
    ctx.concatenate(transform)
    
    switch src.imageOrientation {
    case UIImage.Orientation.left, UIImage.Orientation.leftMirrored, UIImage.Orientation.right, UIImage.Orientation.rightMirrored:
        ctx.draw(src.cgImage!, in: CGRect(x: 0, y: 0, width: src.size.height, height: src.size.width))
        break
    default:
        ctx.draw(src.cgImage!, in: CGRect(x: 0, y: 0, width: src.size.width, height: src.size.height))
        break
    }
    
    let cgimg:CGImage = ctx.makeImage()!
    let img:UIImage = UIImage(cgImage: cgimg)
    
    return img
}






