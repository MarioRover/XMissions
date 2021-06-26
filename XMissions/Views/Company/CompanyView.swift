//
//  CompanyView.swift
//  Space Missions
//
//  Created by Hossein Akbari on 1/9/1400 AP.
//

import SwiftUI

struct CompanyView: View {
    
    @ObservedObject private var companyVM: CompanyViewModel
    @State var currentIndex = 0
    @State private var isShowing = false
    var company: CompanyModel
    
    init(companyData: CompanyModel) {
        self.companyVM = CompanyViewModel(company: companyData)
        self.company = companyData
    }
    
    private let numberOfImages = 4
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("navy-blue").edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 40) {
                        Spacer()
                        
                        VStack(alignment: .center, spacing: 10) {
                            Text("Space Exploration Technologies Corporation")
                                .foregroundColor(Color.white)
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                            
                            if let founded = self.company.founded , let founder = self.company.founder {
                                
                                Text("Founded in \(String(founded)) by \(founder)")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14, weight: .light, design: .rounded))
                            }

                            
                        }
                        
                        
                        
                        TabView(selection: $currentIndex) {
                            ForEach(1..<numberOfImages) { num in
                                Image("company-\(num)")
                                    .resizable()
                                    .tag(num)

                            }
                        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .frame(width: UIScreen.main.bounds.width, height: 200)
                        .onReceive(timer, perform: { _ in
                            withAnimation {
                                currentIndex = currentIndex < numberOfImages ? currentIndex + 1 : 0
                            }
                        })
                        
                        
                        
                        VStack(spacing: 40) {
                            VStack(alignment: .leading, spacing: 14) {
                                ViewTools.HeaderSection(title: "Managers")

                                ForEach(self.companyVM.managers, id:\.id) { manager in
                                    UserItem(manager: manager)
                                }
                            }
                            
                            VStack {
                                ViewTools.HeaderSection(title: "Summery")

                                Text(self.company.summary ?? "")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14, weight: .light, design: .rounded))
                                    .padding([.leading, .trailing], 16)

                            }
                            
                            VStack(alignment: .leading, spacing: 14) {
                                ViewTools.HeaderSection(title: "Information")
                                
                                ForEach(self.companyVM.companyInfo, id:\.label) { info in
                                    InfoItem(info: info)
                                }
                                
                            }
                            
                            VStack {
                                ViewTools.HeaderSection(title: "Social")
                                
                                HStack(alignment: .center, spacing: 20) {
                                    ForEach(self.companyVM.companySocial, id:\.label) { data in
                                        SocialItem(social: data)
                                    }
                                }
                                
                            }
                        }.padding([.leading, .trailing], 15)
                    }
                }
                .navigationBarTitle("Comapny")
            }
        }
    }
}

struct CompanyView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyView(companyData: CompanyModel(ceo: "", coo: "", cto: "", cto_propulsion: "", employees: 0, founded: 0, founder: "", headquarters: Headquarters(address: "", city: "", state: ""), links: Links(website: "", twitter: "", flickr: ""), summary: "", valuation: 0))
            .previewDevice("iPhone 12")
    }
}



struct UserItem: View {
    
    let manager: Manager
    
    var body: some View {
        HStack(spacing: 10) {
            
            Image("user-tie")
                .resizable()
                .frame(width: 30, height: 34, alignment: .center)
                .foregroundColor(.white)
            
            
            VStack(alignment: .leading) {
                Text(manager.label)
                    .foregroundColor(Color.white)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))

                if(!manager.definition.isEmpty) {
                    Text(manager.definition)
                        .foregroundColor(Color("light-gray"))
                        .font(.system(size: 14, weight: .light, design: .rounded))
                }
            }
            
            Spacer()
            
            Text(manager.name)
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .medium, design: .rounded))
        }.padding([.leading, .trailing], 16)
    }
}

struct InfoItem: View {
    let info: CompanyInfo
    
    var body: some View {
        HStack {
            Image(uiImage: info.image ?? Tool.defaultImage)
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(.white)
            
            Text(info.label)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
            
            Spacer()
            
            Text(info.value)
                .font(.system(size: 14, weight: .medium, design: .rounded))
        }
        .padding([.leading, .trailing], 16)
        .foregroundColor(.white)
    }
}

struct SocialItem: View {
    @Environment(\.openURL) var openURL
    
    let social: CompanyInfo
    
    var body: some View {

        if let url = URL(string: social.value) {
            Link(destination: url) {
                VStack {
                    ZStack(alignment: .center) {
                        Image(uiImage: social.image ?? Tool.defaultImage)
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
                            .foregroundColor(.black)
                    }
                    .frame(width: 50, height: 50, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(7)
                    
                    Text(social.label)
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(.white)
                }
            }
        }
        
    }
}
