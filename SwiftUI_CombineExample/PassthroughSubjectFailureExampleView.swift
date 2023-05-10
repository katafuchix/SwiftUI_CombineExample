//
//  PassthroughSubjectFailureExampleView.swift
//  SwiftUI_CombineExample
//
//  Created by cano on 2023/05/10.
//

import SwiftUI
import Combine

struct PassthroughSubjectFailureExampleView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                enum CustomError: Error {
                    case someError
                }

                let subject = PassthroughSubject<String, CustomError>()

                let subscription = subject.sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print("Received error: \(error)")
                    case .finished:
                        print("Completed successfully")
                    }
                }, receiveValue: { value in
                    print("Received value: \(value)")
                })

                subject.send("Hello, world!")
                subject.send("How are you?")
                subject.send(completion: .failure(.someError))
                
                //subscription.cancel()
                // PassthroughSubjectは手動でキャンセルする必要がないためです。PassthroughSubjectは自動的に完了するか、エラーを送信するか、または購読者がキャンセルするまで出力を送信し続けます。
                

                // Complete the subject
                subject.send(completion: .finished)
                
                /*
                もし、PassthroughSubject がキャンセルも完了もエラーも通知しない場合、その PassthroughSubject は購読者によるキャンセルや完了通知が無い限り、メモリ上に残り続けます。

                ただし、通常の使用法では、キャンセルや完了、エラー通知を行うことが期待されており、これらが実行されることによってメモリ上から解放されることが想定されています。したがって、PassthroughSubject がキャンセルや完了、エラー通知を行うことが推奨されます。
                 */
                
            }
    }
}

struct PassthroughSubjectFailureExampleView_Previews: PreviewProvider {
    static var previews: some View {
        PassthroughSubjectFailureExampleView()
    }
}
