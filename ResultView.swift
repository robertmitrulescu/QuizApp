import SwiftUI

struct ResultView: View {
    let score: Int
    let total: Int
    let onRestart: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Text("Rezultat")
                .font(.title2.bold())

            Text("\(score) / \(total)")
                .font(.largeTitle.weight(.heavy))

            Text(feedback)
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.top, 4)

            Button("Reia testul") {
                onRestart()
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 12)
        }
        .padding()
    }

    private var feedback: String {
        let pct = Double(score) / Double(total)
        switch pct {
        case 0.9...: return "Excelent! 👏"
        case 0.75..<0.9: return "Foarte bine! 💪"
        case 0.5..<0.75: return "Bine – mai e puțin! 🙂
"
        default: return "Continuă antrenamentul! 🚀"
        }
    }
}
