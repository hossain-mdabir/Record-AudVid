//
//  ShareVideoSheet.swift
//  Record AudVid
//
//  Created by Md Abir Hossain on 15/3/23.
//

import SwiftUI

struct ShareVideoSheet: UIViewControllerRepresentable {
    
    var items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let view = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return view
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}
