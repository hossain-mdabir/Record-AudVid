//
//  ShareFileSheet.swift
//  Recorder App
//
//  Created by Md Abir Hossain on 11/3/23.
//

import SwiftUI


// Share Sheet
struct ShareAudioSheet: UIViewControllerRepresentable {
    
    // Data Need to share
    var items: [Any]
    
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
        
    }
}


