import SwiftUI

struct FutureGameView: View {
    
    let game: Game
    let homeString: String
    let awayString: String
    let status: String
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .shadow(radius: 5)
                .foregroundStyle(ColorManager.shared.getGameCardColor(colorScheme: colorScheme))
            HStack {
                HStack {
                    VStack {
                        Circle()
                        Text(game.homeTeamName)
                            .fontWeight(.bold)
                            .fontWidth(.expanded)
                    }
                    Divider()
                    VStack {
                        Circle()
                        Text(game.awayTeamName)
                            .fontWeight(.bold)
                            .fontWidth(.expanded)
                    }
                }
                VStack(alignment: .leading) {
                    HStack {
                        Text("<Day> <Mo>/<Da>")
                            .font(.caption2)
                        Spacer()
                        Text("<Time>")
                            .font(.caption2)
                    }
                    Divider()
                    Text(game.status)
                        .font(.caption2)
                    Text("<Venue>")
                        .font(.caption2)
                    Spacer()
                    HStack {
                        Button {} label: {
                            Text("<Radio>")
                                .font(.caption2)
                        }
                            .buttonStyle(.bordered)
                        Spacer()
                        Button {} label: {
                            Image(systemName: "ellipsis")
                        }
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .padding()
        }
        .padding()
    }
}

#Preview {
    Group {
        FutureGameView(game: Game.blank, homeString: "<Home>", awayString: "<Away>", status: "<Status>")
            .previewLayout(.sizeThatFits)
            .frame(height: 60)
    }
}
