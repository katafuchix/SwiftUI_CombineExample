//
//  PublisherAndSubjectView.swift
//  SwiftUI_CombineExample
//
//  Created by cano on 2023/05/10.
//

import SwiftUI
import Combine

struct PublisherAndSubjectView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                // Publisherのサンプル
                let publisher = Just("Hello, World!")

                // Subscriberを定義する
                let subscriber = Subscribers.Sink<String, Never>(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("Subscription finished")
                    }
                }, receiveValue: { value in
                    print("Received value: \(value)")
                })

                // Publisherに購読者を追加する
                let cancellable = publisher.sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("Subscription finished")
                    }
                }, receiveValue: { value in
                    print("Received value: \(value)")
                })

                // PassthroughSubjectのサンプル
                let subject = PassthroughSubject<String, Never>()

                // Subjectに購読者を追加する
                let subjectCancellable: () = subject.subscribe(subscriber)

                // 値を送信する
                subject.send("How")
                subject.send("are you?")

                // Combineの購読をキャンセルする
                _ = cancellable
                _ = subjectCancellable
                
                // _ = cancellable と _ = subjectCancellable は、実際には Combine の購読をキャンセルするコードではありません。これらの行は、Xcode の警告を消すために、宣言した変数を使わなかったことを示すために追加されているものです。
                
                //cancellable.cancel() // ここはエラーにならない
                //subjectCancellable.cancel()

         
            }
    }
}

struct PublisherAndSubjectView_Previews: PreviewProvider {
    static var previews: some View {
        PublisherAndSubjectView()
    }
}
