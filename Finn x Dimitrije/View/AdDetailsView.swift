//
//  AdDetailsView.swift
//  Finn x Dimitrije
//
//  Created by Dimitrije Pesic on 01/04/2023.
//

import SwiftUI

struct AdDetailsView: View {
    let ad: Ad
    var body: some View {
        VStack(alignment: .trailing) {
                ScrollView{
                    HStack{
                        Image("notifications")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .background(Color.darkerGreyColor)
                            .cornerRadius(50)
                        
                        VStack(alignment: .leading){
                            Text("Velkommen til varslinger")
                                .bold()
                                .font(.system(size: 17, weight: .medium))
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                                .padding(.horizontal, 10)
                            Text("Her vil du få varslinger om dine annonser, favoritter og nytt fra FINN")
                                .font(.system(size:16))
                                .padding(.horizontal, 10)
                        }
                    }
                    .padding(.horizontal, 5)
                    .padding(.vertical, 20)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationTitle(
                Text("")
            )
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {}) {
                HStack{
                    Image(systemName: "chevron.left")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    Text("Torget")
                }
            }
                                , trailing:
                                    HStack{
                Button(action: {}) {
                    Text("Lagre søk")
                        .foregroundColor(.blue)
                }
                Button(action: {}) {
                    Text("Lagre søk")
                        .foregroundColor(.blue)
                }
            })
    }
}

struct AdDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AdDetailsView(ad: Ad(id: "1", description: "Fin Bok", url: "/2023/lol.jpg", adType: .b2B, location: "Stavanger", type: .ad, price: Price(value: 100, total: nil), image: AdImage(url: "2023/3/vertical-0/04/6/293/508/636_1678017296.jpg", height: 100, width: 100, type: .general, scalable: true), score: 0.70, favourite: Favourite(adId: "22", adType: "ad"), shippingOption: ShippingOption(label: .fiksFerdig)))
    }
}
