//
//  FunView.swift
//  Finn x Dimitrije
//
//  Created by Dimitrije Pesic on 03/04/2023.
//

import SwiftUI

struct FunView: View {
    @State private var favsOnly = false
    @StateObject private var vm: AdListViewModel
    init() {
        self._vm = StateObject(wrappedValue: AdListViewModel.shared)
    }
    var body: some View {
        GeometryReader { screen in
            VStack{
                Divider()
                    .padding(.bottom, screen.size.height*0.05)
                Text("FINN x Dimitrije Technical Challenge ")
                    .font(.system(size:34))
                    .fontWeight(.medium)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 15)
                    .multilineTextAlignment(.center)
                HStack{
                    Image("pusmessage")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .padding(.bottom, 10)
                    Image("pus")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .padding(.bottom, 10)
                    
                }
              
                HStack(spacing:0){
                    Text("Version: 1.0.0")
                        .font(.system(size:15))
                        .lineLimit(2)
                        .padding(.horizontal, screen.size.width * 0.15)
                        .multilineTextAlignment(.center)
                }
                HStack(spacing:0){
                    Text("If you are not satistied with own page for viewing favorite events, you can toggle favorite-events only HERE:")
                        .font(.system(size:13))
                        .lineLimit(3)
                        .padding(.horizontal, screen.size.width * 0.10)
                        .padding(.top, 10)
                        .multilineTextAlignment(.center)
                }
                Toggle("Favorites only", isOn: $favsOnly)
                           .onChange(of: favsOnly) { value in
                               vm.favsOnly.toggle()
                               vm.onlyOffline = false
                           }
                           .padding(.horizontal, 10)
                Spacer()
            }
            .navigationTitle(
                Text("Extras")
            )
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FunView_Previews: PreviewProvider {
    static var previews: some View {
        FunView()
    }
}
