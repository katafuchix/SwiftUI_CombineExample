//
//  PassthroughSubjectExampleView.swift
//  SwiftUI_CombineExample
//
//  Created by cano on 2023/05/10.
//

import SwiftUI
import Combine

struct PassthroughSubjectExampleView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                
                // Publishersを定義する
                let publisher1 = PassthroughSubject<String, Never>()
                let publisher2 = PassthroughSubject<String, Never>()

                // Publishersを組み合わせる
                let combined = Publishers.CombineLatest(publisher1, publisher2)

                // 最終値を処理する
                /*
                let cancellable = combined.sink { value in
                    print("Combined value: \(value.0) and \(value.1)")
                }
                */
                
                let cancellable = combined.sink(receiveCompletion:  { (completion) in
                    switch completion {
                        case .finished:
                            print("finished successfully")
                        case .failure(let error):
                            print("error occured: \(error)")
                    }}, receiveValue: { (value) in
                        print("value received: \(value)")
                    })

                // 値を送信する
                publisher1.send("Hello")
                publisher2.send("World!")
                publisher1.send("How")
                publisher2.send("are you?")

                publisher1.send(completion: .finished)
                publisher1.send("are you?") // publisher1のみ完了
                
                publisher2.send("continue?")
                
                // Combineの購読をキャンセルする
                cancellable.cancel()
            }
    }
}

struct PassthroughSubjectExampleView_Previews: PreviewProvider {
    static var previews: some View {
        PassthroughSubjectExampleView()
    }
}
