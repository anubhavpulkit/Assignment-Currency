//
//  ContentView.swift
//  Currency Converter
//
//  Created by Anubhav-iOS on 24/08/23.
//

import SwiftUI

struct ContentView: View {
    @State private var baseCode: String = "USD"
    @State private var targetCode: String = "INR"
    @State private var amount: String = ""
    @State private var baseImage: String = "$"
    @State private var targetImage: String = "₹"
    @State private var convertedAmount: Float = 0.0
    
    @State private var exchangeRateVisible: Bool = false
    @State private var presentAlert: Bool = false
    @State private var showConversionHistory: Bool = false
    
    @FocusState private var dismissKeyboard: Bool
    @State private var interChangeButtonToggle: Bool = false
    @StateObject var viewModel  = Network()
    
    var body: some View {
        VStack(spacing: 30) {
            HStack{
                Spacer()
                Button(action:{
                    showConversionHistory.toggle()
                }){
                    CustomText("History", fontSize: 18, fontWeight: .bold)
                }.sheet(isPresented: $showConversionHistory) {
                    ConversionHistory()
                        .presentationDetents([.medium, .large])
                }
            }.padding(.trailing, 20)
            
            // Headings
            VStack(spacing: 10){
                CustomText("Currency Converter", fontSize: 24, fontWeight: .bold)
                
                CustomText("Check live rates, history of exchange to put you allways updated.", textColor: .white, fontSize: 16, fontWeight: .regular)
                    .frame(width: AppConstant.screenWidth * 0.8, alignment: .top)
            }.multilineTextAlignment(.center)
            
            VStack{
                VStack(alignment: .leading){
                    // base code section
                    VStack{
                        HStack{
                            CustomText("Amount", textColor: Color(red: 0.6, green: 0.6, blue: 0.6), fontSize: 15, fontWeight: .regular)
                            Spacer()
                        }
                        HStack(spacing: 20){
                            
                            Section{
                                CustomText("\(baseImage)", textColor: .white, fontSize: 20, fontWeight: .semibold)
                                    .cornerRadius(22.5)
                                    .foregroundColor(.blue)
                            }.frame(width: 45, height: 45)
                            .background(.gray)
                            .cornerRadius(22.5)
                            Menu {
                                ForEach(0..<AppConstant.currencies.count){index in
                                    Button(action: {
                                        baseCode = AppConstant.currencies[index]
                                        withAnimation{
                                            baseImage = getSymbol(forCurrencyCode: baseCode) ?? "$"
                                            amount = ""
                                            convertedAmount = 0.0
                                            exchangeRateVisible = false
                                        }
                                    }) {
                                        Text(AppConstant.currencies[index])
                                    }
                                }
                            } label: {
                                CustomText(baseCode, fontSize: 20, fontWeight: .semibold)
                                Image(systemName: "chevron.down").foregroundColor(Color(red: 0.15, green: 0.15, blue: 0.55))
                            }
                            Spacer()
                            Section{
                                TextField("Enter Amount", text: $amount)
                                    .onChange(of: amount){ _ in
                                        amount = String(amount.prefix(AppConstant.limit))
                                        if amount.count == 0 {
                                            convertedAmount = 0
                                        }
                                    }.font(.system(size: 16, weight: Font.Weight.semibold))
                                    .foregroundColor(Color.white)
                                    .keyboardType(.decimalPad)
                                    .focused($dismissKeyboard)
                                    .padding(.leading, 10)
                            }
                            .frame(width: 140, height: 46)
                            .background(Color.gray)
                            .cornerRadius(9)
                            .alert("You can only enter amount value upto 5 digit", isPresented: $presentAlert) {
                                Button("OK", role: .cancel) { presentAlert.toggle()}
                                    }
                        }
                    }.padding(EdgeInsets(top: 30, leading: 20, bottom: 0, trailing: 20))
                    
                    // seprator between base and target
                    Spacer()
                    ZStack{
                        Divider().padding().opacity(0.3)
                        
                        Image(systemName: "arrow.up.arrow.down.circle.fill")
                            .resizable()
                            .frame(width: 45, height: 45)
                            .foregroundColor(Color.black)
                            .onTapGesture {
                                withAnimation{
                                    let tempCode: String = baseCode
                                    baseCode = targetCode
                                    targetCode = tempCode
                                    
                                    let tempImg: String = baseImage
                                    baseImage = targetImage
                                    targetImage = tempImg
                                    
                                    amount = ""
                                    convertedAmount = 0.0
                                    exchangeRateVisible = false
                                    interChangeButtonToggle.toggle()
                                }
                            }
                    }
                    Spacer()
                    
                    // target code section
                    VStack{
                        HStack{
                            CustomText("Converted Amount", textColor: Color(red: 0.6, green: 0.6, blue: 0.6), fontSize: 15, fontWeight: .regular)
                            Spacer()
                        }
                        HStack(spacing: 20){
                            Section{
                                CustomText("\(targetImage)", textColor: .white, fontSize: 20, fontWeight: .semibold)
                                    .cornerRadius(22.5)
                                    .foregroundColor(.blue)
                            }.frame(width: 45, height: 45)
                            .background(.gray)
                            .cornerRadius(22.5)
                            
                            Menu {
                                ForEach(0..<AppConstant.currencies.count){index in
                                    Button(action: {
                                        targetCode = AppConstant.currencies[index]
                                        withAnimation{
                                            targetImage = getSymbol(forCurrencyCode: targetCode) ?? "₹"
                                            amount = ""
                                            convertedAmount = 0.0
                                            exchangeRateVisible = false
                                        }
                                    }) {
                                        Text(AppConstant.currencies[index])
                                    }
                                }
                            } label: {
                                CustomText(targetCode, textColor: Color(red: 0.15, green: 0.15, blue: 0.55), fontSize: 20, fontWeight: .semibold)
                                Image(systemName: "chevron.down").foregroundColor(Color(red: 0.15, green: 0.15, blue: 0.55))
                            }
                            
                            Spacer()
                            Section{
                                if exchangeRateVisible {
                                    CustomText("\(targetImage) \(String(format: "%.1f", viewModel.conversion?.conversion_result ?? 0.0))", textColor: .white, fontSize: 19, fontWeight: .semibold)
                                }else{
                                    CustomText("\(targetImage) \(String(format: "%.1f", 0.0))", textColor: .white, fontSize: 19, fontWeight: .semibold)
                                }
                            }
                            .frame(width: 140, height: 46)
                            .background(Color.gray)
                            .cornerRadius(9)
                        }
                    }.padding(EdgeInsets(top: 0, leading: 20, bottom: 30, trailing: 20))
                    
                }.frame(width: AppConstant.screenWidth * 0.9, height: AppConstant.screenWidth * 0.8, alignment: .center)
                    .background(.white)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 4)
            }
            
            // Exchange Rate
            if exchangeRateVisible {
                VStack(spacing: 13){
                    HStack{
                        CustomText("Indicative Exchange Rate",textColor: Color(red: 0.63, green: 0.63, blue: 0.63) ,fontSize: 16, fontWeight: .regular)
                        Spacer()
                    }
                    HStack{
                        CustomText("1 \(baseCode) = \(viewModel.conversion?.conversion_rate ?? 0) \(targetCode)", fontSize: 18, fontWeight: .medium)
                        Spacer()
                    }
                }.padding(.leading, 24).multilineTextAlignment(.leading)
            }
            
                Button(action: {
                    viewModel.fetchConvertedData(baseCode: baseCode, targetCode: targetCode, amount: amount)
                                        
                    convertedAmount = viewModel.conversion?.conversion_result ?? 0.0
                    exchangeRateVisible = true
                    
                    self.viewModel.timing.append(getTime())
                    UserDefaultManager.standard.setTimeHistory(keywordsArray: viewModel.timing)
                    
                    self.viewModel.date.append(getDate())
                    UserDefaultManager.standard.setDateHistory(keywordsArray: viewModel.date)
                    
                }){
                    CustomText("Convert", fontSize: 18, fontWeight: .semibold)
                }
                .disabled(!(amount.count>0))
                .opacity(!(amount.count>0) ? 0.3 : 1)
                .buttonStyle(CustomButtonStyle())
                
            Spacer()
            CustomText("Currency Converter for : Vance (YC W22)", fontSize: 12, fontWeight: .semibold)
        }
        .padding()
        .onTapGesture {
            dismissKeyboard = false
        }
        .toolbar{
            ToolbarItemGroup(placement: .keyboard){
                Spacer()
                Button("Done"){
                    UIApplication.shared.dismissKeyboard()
                }
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.90, green: 0.83, blue: 0.93), .white]), startPoint: .top, endPoint: .bottom)
        )
        .onChange(of: interChangeButtonToggle){ _ in
            let newAmount = Float(amount)
            if newAmount ?? 0 > 0 {
                viewModel.fetchConvertedData(baseCode: baseCode, targetCode: targetCode, amount: amount)
            }
        }
        .onChange(of: amount){_  in
            if amount.count > 5 {
                presentAlert.toggle()
            }
        }
    }
}




