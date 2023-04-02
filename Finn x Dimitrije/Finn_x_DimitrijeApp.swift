//
//  Finn_x_DimitrijeApp.swift
//  Finn x Dimitrije
//
//  Created by Dimitrije Pesic on 31/03/2023.
//

import SwiftUI

@main
struct Finn_x_DimitrijeApp: App {
    @State private var selectedTab = 0
    init() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = .white
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack(alignment: .bottom) {
                TabView(selection: $selectedTab) {
                    NavigationView {
                        AdListView()
                    }
                    .tabItem {
                        Image(selectedTab == 0 ? "finn" : "notFinn")
                            .resizable()
                            .frame(width: 70, height: 70)
                    }
                    .tag(0)
                    NavigationView {
                        // TODO: Make Varslinger page
                        NotificationsView()
                    }
                    .tabItem {
                        Image("bell")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .tint(selectedTab == 1 ? .blue : .gray)
                    }
                    .tag(1)
                    
                    NavigationView {
                        // TODO: Make My Ads page
                        Text("Mine annonser")
                            .navigationTitle("Profile")
                    }
                    .tabItem {
                        Image("myAds")
                            .resizable()
                            .tint(selectedTab == 2 ? .blue : .gray)
                    }
                    .tag(2)
                    NavigationView {
                        // TODO: Make My Ads page
                        Text("Meldinger")
                            .navigationTitle("Meldinger")
                    }
                    .tabItem {
                        Image("message")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .tint(selectedTab == 3 ? .blue : .gray)
                    }
                    .tag(3)
                    NavigationView {
                        // TODO: Make My Ads page
                        Text("Favoriter")
                            .navigationTitle("Favoriter")
                    }
                    .tabItem {
                        Image(selectedTab == 4 ? "fav" : "notFav")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    .tag(4)
                }
                .edgesIgnoringSafeArea(.bottom)
                
                Divider()
                    .background(Color.gray)
                    .frame(height: 1)
                    .offset(y: -49)
                    .padding(.bottom, 1)
                
            }
        }
    }

}


