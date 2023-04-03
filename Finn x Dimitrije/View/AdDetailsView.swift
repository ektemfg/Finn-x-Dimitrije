//
//  AdDetailsView.swift
//  Finn x Dimitrije
//
//  Created by Dimitrije Pesic on 01/04/2023.
//

import SwiftUI

struct AdDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    let ad: Ad
    @State var isFavorite: Bool
    @StateObject  var vm: AdListViewModel
    init(ad: Ad) {
        self.ad = ad
        self._isFavorite = State(initialValue: AdListViewModel.shared.favsContainsAd(ad: ad))
        self._vm = StateObject(wrappedValue: AdListViewModel.shared)
    }
    var body: some View {
        GeometryReader { screen in
            VStack(alignment: .trailing) {
                ScrollView{
                    if let imageURL = Endpoints.image(url: ad.image.url).url {
                        AsyncImage(url: imageURL) { image in
                            image
                                .resizable()
                                .frame(width: screen.size.width / 1.1, height: screen.size.height / 3)
                        } placeholder: {
                            ProgressView()
                        }
                        .overlay(
                            ZStack{
                                Rectangle()
                                    .frame(width: screen.size.width / 2 / 6, height: 10)
                                    .foregroundColor(.black)
                                    .opacity(0.4)
                                    .cornerRadius(2)
                                    .padding(.top, screen.size.height / 3 - 20 )
                                Text("1 / 1")
                                    .foregroundColor(.white)
                                    .font(.system(size:8))
                                    .bold()
                                    .padding(.top, screen.size.height / 3 - 20 )
                            }
                                )
                              
                        
                    } else {
                        Image("pus")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(8)
                    }
                    HStack{
                        HStack{
                            Button(action: {
                                isFavorite.toggle()
                            }) {
                                Image(systemName: isFavorite ? "heart.fill" : "heart")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 20))
                            }
                            Text("Legg til favoritt")
                                .foregroundColor(.blue)
                                .fontWeight(.medium)
                                .font(.system(size:15))
                            Spacer()
                            Text("\(ad.hoursSinceAdded) til har lagt til som favoritt")
                                .font(.system(size:10))
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                    }
                    VStack{
                        HStack{
                            Text(ad.description!)
                                .font(.title)
                                .padding(.leading, 15)
                                .fontWeight(.light)
                            Spacer()
                        }
                        HStack{
                            Text("Til salgs")
                                .font(.system(size: 14))
                                .padding(.leading, 15)
                                .padding(.top, 5)
                            Spacer()
                        }
                        HStack(spacing:0){
                            Text(String((ad.price?.total ?? ad.price?.value) ?? 1337))
                                .padding(.leading, 15)
                                .font(.title)
                                .fontWeight(.medium)
                            Text(" kr")
                                .font(.title)
                                .fontWeight(.medium)
                            Spacer()
                        }
                        Button(action: {}) {
                            Text("Send melding")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .frame(width: screen.size.width*0.85, height: 6)
                        .padding()
                                .background(Color.accentColor)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: screen.size.width*0.92, height: 150)
                            .cornerRadius(2)
                            .border(.gray)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationTitle(
                Text("")
            )
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack{
                    Image(systemName: "chevron.left")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    Text("Tilbake")
                }
            }
                                , trailing:
                                    HStack{
                Button(action: {
                    isFavorite.toggle()
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? Color.blue : Color.gray)
                        .font(.system(size: 20))
                }
                .onChange(of: isFavorite) { value in
                    if value {
                        vm.userDefaultsOperation(.addFavorite, ad: ad)
                    } else {
                        vm.userDefaultsOperation(.removeFavorite, ad: ad)
                    }}
                Button(action: {
                    let logoToShare = UIImage(named: "finn")!
                    let titleToShare = ad.description!
                    let linkToShare = Endpoints.image(url: ad.url!)
                    let itemsToShare : [Any] = [titleToShare, linkToShare, logoToShare]
                    let av = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
                    UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            })
        }
    }
}

struct AdDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AdDetailsView(ad: Ad(id: "1", description: "AMADEUS SENZA GRANDE BT HØYTALLER + DAB BLÅ", url: "/2023/lol.jpg", adType: .b2B, location: "Stavanger", type: .ad, price: Price(value: 100, total: nil), image: AdImage(url: "2023/3/vertical-0/04/6/293/508/636_1678017296.jpg", height: 100, width: 100, type: .general, scalable: true), score: 0.70, favourite: Favourite(adId: "22", adType: "ad"), shippingOption: ShippingOption(label: .fiksFerdig)))
    }
}
