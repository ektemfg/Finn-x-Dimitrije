//
//  AdListView.swift
//  Finn x Dimitrije
//
//  Created by Dimitrije Pesic on 01/04/2023.
//

import SwiftUI

struct AdListView: View {
    @StateObject private var vm = AdListViewModel.shared
    var adList: [Ad] {
        vm.adList
    }
    var body: some View {
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


struct AdListView_Previews: PreviewProvider {
    static var previews: some View {
        AdListView()
    }
}
