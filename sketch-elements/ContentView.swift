import SwiftUI

struct ContentView: View {
    @State private var balloons: [Balloon] = []

    var body: some View {
        ZStack {
            LinearGradient(colors: [.pink, .purple],
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()

            VStack {
                Text("Happy Birthday Mom 💖")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.top, 60)

                Spacer()
            }

            ForEach(balloons) { balloon in
                Text(balloon.emoji)
                    .font(.system(size: 40))
                    .position(balloon.position)
            }
        }
        .onAppear {
            spawnBalloons()
        }
    }

    func spawnBalloons() {
        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { _ in
            let x = CGFloat.random(in: 50...350)
            let emojis = ["🎈", "🎉", "💖"]
            let newBalloon = Balloon(
                id: UUID(),
                position: CGPoint(x: x, y: 800),
                emoji: emojis.randomElement()!
            )
            balloons.append(newBalloon)

            withAnimation(.linear(duration: 5)) {
                if let index = balloons.firstIndex(where: { $0.id == newBalloon.id }) {
                    balloons[index].position.y = -100
                }
            }
        }
    }
}

struct Balloon: Identifiable {
    let id: UUID
    var position: CGPoint
    var emoji: String
}
