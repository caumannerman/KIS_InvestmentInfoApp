//
//  MarketInfoView.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/04/28.
//

import SwiftUI

struct MarketInfoView: View {
    var body: some View {

//            Text("Example")
//            .background(Color.blue)

        ZStack{
       
            VStack {
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundColor(Color.green)
                        Text("Hello, world!")
                            .foregroundColor(Color.black)
                    }
        }
        VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(Color.green)
                    Text("Hello, world!")
                        .foregroundColor(Color.black)
                }
        VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(Color.green)
                    Text("Hello, world!")
                        .foregroundColor(Color.black)
                }
        VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(Color.green)
                    Text("Hello, world!")
                        .foregroundColor(Color.black)
                }
        
        .background(Color.red)
        .ignoresSafeArea()
    }

}

struct MarketInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MarketInfoView()
    }
}
