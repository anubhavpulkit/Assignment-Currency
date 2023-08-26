//
//  ConversionHistory.swift
//  Currency Converter
//
//  Created by Anubhav-iOS on 25/08/23.
//

import SwiftUI

struct ConversionHistory: View {
    @StateObject var viewModel  = Network()
    
    var body: some View {
        NavigationView{
            VStack{
                List {
                    ForEach(0..<UserDefaultManager.standard.getBaseCodeHistory().count) { each in
                        VStack(spacing: 10){
                            CustomText("\(UserDefaultManager.standard.getBaseCodeHistory()[each]) → \(UserDefaultManager.standard.getTargetCodeHistory()[each])", fontSize: 20, fontWeight: .semibold)
                            CustomText("Conversion Rate: \(UserDefaultManager.standard.getHistroyConversionRatet()[each])", textColor: .white, fontSize: 16, fontWeight: .semibold)
                            CustomText("Result: \(UserDefaultManager.standard.getHistoryConvertedAmount()[each]) \(UserDefaultManager.standard.getTargetCodeHistory()[each])", fontSize: 20, fontWeight: .semibold)
                            HStack{
                                CustomText("Date: \(UserDefaultManager.standard.getDateHistory()[each])", textColor: Color(red: 0.5, green: 0.5, blue: 0.5), fontSize: 16, fontWeight: .regular)
                                Spacer()
                                CustomText("Time: \(UserDefaultManager.standard.getTimeHistory()[each])", textColor: Color(red: 0.5, green: 0.5, blue: 0.5), fontSize: 16, fontWeight: .regular)
                            }
                        }.padding()
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color(red: 0.90, green: 0.83, blue: 0.93), .white]), startPoint: .top, endPoint: .bottom)
                            )
                            .cornerRadius(8)
                            .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 4)
                    }
                }
                CustomText("Currency Converter for : Vance (YC W22)", fontSize: 12, fontWeight: .semibold)
            }
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        CustomText("Conversion History", textColor: Color(.black), fontSize: 24, fontWeight: .semibold)
                    }
                }
            }
            .preferredColorScheme(.light)
        }
    }
}

struct ConversionHistory_Previews: PreviewProvider {
    static var previews: some View {
        ConversionHistory()
    }
}
