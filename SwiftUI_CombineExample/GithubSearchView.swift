//
//  GithubSearchView.swift
//  SwiftUI_CombineExample
//
//  Created by cano on 2023/05/27.
//

import SwiftUI
import Combine

struct User: Hashable, Identifiable, Decodable {
    var id: Int64
    var login: String
    var avatar_url: URL
}

struct SearchUserResponse: Decodable {
    var items: [User]
}

final class SearchUserViewModel: ObservableObject {
    @Published var name = "katafuchix"
    @Published private(set) var users = [User]()
    @Published private(set) var userImages = [User: UIImage]()

    private var searchCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }

    deinit {
        searchCancellable?.cancel()
    }

    func search() {
        guard !name.isEmpty else {
            return users = []
        }

        var urlComponents = URLComponents(string: "https://api.github.com/search/users")!
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: name)
        ]

        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        searchCancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: SearchUserResponse.self, decoder: JSONDecoder())
            .map { $0.items }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .assign(to: \.users, on: self)
    }

    func fetchImage(for user: User) {
        guard case .none = userImages[user] else {
            return
        }

        let request = URLRequest(url: user.avatar_url)
        _ = URLSession.shared.dataTaskPublisher(for: request)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] image in
                self?.userImages[user] = image
            })
    }
}

struct SearchUserBar: View {
    @Binding var text: String
    @State var action: () -> Void

    var body: some View {
        ZStack {
            Color.yellow
            HStack {
                TextField("Search User", text: $text)
                    .padding([.leading, .trailing], 8)
                    .frame(height: 32)
                    .background(Color.white.opacity(0.4))
                    .cornerRadius(8)

                Button(
                    action: action,
                    label: { Text("Search") }
                    )
                    .foregroundColor(Color.white)
                }
                .padding([.leading, .trailing], 16)
            }
            .frame(height: 64)
    }
}

struct SearchUserRow: View {
    @ObservedObject var viewModel: SearchUserViewModel
    @State var user: User

    var body: some View {
        HStack {
            viewModel.userImages[user].map { image in
                Image(uiImage: image)
                    .frame(width: 44, height: 44)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black, lineWidth: 1))
            }

            Text(user.login)
                .font(Font.system(size: 18).bold())

            Spacer()
            }
            .frame(height: 60)
    }
}

struct GithubSearchView: View {
    @ObservedObject var viewModel = SearchUserViewModel()

    var body: some View {
        NavigationView {
            VStack {
                SearchUserBar(text: $viewModel.name) {
                    self.viewModel.search()
                }

                List(viewModel.users) { user in
                    SearchUserRow(viewModel: self.viewModel, user: user)
                        .onAppear { self.viewModel.fetchImage(for: user) }
                }
                }
                .navigationBarTitle(Text("Users"))
        }
    }
}

struct GithubSearchView_Previews: PreviewProvider {
    static var previews: some View {
        GithubSearchView()
    }
}
