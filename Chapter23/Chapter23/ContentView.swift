//
//  ContentView.swift
//  Chapter23
//
//  Created by Zhongxin qiu on 2024/10/20.
//

import SwiftUI

struct ContentView: View {
    @State var currentTime: String = "00:00:00"
    @State var currenDate: String = "2024年10月19"
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(alignment: .center){
                
                timeView
                dateView
            }
            //展示时间
            .onAppear{
                currentTime = getCurrentTime("HH:mm:ss")
                currenDate = getCurrentTime("yyyy年MM月dd日")
            }
            //监听变化
            .onReceive(timer) { _ in
                currentTime = getCurrentTime("HH:mm:ss")
                currenDate = getCurrentTime("yyyy年MM月dd日")
            }
            .padding(30)
        }
    }
    private var timeView: some View {
                Text(currentTime)
                    .font(.custom("BebasNeue", size: 120)) // 根据方向调整字体大小
                    .bold()
                    .foregroundColor(.white)
            
        
    }
    private var dateView: some View {
        Text(currenDate)
            .font(.system(size: 28, design: .rounded))
            .foregroundColor(.gray)
            .bold()
            
    }
    
    func getCurrentTime(_ time:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = time
        return formatter.string(from: Date())
    }

}

#Preview {
    ContentView()
}

