//
//  Utils.swift
//  Currency Converter
//
//  Created by Anubhav-iOS on 25/08/23.
//

import Foundation
import SwiftUI

extension String {
    static let numberFormatter = NumberFormatter()
    var doubleValue: Double {
        String.numberFormatter.decimalSeparator = "."
        if let result = String.numberFormatter.number(from: self){
            return result.doubleValue
        } else {
            String.numberFormatter.decimalSeparator = ","
            if let result = String.numberFormatter.number(from: self){
                return result.doubleValue
            }
        }
        return 0
    }
}

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    } }

struct CustomText: View {
    var text: String
    var textColor: Color
    var fontSize: CGFloat
    var fontWeight: Font.Weight
    
    var body: some View {
        Text(text)
            .font(.system(size: fontSize, weight: fontWeight))
            .foregroundColor(textColor)
    }
    init(_ text: String, textColor: Color = Color(red: 0.12, green: 0.13, blue: 0.38), fontSize: CGFloat, fontWeight: Font.Weight){
        self.text = text
        self.textColor = textColor
        self.fontSize = fontSize
        self.fontWeight = fontWeight
    }
}

struct CapsuleButtonStyle: ButtonStyle {
    var secondColor: Color = Color.white
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: AppConstant.screenWidth * 0.5, height: 60)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.90, green: 0.83, blue: 0.93), secondColor]), startPoint: .top, endPoint: .bottom)
            ).cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.purple, lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.09), radius: 2, x: 0, y: 4)
    }
}

