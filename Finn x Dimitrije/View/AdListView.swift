//
//  AdListView.swift
//  Finn x Dimitrije
//
//  Created by Dimitrije Pesic on 01/04/2023.
//

import SwiftUI

struct AdListView: View {
    @ObservedObject private var vm = AdListViewModel.shared
    var adList: [Ad] {
        vm.favsOnly ? vm.favAdList : vm.adList
    }
    var body: some View {
        if adList.isEmpty {
            VStack{
                Divider()
                Spacer()
                HStack(spacing:0) {
                    Text("Vi ")
                    Text("FINN")
                        .font(.system(.title))
                        .foregroundColor(.blue)
                        .bold()
                        .fontWeight(.black)
                    Text("er ingenting her")
                        .font(.system(.title))
                }
                Image("pus")
                    .resizable()
                    .frame(width: 250, height: 250)
                VStack(){
                    Text("Sjekk om du er tilkoblet.")
                        .font(.system(.headline))
                    Text("PS. Du kan alltid se dine favoritter")
                        .font(.system(.headline))
                }
                Spacer()
            }
        } else {
            List(adList, id: \.id) { ad in
                VStack{
                    Divider()
                    AdView(ad: ad)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            
            
            .navigationTitle(
                Text("Torget")
            )
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {}) {
                HStack{
                    Image(systemName: "chevron.left")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    Text("Hjem")
                }
            }
                                , trailing: Button(action: {}) {
                Text("Lagre søk")
                    .foregroundColor(.blue)
            })
        }
    }
        
    
}


struct AdListView_Previews: PreviewProvider {
    static var previews: some View {
        AdListView()
    }
}
