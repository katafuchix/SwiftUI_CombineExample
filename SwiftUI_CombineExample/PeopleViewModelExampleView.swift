//
//  PeopleViewModelExampleView.swift
//  SwiftUI_CombineExample
//
//  Created by cano on 2023/05/27.
//

import SwiftUI
import Combine

fileprivate final class Person {
    var name: String = ""
    var surname: String = ""
    
    init(name: String, surname: String) {
        self.name = name
        self.surname = surname
    }
}

fileprivate final class PeopleViewModel: ObservableObject {
    @Published var people = [Person]()
    var subscriptions = Set<AnyCancellable>()
    
    init(){
        $people
            .sink (receiveValue: {
                guard let last = $0.last else {return}
                print("Last recieved: \(String(describing: last.name)) \(String(describing: last.surname))")
            })
            .store(in: &subscriptions)
    }
    
}

struct PeopleViewModelExampleView: View {
    
    // Variables
    @ObservedObject fileprivate var peopleModel: PeopleViewModel = PeopleViewModel()
    @State var name: String = ""
    @State var surname: String = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 25){
            Text("Hello, enter a contact")
                .padding(.bottom, 50)
            HStack(alignment: .center, spacing: 2){
                VStack{
                    Text("New name: ")
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 30)
                VStack{
                    TextField("Name", text: $name)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                
            }
            HStack(alignment: .center, spacing: 2){
                VStack{
                    Text("New surname: ")
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 30)
                VStack{
                    TextField("Surname", text: $surname)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
            }
            // Triggers the publisher
            Button(action: {
                self.peopleModel.people.append(Person(name: self.name, surname: self.surname))
            }) {
                Text("Update")
            }
            // Once this button is pressed, publisher won't work anymore
            Button(action: {
                self.peopleModel.subscriptions.removeAll()
            }) {
                Text("Cancel subscriptions")
            }
        }
    }
}

struct PeopleViewModelExampleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleViewModelExampleView()
    }
}
