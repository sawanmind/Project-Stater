//
// LetterAvatarKit.swift
// LetterAvatarKit
//
// Copyright 2017 Victor Peschenkov
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// o this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import UIKit
import Foundation

/// Uses for configuration LetterAvatarBuilder.
@objc(LAKLetterAvatarBuilderConfiguration)
open class LetterAvatarBuilderConfiguration: NSObject {
    /// The size of an avatar image.
    @objc(size)
    open var size: CGSize = CGSize(width: 80, height: 80)
    /// The username.
    @objc(username)
    open var username: String?
    /// The flag that indicates of using single letter instead of two lettters.
    @objc(singleLetter)
    open var singleLetter: Bool = false
    /// The letters font.
    @objc(lettersFont)
    open var lettersFont: UIFont = UIFont.systemFont(ofSize: 16.0)
    /// The letters colors
    @objc(lettersColor)
    open var lettersColor: UIColor = LAKUIColorByRGB(red: 236, green: 240, blue: 241)
    /// The background colors of an image.
    @objc(backgroundColors)
    open var backgroundColors: [UIColor] = UIColor.colors
}

/// Uses for making letter-based avatar images.
@objc(LAKLetterAvatarBuilder)
open class LetterAvatarBuilder: NSObject {
    /// Makes an letter-based avatar image using given configuration.
    ///
    /// - Parameters:
    ///     - configuration: The configuration that uses to draw a
    /// letter-based avatar image.
    ///
    /// - Returns: An instance of UIImage
    @objc(makeAvatarWithConfiguration:)
    open func makeAvatar(withConfiguration configuration: LetterAvatarBuilderConfiguration) -> UIImage? {
        let colors = configuration.backgroundColors
        guard let username = configuration.username else {
            return drawAvatar(
                size: configuration.size,
                letters: "NA",
                lettersFont: configuration.lettersFont,
                lettersColor: configuration.lettersColor,
                backgroundColor: colors[0].cgColor
            )
        }
        
        let usernameInfo = obtainUsernameInfo(
            withUsername: username,
            singleLetter: configuration.singleLetter
        )
        
        var colorIndex = usernameInfo.value
        colorIndex *= 3557 // Prime number
        colorIndex %= colors.count - 1
        return drawAvatar(
            size: configuration.size,
            letters: usernameInfo.letters,
            lettersFont: configuration.lettersFont,
            lettersColor: configuration.lettersColor,
            backgroundColor: colors[colorIndex].cgColor
        )
    }
    
    private func obtainUsernameInfo(withUsername username: String, singleLetter: Bool) -> (letters: String, value: Int) {
        var letters = String()
        var lettersAssciValue = 0
        
        /// Obtain the array of words using given username
        let components = username.components(separatedBy: " ")
        
        /// If given two words or more
        if components.count > 1 {
            if let firstComponent = components.first, let lastComponent = components.last {
                /// Process the firs name letter
                if let letter = firstComponent.first {
                    letters.append(letter)
                    lettersAssciValue += letter.asciiValue
                }
                
                if !singleLetter {
                    /// Process the last name letter
                    if let letter = lastComponent.first {
                        letters.append(letter)
                        lettersAssciValue += letter.asciiValue
                    }
                }
            }
        } else {
            /// If given just one word
            if let component = components.first {
                /// Process the firs name letter
                if let letter = component.first {
                    letters.append(letter)
                    lettersAssciValue += letter.asciiValue
                    
                    if !singleLetter {
                        /// Process the second name letter
                        let startIndex = component.index(after: component.startIndex)
                        let endIndex = component.index(component.startIndex, offsetBy: 2)
                        let substring = component[startIndex..<endIndex].capitalized
                        if let letter = substring.first {
                            letters.append(letter)
                            lettersAssciValue += letter.asciiValue
                        }
                    }
                }
            }
        }
        
        return (letters: letters, value: lettersAssciValue)
    }
    
    private func drawAvatar(size: CGSize,
                            letters: String,
                            lettersFont: UIFont,
                            lettersColor: UIColor,
                            backgroundColor: CGColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContextWithOptions(size, true, UIScreen.main.scale)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(backgroundColor)
            context.fill(rect)
            
            let style = NSParagraphStyle.default.mutableCopy()
            #if swift(>=4.0)
                let attributes = [
                    NSAttributedStringKey.paragraphStyle: style,
                    NSAttributedStringKey.font: lettersFont.withSize(min(size.height, size.width) / 2.0),
                    NSAttributedStringKey.foregroundColor: lettersColor
                ]
                
                let lettersSize = letters.size(withAttributes: attributes)
            #else
                let attributes = [
                NSParagraphStyleAttributeName: style,
                NSFontAttributeName: lettersFont.withSize(min(size.height, size.width) / 2.0),
                NSForegroundColorAttributeName: lettersColor
                ]
                
                let lettersSize = letters.size(attributes: attributes)
            #endif
            
            let lettersRect = CGRect(
                x: (rect.size.width - lettersSize.width) / 2.0,
                y: (rect.size.height - lettersSize.height) / 2.0,
                width: lettersSize.width,
                height: lettersSize.height
            )
            letters.draw(in: lettersRect, withAttributes: attributes)
            
            let avatarImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return avatarImage
        }
        return nil
    }
    
}
