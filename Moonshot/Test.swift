//
//  ImageView.swift
//  Moonshot
//
//  Created by Don Bouncy on 05/11/2022.
//

import SwiftUI

/*
struct CustomText: View{
    let text: String
    
    var body: some View{
        Text(text)
    }
    
    init(_ text: String) {
        print("Text created")
        self.text = text
    }
}

struct Developer: Codable{
    let name: String
    let skills: [String]
    let family: [Family]
}

struct Family: Codable{
    let relation: String
    let name: String
}
*/

struct Test: View {
    //Fixed layout
    /*
    let layout = [
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
        GridItem(.fixed(100))
    ]
    */
    
    //Adaptive Layout
    
    let layout = [
        GridItem(.adaptive(minimum: 20, maximum: 120))
    ]
    
    var body: some View {
        // GeometryReader
        /*
        GeometryReader { proxy in
            Image("Example")
                .resizable()
                .scaledToFit()
                .frame(width: proxy.size.width * 0.8)
                .frame(width: proxy.size.width, height: proxy.size.height)
        }
         */
        
        //ScrollView
        //Vertical ScrollView
        /*
        ScrollView {
            //Loads all views on start
            VStack {
                ForEach(0..<20) {
                    Text("Item \($0)")
                        .padding(.bottom)
                }
            }
            
            //Loads views on demand
            LazyVStack {
                ForEach(0..<20) {
                    CustomText("Item \($0)")
                        .padding(.bottom)
                }
            }
        }
         */
        
        //Horizontal ScrollView
        /*
        ScrollView(.horizontal) {
            //Loads all views on start
            HStack {
                ForEach(0..<20) {
                    Text("Item \($0)")
                        .padding(.trailing)
                }
                
                //Loads views on demand
                LazyHStack {
                    ForEach(0..<20) {
                        CustomText("Item \($0)")
                            .padding(.trailing)
                    }
                }
            }
        }
        */
        
        //Codable Heirachy
        /*
        Button("Decode JSON") {
            let input = """
            {
                "name": "Alexander Boakye",
                "skills": ["Regex", "JavaScript", "NodeJS", "ExpressJS"],
                "family": [
                    {
                        "relation": "Father",
                        "name": "JK Boakye"
                    },
                    {
                        "relation": "Mother",
                        "name": "Mercy Opare Boakye"
                    },
                    {
                        "relation": "Sister",
                        "name": "Afua Serwaa Boakye"
                    }]
            }
            """
            let data = Data(input.utf8)
            
            if let developer = try? JSONDecoder().decode(Developer.self, from: data){
                print(developer.family)
            }
        }
         */
        
        //Vertical GridView
        /*
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(0..<10000) {
                    Text("Item \($0)")
                }
            }
        }
        */
        
        //Horizontal GridView
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout) {
                ForEach(1..<10001) {
                    Text("Item \($0)")
                }
            }
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
