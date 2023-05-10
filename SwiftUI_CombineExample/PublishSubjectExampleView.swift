//
//  PublishSubjectExampleView.swift
//  SwiftUI_CombineExample
//
//  Created by cano on 2023/05/10.
//

import SwiftUI
import Combine

struct PublishSubjectExampleView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                /*
                let subject = PublishSubject<String>()

                let cancellable = subject.sink { value in
                    print("Received value: \(value)")
                }

                subject.send("Hello")
                subject.send("World")
                subject.send("!")

                cancellable.cancel()
                */
                let subject = CurrentValueSubject<String, Never>("Hello, World!")

                // sink メソッドは、購読を表す Cancellable オブジェクトを返します。
                let cancellable = subject.sink { value in
                    print("Received value: \(value)")
                }

                subject.send("Goodbye, World!")
                subject.send("Hello again, World!")

                cancellable.cancel()
                
                //このコードでは、sink メソッドが返す cancellable オブジェクトを let 宣言して保持しています。後で、cancel メソッドを使って Combine の購読をキャンセルすることができます。
                
            }
    }
}

struct PublishSubjectExampleView_Previews: PreviewProvider {
    static var previews: some View {
        PublishSubjectExampleView()
    }
}
