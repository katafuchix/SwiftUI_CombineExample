//
//  ValidationExampleView.swift
//  SwiftUI_CombineExample
//
//  Created by cano on 2023/06/20.
//

import SwiftUI
import Combine

class FormValidator: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    
    @Published var nameValidation: String?
    @Published var emailValidation: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    /*
    init() {
        // 初期化時にエラーメッセージをクリアする
        nameValidation = nil
        emailValidation = nil
        
        // 名前のバリデーション
        $name
            .dropFirst() // 初回の値変更を無視する
            .sink { [weak self] name in
                guard let self = self else { return }
                if name.isEmpty {
                    self.nameValidation = "名前を入力してください"
                } else {
                    self.nameValidation = nil
                }
            }
            .store(in: &cancellables)
        
        // メールアドレスのバリデーション
        $email
            .dropFirst() // 初回の値変更を無視する
            .sink { [weak self] email in
                guard let self = self else { return }
                if email.isEmpty {
                    self.emailValidation = "メールアドレスを入力してください"
                } else if !self.isValidEmail(email) {
                    self.emailValidation = "有効なメールアドレスを入力してください"
                } else {
                    self.emailValidation = nil
                }
            }
            .store(in: &cancellables)
    }
    */
    func validate() {
        nameValidation = validateName(name)
        emailValidation = validateEmail(email)
    }
    
    private func validateName(_ name: String) -> String? {
        if name.isEmpty {
            return "名前を入力してください"
        }
        return nil
    }
    
    private func validateEmail(_ email: String) -> String? {
        if email.isEmpty {
            return "メールアドレスを入力してください"
        }
        if !self.isValidEmail(email) {
            return "有効なメールアドレスを入力してください"
        }
        return nil
    }
    
    
    func isValidEmail(_ email: String) -> Bool {
        // メールアドレスのバリデーションロジックを実装する
        // ここでは単純な形式チェックのみを行っています
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

struct ValidationExampleView: View {
    @StateObject private var formValidator = FormValidator()
    
    var body: some View {
        VStack {
            TextField("名前", text: $formValidator.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if let nameValidation = formValidator.nameValidation {
                Text(nameValidation)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            TextField("メールアドレス", text: $formValidator.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if let emailValidation = formValidator.emailValidation {
                Text(emailValidation)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Button("Submit") {
                /*
                // フォームがバリデーションを通過したかどうかをチェック
                if formValidator.name.isEmpty || formValidator.email.isEmpty ||
                    formValidator.nameValidation != nil || formValidator.emailValidation != nil {
                    // バリデーションエラーがある場合は処理を中断するなどのロジックを追加する
                    return
                }
                
                // フォームがバリデーションを通過した場合の処理を記述
                // ...
                */
                formValidator.validate()
                
                // フォームがバリデーションを通過した場合の処理を記述
                if formValidator.nameValidation == nil && formValidator.emailValidation == nil {
                                    //submit()
                                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()

    }
}

struct ValidationExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ValidationExampleView()
    }
}
