//
//  CompanyView.swift
//  Space Missions
//
//  Created by Hossein Akbari on 1/9/1400 AP.
//

import SwiftUI

struct CompanyView: View {
    
    @ObservedObject private var companyVM: CompanyViewModel
    var company: Company?
    
    init() {
        self.companyVM = CompanyViewModel()
        if let safeData = self.companyVM.company {
            company = safeData
        }
    }
    
    private let rows = [
        GridItem(.fixed(70)),
        GridItem(.fixed(70))
    ]
    
    private var numberOfImages = 4
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State var currentIndex = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("navy-blue").edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 21) {
                        Spacer()
                        
                        VStack(alignment: .center, spacing: 10) {
                            Text("Space Exploration Technologies Corporation")
                                .foregroundColor(Color.white)
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                            
                            if let founded = self.company?.founded , let founder = self.company?.founder {
                                
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
                        
                        
                        
                        VStack(alignment: .leading, spacing: 14) {
                            HeaderSection(title: "Managers")

                            ForEach(self.companyVM.managers, id:\.id) { manager in
                                UserItem(manager: manager)
                            }
                        }
                        
                        VStack {
                            HeaderSection(title: "Summery")

                            Text(self.company?.summary ?? "")
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .light, design: .rounded))
                                .padding([.leading, .trailing], 16)

                        }
                        
                        VStack(alignment: .leading, spacing: 14) {
                            HeaderSection(title: "Information")
                            
                            ForEach(self.companyVM.companyInfo, id:\.label) { info in
                                InfoItem(info: info)
                            }
                            
                        }
                    }
                }
                .navigationBarTitle("Comapny")
            }
        }
    }
}

struct CompanyView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyView()
            .previewDevice("iPhone 12")
    }
}

struct HeaderSection: View {
    
    @State var title: String
    
    var body: some View {
        Text(self.title)
            .foregroundColor(Color.white)
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .padding([.bottom], 14)
            .padding(.leading, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
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
            Image(uiImage: info.image ?? defaultImage)
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
