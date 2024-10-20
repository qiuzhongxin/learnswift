//
//  ContentView.swift
//  Chapter23
//
//  Created by Zhongxin qiu on 2024/10/20.
//

import SwiftUI

struct ContentView: View {
    @State var currentTime: String = ""
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                Text(currentTime)
                    .font(.custom("BebasNeue", size: geometry.size.width > geometry.size.height ? 220 : 150)) // 根据方向调整字体大小
                    .bold()
                    .foregroundColor(.white)
                    .onReceive(timer) { _ in
                        currentTime = getCurrentTime()
                    }
            }
        }
    }
    
    func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss" // 这里也可以根据需要调整为 "HH:mm"
        return formatter.string(from: Date())
    }
}

#Preview {
    ContentView()
}
