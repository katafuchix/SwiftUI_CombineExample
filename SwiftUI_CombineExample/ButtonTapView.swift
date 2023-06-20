//
//  ButtonTapView.swift
//  SwiftUI_CombineExample
//
//  Created by cano on 2023/06/20.
//

import SwiftUI
import Combine

/*
class ButtonTapCounter {
    private var tapCount = 0
    private let subject = PassthroughSubject<Int, Never>()
    
    var tapCountPublisher: AnyPublisher<Int, Never> {
        return subject.eraseToAnyPublisher()
    }
    
    func buttonTapped() {
        tapCount += 1
        subject.send(tapCount)
    }
}
*/
class ButtonTapCounter: ObservableObject {
    @Published var tapCount = 0
    
    func buttonTapped() {
        tapCount += 1
    }
}

struct ButtonTapView: View {
    
    @StateObject private var buttonTapCounter = ButtonTapCounter()
    @State private var tapCount = 0
    @State private var cancellables = Set<AnyCancellable>()
        

    var body: some View {
        
        VStack {
            Text("Button Tapped Count: \(tapCount)")
                .padding()
            
            Button("Tap Me") {
                buttonTapCounter.buttonTapped()
            }
            .padding()
            
        }
        .onReceive(buttonTapCounter.$tapCount) { count in
            tapCount = count
        }
        /*.onAppear {
            buttonTapCounter.$tapCount
                .sink { count in
                    print("Button tapped \(count) times")
                }
                .store(in: &cancellables)
        }*/
        
    }
}

struct ButtonTapView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonTapView()
    }
}
