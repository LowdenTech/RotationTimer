//
//  ContentView.swift
//  RotationTimer Watch App
//
//  Created by Mike on 2025-11-16.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    let session: Session = Session()
    let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    
    @State var running: Bool = false
    @State var time: Int = 60
    @State var clockTime: Int = 60
    
    var body: some View {
        if running {
            timerView()
        } else {
            prepView()
        }
    }
    
    func timerView() -> some View {
        VStack(spacing: 20) {
            ZStack {
                Circle()
                    .fill(Color.clear)
                    .overlay(
                        Circle().trim(from: 0, to: CGFloat(clockTime) / CGFloat(time))
                            .stroke(
                                style: StrokeStyle(
                                    lineWidth: 5,
                                    lineCap: .round,
                                    lineJoin:.round
                                )
                        )
                    )
                    .rotationEffect(Angle.degrees(270))
                Text(String(format: "%02d", clockTime.toMins()) + ":" + String(format: "%02d", clockTime.toSecs()))
            }
            Button("Stop") {
                clockTime = time
                session.stop()
                running = false
            }
        }
        .onReceive(timer) { _ in
            if running {
                clockTime -= 1
                if clockTime <= 0 {
                    WKInterfaceDevice.current().play(.notification)
                    clockTime = time
                }
            }
        }
    }
    
    func prepView() -> some View {
        VStack {
            HStack {
                VStack {
                    Button("+") { time += 60 }
                        .disabled(time.toMins() == 59)
                    Text(String(format: "%02d", time.toMins()))
                    Button("-") { time -= 60 }
                        .disabled(time.toMins() == 0)
                }
                Text(":")
                VStack {
                    Button("+") { time += 1 }
                        .disabled(time.toSecs() == 59)
                    Text(String(format: "%02d", time.toSecs()))
                    Button("-") { time -= 1 }
                        .disabled(time.toSecs() == 0)
                }
            }
            Button("Start") {
                clockTime = time
                session.start()
                running = true
            }
            .disabled(time == 0)
        }
    }
    
}

extension Int {
    
    func toMins() -> Int {
        return self / 60
    }
    
    func toSecs() -> Int {
        let mins = self.toMins()
        return self - (mins * 60)
    }
    
}

#Preview {
    ContentView()
        .font(.system(.body, design: .monospaced))
}
