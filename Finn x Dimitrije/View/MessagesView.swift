//
//  MessagesView.swift
//  Finn x Dimitrije
//
//  Created by Dimitrije Pesic on 03/04/2023.
//

import SwiftUI

struct MessagesView: View {
    @State private var isFinnPusHidden = true
    var body: some View {
        GeometryReader { screen in
            VStack{
                Divider()
                    .padding(.bottom, screen.size.height*0.05)
                Text("Her var det stille gitt")
                    .font(.system(size:34))
                    .fontWeight(.medium)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 15)
                HStack(spacing:0){
                    Text("Når du prater med andre på FINN, vil meldingene dine dukke opp her.")
                        .font(.system(size:15))
                        .lineLimit(2)
                        .padding(.horizontal, screen.size.width * 0.15)
                        .multilineTextAlignment(.center)
                }
                HStack(spacing:0){
                    Text("Søk på noe du har lyst på, send en melding til selgeren og bli enige om en handel på en-to-tre!")
                        .font(.system(size:15))
                        .lineLimit(3)
                        .padding(.horizontal, screen.size.width * 0.10)
                        .padding(.top, 10)
                        .multilineTextAlignment(.center)
                }
                Spacer()
                if !isFinnPusHidden {
                    Image("pusmessage")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .padding(.bottom, -20)
                        .transition(.move(edge: .bottom))
                        .ignoresSafeArea()
                }
            }
            .navigationTitle(
                Text("Ingen meldinger")
            )
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                withAnimation(.easeInOut(duration: 2)) {
                    isFinnPusHidden.toggle()
                }
                if isFinnPusHidden == false {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                        withAnimation(.easeInOut(duration: 3)) {
                            isFinnPusHidden.toggle()
                        }
                    }
                }
            }
        }
    }
}
struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
