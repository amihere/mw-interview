//
//  Extensions.swift
//  mestLabsIdea
//
//  Created by Ayeba Amihere on 01/03/2019.
//  Copyright © 2019 Ayeba Amihere. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    // Utility to change hex to color
    // https://www.iosapptemplates.com/blog/swift-programming/convert-hex-colors-to-uicolor-swift-4
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}

extension NumberFormatter{
    func createPercentageString(number:Double) -> String {
        self.numberStyle = .decimal
        self.maximumFractionDigits = 1
        
        let number = NSNumber(floatLiteral: number)
        return "\(self.string(from: number) ?? "")%";
    }
}

extension Double{
    // Return a more readable 1M or 1K for large numbers
    // https://stackoverflow.com/questions/36376897/swift-2-0-format-1000s-into-a-friendly-ks/36377091
    static func formatPoints(num: Double) ->String{
        if num >= 10000, num <= 999999 {
            return String(format: "%.1fK", locale: Locale.current,num/1000).replacingOccurrences(of: ".0", with: "")
        }
        
        if num > 999999 {
            return String(format: "%.1fM", locale: Locale.current,num/1000000).replacingOccurrences(of: ".0", with: "")
        }
        
        return String(format: "%.0f", locale: Locale.current,num)
        
    }

    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension UIViewController{
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


extension UIStackView {
    // https://stackoverflow.com/questions/44098314/ios-add-vertical-line-programatically-inside-a-stack-view
    func addSeparator(color : UIColor) {
        if self.arrangedSubviews.count > 0 {
            let separator = createSeparator(color: color)
            addArrangedSubview(separator)
            separator.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
        }
    }
    
    private func createSeparator(color : UIColor) -> UIView {
        let separator = UIView()
        separator.widthAnchor.constraint(equalToConstant: 1).isActive = true
        separator.backgroundColor = color
        return separator
    }
}

extension UIView {
    /// Helper method to init and setup the view from the Nib.
    func xibSetup() {
        let view = loadFromNib()
        addSubview(view)
        stretch(view: view)
    }

    /// Method to init the view from a Nib.
    /// Will return Optional UIView initialized from the Nib of the same class name.
    func loadFromNib<T: UIView>() -> T {
        let selfType = type(of: self)
        let bundle = Bundle(for: selfType)
        let nibName = String(describing: selfType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
            fatalError("Error loading nib with name \(nibName)")
        }
        
        return view
    }
    
    /// Stretches the input view to the UIView frame using Auto-layout
    ///
    /// - Parameter view: The view to stretch.
    func stretch(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leftAnchor.constraint(equalTo: leftAnchor),
            view.rightAnchor.constraint(equalTo: rightAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}
