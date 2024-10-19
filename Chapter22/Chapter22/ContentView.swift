import SwiftUI

struct ContentView: View {
    @State private var isPressed = false
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            Image("cat")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 180, maxHeight: 180)
//                .cornerRadius(isPressed ? 8 : 32)
                .scaleEffect(isPressed ? 0.9 : 1.0)
                .gesture(
                    TapGesture()
                        .onEnded({
                            self.isPressed.toggle()
                        })
                )
        }
        
    }
}

#Preview {
    ContentView()
}
