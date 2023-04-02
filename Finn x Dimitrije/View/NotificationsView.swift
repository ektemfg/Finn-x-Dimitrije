//
//  NotificationsView.swift
//  Finn x Dimitrije
//
//  Created by Dimitrije Pesic on 02/04/2023.
//

import SwiftUI

struct NotificationsView: View {
    @State private var selectedOption = ButtonOptions.savedSearch
    var body: some View {
        VStack(alignment: .trailing) {
            VStack {
                ZStack{
                    Color.brightGreyColor
                        .frame(width: 370, height: 35)
                        .cornerRadius(10)
                    HStack(spacing: 5) {
                        ForEach(ButtonOptions.allCases, id: \.self) { option in
                            Button(action: {
                                self.selectedOption = option
                            }) {
                                Text(option.rawValue)
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(selectedOption == option ? Color.white : Color.brightGreyColor)
                                    .cornerRadius(4)
                                    .animation(.spring())
                                
                            }
                            
                        }
                        
                    }
                    .frame(height: 30)
                    .background(Color.brightGreyColor)
                    .cornerRadius(5)
                    .padding()
                }
                Divider()
                    .padding(.top, -5)
            }
            if selectedOption == .savedSearch {
                HStack{
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .background(Color.white)
                    
                    VStack(alignment: .leading){
                        Text("Fant du ingenting kult enda?")
                            .bold()
                            .font(.system(size: 17, weight: .medium))
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                            .padding(.horizontal, 10)
                        Text("Her vil du få søk som du har lagret, gå og FINN noe og kom tilbake!")
                            .font(.system(size:16))
                            .padding(.horizontal, 10)
                    }
                }
                .padding(.horizontal, 5)
                .padding(.vertical, 20)
            }
            else {
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
                Text("Varslinger")
            )
            .navigationBarTitleDisplayMode(.inline)
    }
}

enum ButtonOptions: String, CaseIterable {
    case savedSearch = "Lagrede søk"
    case checkThis = "Sjekk dette"
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
