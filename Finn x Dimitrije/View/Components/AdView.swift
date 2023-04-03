//
//  AdView.swift
//  Finn x Dimitrije
//
//  Created by Dimitrije Pesic on 01/04/2023.
//

import SwiftUI

struct AdView: View {
    let ad: Ad
     @State var isFavorite: Bool
     @StateObject private var vm: AdListViewModel
     
     init(ad: Ad) {
         self.ad = ad
         self._isFavorite = State(initialValue: AdListViewModel.shared.favsContainsAd(ad: ad))
         self._vm = StateObject(wrappedValue: AdListViewModel.shared)
     }
    var body: some View {
        NavigationLink("",
                       destination: AdDetailsView(ad: ad)).opacity(0)
        .buttonStyle(PlainButtonStyle())

        HStack(spacing: 10) {
            VStack {
                ZStack(alignment: .topLeading) {
                    if let imageURL = Endpoints.image(url: ad.image.url).url {
                        AsyncImage(url: imageURL) { image in
                            image
                                .resizable()
                                .frame(width: 120, height: 100)
                                .cornerRadius(8)
                        } placeholder: {
                            ProgressView()
                        }
                    } else {
                        Image("bilde")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(8)
                    }
                    
                    if ad.hasShipping {
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
                    }
                }
                .background(Color(red: 0.95, green: 0.98, blue: 1))
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(red: 0.76, green: 0.80, blue: 0.85), lineWidth: 1))
                .padding(.trailing, 5)
            }
            
            VStack(alignment: .leading) {
                Button(action: {}) {
                    HStack {
                        Text("\(ad.hoursSinceAdded) \(ad.adType == .realestate ? "dager" : "timer") siden")
                            .foregroundColor(.gray)
                            .font(.custom("default", size: 14))
                        Text("\(ad.location ?? "Oslo")")
                            .foregroundColor(.gray)
                            .font(.custom("default", size: 14))
                        Spacer()
                        Button(action: {
                            isFavorite.toggle()
                        }) {
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .foregroundColor(isFavorite ? Color.blue : Color.gray)
                                .font(.system(size: 20))
                        }
                    }
                }
                .onChange(of: isFavorite) { value in
                    if value {
                        vm.userDefaultsOperation(.addFavorite, ad: ad)
                    } else {
                        vm.userDefaultsOperation(.removeFavorite, ad: ad)
                    }}
                .padding(.top, 2)
                
                Text("\(ad.description ?? "Kul ting")")
                    .lineLimit(1)
                    .font(.custom("Inter", size: 16))
                    .foregroundColor(Color(red: 0.28, green: 0.27, blue: 0.27))
                    .padding(.bottom, 1)
                
                Text("\(ad.price?.total ?? ad.price?.value ?? 1337) kr")
                    .font(.custom("Inter", size: 14))
                    .foregroundColor(.black)
                
                Spacer()
            }
        }
        .background(Color(red: 1, green: 1, blue: 1))
        .onAppear{
            self.isFavorite = AdListViewModel.shared.favsContainsAd(ad: ad)
        }
    }
}


struct AdView_Previews: PreviewProvider {
    static var previews: some View {
        AdView(ad: Ad(id: "1", description: "Fin Bok", url: "/2023/lol.jpg", adType: .b2B, location: "Stavanger", type: .ad, price: Price(value: 100, total: nil), image: AdImage(url: "2023/3/vertical-0/04/6/293/508/636_1678017296.jpg", height: 100, width: 100, type: .general, scalable: true), score: 0.70, favourite: Favourite(adId: "22", adType: "ad"), shippingOption: ShippingOption(label: .fiksFerdig)))
    }
}
