//
//  ContentView.swift
//  Recorder App
//
//  Created by Md Abir Hossain on 27/2/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var animation: Bool = true
    @State var isRecording: Bool = false
    @State var url: URL?
    @State var isShareScreenRecord: Bool = false
    
    var body: some View {
        
//            .preferredColorScheme(.dark)
        
        ZStack(alignment: .bottom) {
            
//            if animation {
                
                SoundRecorderView()
//            } else {
//
//                ScreenRecorderView()
//            }
            
            HStack(spacing: 0) {
                
            }
            .font(.title3.weight(.semibold))
            .foregroundColor(animation ? Color.green.opacity(0.8) : Color.gray)
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(animation ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
            .cornerRadius(5)
            
            HStack(spacing: 80) {
                
                Button(action: {
                    
                    withAnimation { self.animation = true }
                }, label: {
                    
                    HStack {
                        
                        Circle()
                            .foregroundColor(Color.red.opacity(0.8))
                            .frame(width: 30, height: 30)
                        
                        Text("Record")
                            .foregroundColor(animation ? Color.green.opacity(0.8) : Color.gray)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(animation ? Color.green.opacity(0.3) : Color.gray.opacity(0.3))
                })
                .cornerRadius(animation ? 30 : 5)
                .offset(y: animation ? -25 : 0)
                
                
                Button(action: {
                    
                    withAnimation { self.animation = false }
                }, label: {
                    
                    HStack {
                        
                        ZStack {
                            
                            Circle()
                                .foregroundColor(Color.red)
                            .frame(width: 30, height: 30)
                            
                            Rectangle()
                                .foregroundColor(Color.white)
                                .frame(width: 10, height: 10)
                        }
                        
                        Text("Capture")
                            .foregroundColor(!animation ? Color.red.opacity(0.8) : Color.gray)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(!animation ? Color.red.opacity(0.3) : Color.gray.opacity(0.3))
                })
                .cornerRadius(!animation ? 30 : 5)
                .offset(y: !animation ? -25 : 0)
            }
        }
        .padding(.bottom, 20)
        .padding(.horizontal, 20)
        
        .overlay(alignment: .bottomTrailing) {
            
            // MARK: - Recording Button
            Button(action: {
                
                if isRecording {
                    
                    // Stop Recording
                    Task {
                        
                        do {
                            
                            self.url = try await stopRecording()
                            isRecording = false
                            isShareScreenRecord.toggle()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                } else {
                    
                    startRecording { error in
                        if let error = error {
                            
                            print(error.localizedDescription)
                            return
                        }
                        
                        // On Success
                        withAnimation { self.isRecording.toggle() }
                     }
                }
            }, label: {
                
                Image(systemName: isRecording ? "record.circle.fill" : "record.circle")
                    .font(.largeTitle)
                    .foregroundColor(isRecording ? .red : .primary)
            })
            .padding(.bottom, 150)
        }
        .shareSheet(show: $isShareScreenRecord, items: [url])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
