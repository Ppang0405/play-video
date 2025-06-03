//
//  ContentView.swift
//  video-player
//
//  Created by Truong Huu Nguyen on 3/6/25.
//

import SwiftUI
import AVKit

//struct PlayerView: UIViewControllerRepresentable {
//  var player: AVPlayer
//  @Binding var isPlaying: Bool
//
//  func makeUIViewController(context: Context) -> AVPlayerViewController {
//    let controller = AVPlayerViewController()
//    controller.player = player
//    controller.allowsPictureInPicturePlayback = true // enables PiP
//    controller.videoGravity = .resizeAspectFill // This makes video fill container like "cover"
//    controller.showsPlaybackControls = false // Hide default controls
//    return controller
//  }
//
//  func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
//    // Update the controller if needed
//  }
//}
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    do {
//      try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
//      print("Playback OK")
//      try AVAudioSession.sharedInstance().setActive(true)
//      print("Session is Active")
//    } catch {
//      print(error)
//    }
//    return true
//  }
//}

struct ContentView: View {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var player = AVPlayer(url: URL(string: "https://archive.org/download/ksnn_compilation_master_food_in_space/ksnn_compilation_master_food_in_space_512kb.mp4")!)
    @State private var isPlaying = false
    
    var body: some View {
//        PlayerView()
        Text("iOSify me")
            .font(.title)
            .fontWeight(.bold)
        ZStack {
            
            VideoPlayer(player: player, videoOverlay: {
                ZStack(alignment: .bottomTrailing) {
                    Color.clear // This fills the entire overlay area
                    Button(action: {
                        if isPlaying {
                            player.pause()
                        } else {
                            player.play()
                        }
                        isPlaying.toggle()
                    }) {
                        ZStack {
                            Circle()
                                .foregroundColor(.white)
                            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                .tint(.black)
                        }
                        .frame(width: 48, height: 48)
                    }
                    .padding() // Add padding so button isn't flush with edges
                }
            })
                        .aspectRatio(contentMode: .fill) // This makes video fill container like "cover"
                        .frame(width: 240, height: 350, alignment: .center)
                        .clipped() // Clips overflow content
                        .rotationEffect(.degrees(350))
                        .overlay( // Add this overlay for the border
                            RoundedRectangle(cornerRadius: 10) // Match the corner radius of your background
                                .stroke(Color.black, lineWidth: 10) // Define border color and width
                                .rotationEffect(.degrees(350))
                        )
                        .onAppear {
                            addObserver() // 1
                            player.play() // Auto-play the video
                            isPlaying = true // Set the state to playing
                        }
                        .onDisappear {
                            removeObserver() // 2
                        }
        }
        .foregroundColor(.cyan)
        
        Button {
            // TODO: handle tap on bottom button
        } label: {
            Text("Let's go")
                .font(.largeTitle)
                .padding(4)
                .foregroundColor(.white)
                .background(.blue)
        }
         
            
        
        
    }
    
    func addObserver() {
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { notif in // 3
                player.seek(to: .zero) // 4
                player.play() // 5
            }
        }
        
    func removeObserver() {
        NotificationCenter.default.removeObserver(self,  // 6
                                                  name: .AVPlayerItemDidPlayToEndTime,
                                                  object: nil)
    }
}

//#Preview {
//    ContentView()
//}
