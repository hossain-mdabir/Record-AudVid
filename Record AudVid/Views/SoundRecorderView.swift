//
//  Home.swift
//  Recorder App
//
//  Created by Md Abir Hossain on 27/2/23.
//

import SwiftUI
import AVKit

struct SoundRecorderView: View {
    
    @State var record = false
    
    // Recording instance
    @State var session: AVAudioSession!
    @State var recorder: AVAudioRecorder!
    @State var isAlert = false
    @State var isShareSheet = false
    
    // Fetch Audio files
    @State var audios: [URL] = []
    @State var audItems: [Any] = []
    @State var delAudioPosition: URL?
    @State var delAudio: URL?
    
    var body: some View {
        
        VStack  {
            
            VStack {
                
                ForEach(self.audios, id: \.self) { audio in
                    
                    Button(action: {
                        
                        self.audItems.removeAll()
                        self.audItems.append(audio)
                        self.isShareSheet.toggle()
                    }, label: {
                        
                        HStack {
                            Text(audio.relativeString)
                                .padding(.leading)
                                .foregroundColor(Color.primary)
                                .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                            .background(Color.gray.opacity(0.5))
                            
                            Spacer()
                            
                            Button(action: {
                                
//                                delAudio
                                
                                deleteAudio()
                                delAudioPosition = audio
                            }, label: {
                                Image(systemName: "trash.fill")
                                    .foregroundColor(Color.primary)
                            })
                        }
                    })
                }
                
                Spacer()
                
                Button(action: {
                    
                    // Recording audio
                    
                    
                    // Initialization
                    
                    
                    // Store recorded file
                    
                    do {
                        
                        if self.record {
                            
                            // Already started recording. It needs to stop and save now
                            self.recorder.stop()
                            self.record.toggle()
                            self.getAudios() // updating data
                            
                            return
                        }
                        
                        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                        
                        // Same file name
                        // Updating name based on file count
                        let fileName = url.appendingPathComponent("myRcd\(self.audios.count + 1).m4a")
                        
                        let settings = [
                            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                            AVSampleRateKey: 12000,
                            AVNumberOfChannelsKey: 1,
                            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                        ]
                        
                        
                        self.recorder = try AVAudioRecorder(url: fileName, settings: settings)
                        
                        self.recorder.record()
                        self.record.toggle()
                        
                        
                    } catch {
                        
                        print(error.localizedDescription)
                    }
                    
                }) {
                    
                    ZStack {
                        
                        Circle()
                            .fill(Color.red)
                            .frame(width: 70, height: 70)
                        
                        if self.record {
                            
                            Circle()
                                .stroke(Color.primary, lineWidth: 6)
                                .frame(width: 85, height: 85)
                        }
                    }
                }
                .padding(.vertical, 25)
            }
            .padding(.top, 1)
            .navigationTitle("Sound Recorder")
        }
        .alert(isPresented: self.$isAlert, content: {
            
            Alert(title: Text("Error"), message: Text("Enable access"))
        })
        
        .sheet(isPresented: $isShareSheet, content: {
            
            ShareAudioSheet(items: audItems)
        })
        
        .onAppear {
            
            do {
                
                // Initialization
                self.session = AVAudioSession.sharedInstance()
                try self.session.setCategory(.playAndRecord)
                
                self.session.requestRecordPermission { (status) in
                    
                    if !status {
                        
                        // Error Message
                        self.isAlert.toggle()
                    } else {
                        
                        // If permission granted fetch all recording data
                        self.getAudios()
                    }
                }
                
            } catch {
                
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Get Audio files
    func getAudios() {
        
        do {
            
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            // Fetch datas from document directory
            let result = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)
            
            self.audios.removeAll()
            
            for audio in result {
                
                self.audios.append(audio)
            }
        } catch {
            
            print(error.localizedDescription)
        }
    }
    
    
        // MARK: - Delete Audio file
    func deleteAudio() {
        
        do {
            
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
                // Fetch datas from document directory
            var result = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)
            
            self.audios.removeAll()
            
//            try FileManager.default.removeItem(at: )
        } catch {
            
            print(error.localizedDescription)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        SoundRecorderView()
    }
}
