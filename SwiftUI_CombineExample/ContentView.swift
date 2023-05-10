//
//  ContentView.swift
//  SwiftUI_CombineExample
//
//  Created by cano on 2023/05/10.
//

import SwiftUI


enum Content: String, CaseIterable, Identifiable {
    case passthroughSubjectExampleView = "PassthroughSubjectExampleView"
    
    var id: String { rawValue }
    
    var view: AnyView {
        switch self {
        case .passthroughSubjectExampleView:
            return AnyView(PassthroughSubjectExampleView())
        }
    }
}


struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Contents") {
                    ForEach(Content.allCases) { content  in
                        NavigationLink(value: content) {
                            Text(content.rawValue)
                        }
                    }
                }
            }
            .navigationDestination(for: Content.self) { content in
                content.view
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
