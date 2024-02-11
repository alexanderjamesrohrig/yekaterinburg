import SwiftUI

struct GameStatusView: View {
    
    let game: Game
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .shadow(radius: 5)
//                .foregroundStyle(Color(UIColor.systemBackground))
            VStack {
                HStack {
                    Text("\(game.homeTeamName)")
                        .font(.title)
                        .fontWeight(.bold)
                        .fontWidth(.compressed)
                    Spacer()
                    VStack {
                        Text(game.status)
                            .font(.caption)
                        Button {} label: {
                            Text("Live on \(game.televisionOptions)")
                                .font(.caption)
                        }
                    }
                    .buttonStyle(.bordered)
                    Spacer()
                    Text("\(game.awayTeamName)")
                        .font(.title)
                        .fontWeight(.bold)
                        .fontWidth(.compressed)
                }
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    GameStatusView(game: Game.blank)
        .previewLayout(.sizeThatFits)
        .frame(height: 60)
}
