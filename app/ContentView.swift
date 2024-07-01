import SwiftUI

struct ContentView: View {
    @State private var login = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isAuthenticated = false
    @State private var currentUser: User? = nil
    @Namespace private var animationNamespace
    
    let validCredentials = [
        User(login: "1", password: "1", name: "Иван Иванов", birthdate: "1 января 1990", email: "ivanov@example.com"),
        User(login: "2", password: "2", name: "Петр Петров", birthdate: "2 февраля 1991", email: "petrov@example.com")
    ]
    
    var body: some View {
        VStack {
            if isAuthenticated {
                if let user = currentUser {
                    ProfileView(isAuthenticated: $isAuthenticated, user: user)
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut, value: isAuthenticated)
                }
            } else {
                VStack {
                    VStack {
                        TextField("Введите логин", text: $login)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(5.0)
                            .padding(.bottom, 20)
                        
                        SecureField("Введите пароль", text: $password)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(5.0)
                            .padding(.bottom, 20)
                        
                        Button(action: {
                            withAnimation {
                                authenticateUser(login: login, password: password)
                            }
                        }) {
                            Text("Готово")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 220, height: 60)
                                .background(Color.green)
                                .cornerRadius(15.0)
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Ошибка авторизации"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    
                    Spacer()
                    
                    Image("login_image")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "loginImage", in: animationNamespace)
                        .padding()
                }
                .padding()
                .transition(.move(edge: .top))
                .animation(.easeInOut, value: isAuthenticated)
            }
        }
    }
    
    func authenticateUser(login: String, password: String) {
        if let user = validCredentials.first(where: { $0.login == login && $0.password == password }) {
            currentUser = user
            isAuthenticated = true
        } else {
            alertMessage = "Неверный логин или пароль"
            showAlert = true
        }
    }
}

struct User {
    let login: String
    let password: String
    let name: String
    let birthdate: String
    let email: String
}
