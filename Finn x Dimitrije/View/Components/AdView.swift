//
//  AdView.swift
//  Finn x Dimitrije
//
//  Created by Dimitrije Pesic on 01/04/2023.
//

import SwiftUI

struct AdView: View {
    let ad: Ad
    var body: some View {
        HStack {
            Spacer()
            ZStack(alignment: .topLeading){
                    Image("bilde")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(8)
                ad.hasShipping ?
                    HStack(spacing: 2) {
                        Image("fiksferdig")
                            .resizable()
                            .colorMultiply(.darkerYellowColor)
                            .bold()
                            .frame(width: 14, height: 14)
                        Text("Fiks ferdig")
                            .font(.custom("Inter", size: 8))
                            .foregroundColor(.darkerYellowColor)
                            .bold()
                            .padding(.top, 2)
                    }
                    .padding(.leading, 8)
                    .padding(.trailing, 5.7)
                    .padding(.vertical, 1)
                    .background(Color.yellowColor)
                    .cornerRadius(3)
                :
                nil
                }
            .background(Color(red: 0.95, green: 0.98, blue: 1))
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(red: 0.76, green: 0.80, blue: 0.85), lineWidth: 1))
            VStack(alignment: .leading) {
                HStack{
                    Text("\(Int.random(in: 1...24)) timer siden")
                        .foregroundColor(.gray)
                        .font(.custom("default", size: 10))
                    Text("\(ad.location ?? "Oslo")")
                        .foregroundColor(.gray)
                        .font(.custom("default", size: 10))
                }
                .padding(.top, 2)
                VStack(alignment: .leading) {
                    Text("\(ad.description ?? "Kul ting")")
                        .fontWeight(.thin)
                        .foregroundColor(Color(red: 0.28, green: 0.27, blue: 0.27))
                        .padding(.bottom, 1)
                    Text("\(ad.price?.total ?? ad.price?.value ?? 1337) kr")
                        .font(.custom("Inter", size: 10))
                        .foregroundColor(.black)
                        
                    Spacer()
                }
            }
            ZStack {
                ZStack {
                }
                .position(x: 22, y: 22)
            }
            .cornerRadius(44)
        }
        .padding(.vertical, 10)
        .background(Color(red: 1, green: 1, blue: 1))
        .fixedSize(horizontal: true, vertical: true)
    }
}

struct AdView_Previews: PreviewProvider {
    static var previews: some View {
        AdView(ad: Ad(id: "1", description: "Fin Bok", url: "/2023/lol.jpg", adType: .b2B, location: "Stavanger", type: .ad, price: Price(value: 100, total: 200), image: AdImage(url: "/2023/lol.jpg", height: 100, width: 100, type: .general, scalable: true), score: 0.70, favourite: Favourite(adId: "22", adType: .b2B), shippingOption: ShippingOption(label: .fiksFerdig)))
    }
}
