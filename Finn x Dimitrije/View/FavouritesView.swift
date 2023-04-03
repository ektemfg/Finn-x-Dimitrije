//
//  FavouritesView.swift
//  Finn x Dimitrije
//
//  Created by Dimitrije Pesic on 02/04/2023.
//

import SwiftUI

struct FavouritesView: View {
    @ObservedObject private var vm = AdListViewModel.shared
    var adList: [Ad] {
        vm.favAdList
    }
    init() {
            vm.loadAds()
        }
    var body: some View {
        if adList.isEmpty {
            VStack{
                Divider()
                Spacer()
                HStack(spacing:0) {
                    Text("FINN")
                        .font(.system(.title))
                        .foregroundColor(.blue)
                        .bold()
                        .fontWeight(.black)
                    Text("er du noe du liker?")
                        .font(.system(.title))
                }
                Image("pus")
                    .resizable()
                    .frame(width: 250, height: 250)
                HStack(spacing:0){
                    Text("Trykk på")
                        .font(.system(.headline))
                    Image(systemName: "heart.fill")
                        .foregroundColor(.blue)
                    Text("i annonsen!")
                        .font(.system(.headline))
                }
                Spacer()
            }
            .navigationTitle(
                Text("Ingen favoritter")
            )
            .navigationBarTitleDisplayMode(.inline)
        } else {
            List(adList, id: \.id) { ad in
                VStack{
                    Divider()
                    AdView(ad: ad)
                }
                .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            Button(action: {
                                vm.userDefaultsOperation(.removeFavorite, ad: ad)
                            }) {
                                HStack {
                                                    Image(systemName: "heart.slash")
                                                    Text("Slett")
                                                }
                            }
                            .tint(.red)
                        }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            
            
            .navigationTitle(
                Text("Favoritter")
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
                                , trailing: Button(action: {}) {
                Text("Slett alle")
                    .foregroundColor(.blue)
                    .onTapGesture {
                        vm.userDefaultsOperation(.clearFavorites, ad:nil)
                    }
            })
        }
    }
}


struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
