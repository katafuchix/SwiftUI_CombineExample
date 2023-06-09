//
//  ContentView.swift
//  SwiftUI_CombineExample
//
//  Created by cano on 2023/05/10.
//

import SwiftUI


enum Content: String, CaseIterable, Identifiable {
    case publisherAndSubjectView = "Publisher And Subject"
    case publishSubjectExampleView = "CurrentValueSubject Example"
    case passthroughSubjectExampleView = "PassthroughSubject Example"
    case passthroughSubjectFailureExample = "PassthroughSubject Failure Example"
    case assignExampleView = "AssignExampleView"
    case peopleViewModelExampleView = "PeopleViewModelExampleView"
    case githubSearchView = "GithubSearchView"
    case buttonTapView = "ButtonTapView"
    case validationExampleView = "ValidationExampleView"
    
    var id: String { rawValue }
    
    var view: AnyView {
        switch self {
        case .publisherAndSubjectView:
            return AnyView(PublisherAndSubjectView())
        case .publishSubjectExampleView:
            return AnyView(PublishSubjectExampleView())
        case .passthroughSubjectExampleView:
            return AnyView(PassthroughSubjectExampleView())
        case .passthroughSubjectFailureExample:
            return AnyView(PassthroughSubjectFailureExampleView())
        case .assignExampleView:
            return AnyView(AssignExampleView())
        case .peopleViewModelExampleView:
            return AnyView(PeopleViewModelExampleView())
        case .githubSearchView:
            return AnyView(GithubSearchView())
        case .buttonTapView:
            return AnyView(ButtonTapView())
        case .validationExampleView:
            return AnyView(ValidationExampleView())
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
