//
//  AssignExampleView.swift
//  SwiftUI_CombineExample
//
//  Created by cano on 2023/05/10.
//

import SwiftUI
import Combine

class SomeObject {
    var value: String = ""
}

struct AssignExampleView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                let object = SomeObject()
                let publisher = Just("Hello, World!")
                
                let cancellable = publisher
                    .assign(to: \.value, on: object)

                // SomeObject の value プロパティに "Hello, World!" が代入される
                print(object.value) // "Hello, World!"
                print(object)
                
                /*
                let cancellable = publisher
                    .sink(receiveValue: { value in
                        // "Hello, World!" を受け取り、処理する
                        print(value)
                    })
                 */
                cancellable.cancel()
            }
    }
}

struct AssignExampleView_Previews: PreviewProvider {
    static var previews: some View {
        AssignExampleView()
    }
}
