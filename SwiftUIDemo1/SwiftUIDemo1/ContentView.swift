//
//  ContentView.swift
//  SwiftUIDemo1
//
//  Created by mac admin on 25/06/20.
//  Copyright © 2020 Kunal. All rights reserved.
//

import SwiftUI
import Combine

class DataSource: ObservableObject {
    let willChange = PassthroughSubject<Void, Never>()
    var pictures = [String]()

    init() {
        let fm = FileManager.default
        let path = "/Users/macadmin/Desktop/SwiftUIDemo1/SwiftUIDemo1/Pictures"
           if let items = try? fm.contentsOfDirectory(atPath: path) {
                print(items)
                for item in items {
                    if item.hasPrefix("images") {
                        pictures.append(item)
                    }
                }
            }
        willChange.send()
    }
}
struct DetailsView:View {
    var selectedImage: String

    var body: some View {
        let img = UIImage(named: selectedImage)!
        return Image(uiImage: img)
    }
}


struct ContentView: View {

@ObservedObject var dataSource = DataSource()

    var body: some View {
        NavigationView {
            List(dataSource.pictures,id: \.self) { element in
               NavigationLink(
               destination: DetailsView(selectedImage: element)) {
                        Text(element)
                    }


//                Text(element)
            }.navigationBarTitle(Text("Picture View"))
        }


    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
