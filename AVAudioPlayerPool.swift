// An array of all players stored in the pool; not accessible
// outside this file
import AVFoundation

private var players : [AVAudioPlayer] = []

class AVAudioPlayerPool: NSObject {
  
  // Given the URL of a sound file, either create or reuse an audio player
  class func playerWithURL(url : NSURL) -> AVAudioPlayer? {
    
    // Try to find a player that can be reused and is not playing
    let availablePlayers = players.filter { (player) -> Bool in
      return player.playing == false && player.url == url
    }
    
    // If we found one, return it
    if let playerToUse = availablePlayers.first {
      print("Reusing player for \(url.lastPathComponent)")
      return playerToUse
    }
    
    // Didn't find one? Create a new one
    let newPlayer = try? AVAudioPlayer(contentsOfURL: url)
      
    print("Creating new player for url \(url.lastPathComponent)")
    players.append(newPlayer!)
    return newPlayer
  }
  
}
