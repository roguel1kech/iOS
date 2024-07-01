import SwiftUI

struct ProfileView: View {
    @Binding var isAuthenticated: Bool
    let user: User
    @Namespace private var animationNamespace
    
    var body: some View {
        VStack {
            Image("user_avatar") // Используемое изображение из Assets.xcassets
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .matchedGeometryEffect(id: "loginImage", in: animationNamespace)
            
            Text(user.name)
                .font(.title)
                .padding(.top, 20)
            
            Text("Дата рождения: \(user.birthdate)")
                .padding(.top, 5)
            
            Text("Email: \(user.email)")
                .padding(.top, 5)
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                    isAuthenticated = false
                }
            }) {
                Text("Выйти")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.red)
                    .cornerRadius(15.0)
            }
        }
        .padding()
    }
}
