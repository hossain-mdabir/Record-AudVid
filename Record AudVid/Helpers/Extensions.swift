//
//  Extensions.swift
//  Record AudVid
//
//  Created by Md Abir Hossain on 14/3/23.
//

import Foundation
import SwiftUI
import ReplayKit


extension View {
    
    // MARK: - Start Recording
    func startRecording(enableMicrophone: Bool = false, completion: @escaping (Error?) -> ()) {
        let recorder = RPScreenRecorder.shared()
        
        // Microphone Option
        recorder.isMicrophoneEnabled = false
        
        // Starting Recording
        recorder.startRecording(handler: completion)
    }
    
    // MARK: - Stop Recording
    // will return the recorded Video  URL
    func stopRecording() async throws -> URL {
        
        // Fill will store temporary directory
        // Video name
        let name = UUID().uuidString + ".mov"
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(name)
        
        let recorder = RPScreenRecorder.shared()
        
        try await recorder.stopRecording(withOutput: url)
        
        return url
    }
    
    // MARK: - Cancel Recording
    // Optional
    func cancelRecording() {
        let recorder = RPScreenRecorder.shared()
        recorder.discardRecording {
            
        }
    }
    
    // MARK: - Share Sheet
    // Custom modifier
    func shareSheet(show: Binding<Bool>, items: [Any?]) -> some View {
        return self
            .sheet(isPresented: show) {
                
            } content: {
                
                // wraping the optionals
                let items = items.compactMap { item -> Any? in
                    
                    return item
                }
                
                if !items.isEmpty {
                    
                    ShareVideoSheet(items: items)
                }
            }
    }
}
