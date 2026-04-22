//
//  PracticeView.swift
//  PREPare
//
//  Created by rahdeva on 22/04/26.
//

import SwiftUI

struct PracticeView: View {
    @Binding var path: NavigationPath
    
    var body: some View {
        Text("PracticeView")
    }
}

#Preview {
    NavigationStack {
        PracticeView(path: .constant(NavigationPath()))
    }
}
