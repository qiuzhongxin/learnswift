import SwiftUI

struct ContentView: View {
    @GestureState private var isPressed = false
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            Image("cat")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 180, maxHeight: 180)
                .cornerRadius(16)
                .scaleEffect(isPressed ? 0.5 : 1.0)
                .gesture(LongPressGesture(minimumDuration: 0.1)
                    .updating($isPressed) { value, state, _ in
                        state = value
                    }
                )
        }
        
    }
}

#Preview {
    ContentView()
}
