//
//  ResultView.swift
//  PREPare
//
//  Created by rahdeva on 22/04/26.
//

import SwiftUI

struct ResultView: View {
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack{
            Image("haha")
                .background(.black)
            
            Text("Hehe Maap belum jadi")
                .font(.title)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    NavigationStack {
        ResultView(path: .constant(NavigationPath()))
    }
}
