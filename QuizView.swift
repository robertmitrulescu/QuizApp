import SwiftUI

struct QuizView: View {
    @ObservedObject var session: QuizSession

    var body: some View {
        VStack(spacing: 16) {
            // Progres
            Text(session.progressText)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Întrebare
            Text(session.currentQuestion.prompt)
                .font(.title3.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)

            // Opțiuni
            VStack(spacing: 10) {
                ForEach(session.currentQuestion.options.indices, id: \.self) { idx in
                    answerButton(for: idx)
                }
            }

            Spacer()

            // Butoane Next / Restart / Rezultate
            if session.hasAnswered {
                Button {
                    session.goNext()
                } label: {
                    Text(session.isFinished ? "Vezi rezultate" : "Următoarea întrebare")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 8)
            }

        }
        .padding()
        .navigationTitle(session.quiz.chapter)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $session.isFinished, onDismiss: { session.restart() }) {
            ResultView(score: session.score, total: session.quiz.questions.count) {
                // Reîncepem testul
                session.restart()
            }
            .presentationDetents([.fraction(0.4), .medium])
        }
    }

    @ViewBuilder
    private func answerButton(for idx: Int) -> some View {
        let option = session.currentQuestion.options[idx]
        let isSelected = session.selectedIndex == idx
        let isCorrect = idx == session.currentQuestion.correctIndex

        Button {
            session.selectAnswer(idx)
        } label: {
            HStack(alignment: .top, spacing: 12) {
                Text(bullet(for: idx))
                    .font(.headline)
                Text(option)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .background(backgroundColor(isSelected: isSelected, isCorrect: isCorrect))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(borderColor(isSelected: isSelected, isCorrect: isCorrect), lineWidth: 1)
        )
        .disabled(session.hasAnswered) // nu mai lăsăm selecție după răspuns
    }

    private func bullet(for idx: Int) -> String {
        // litere pentru variante: a, b, c, d...
        let letters = Array("abcdefghijklmnopqrstuvwxyz")
        let i = idx < letters.count ? idx : 0
        return "\(letters[i])."
    }

    private func backgroundColor(isSelected: Bool, isCorrect: Bool) -> Color {
        guard session.hasAnswered else { return Color(.systemBackground) }
        if isCorrect { return Color.green.opacity(0.15) }
        if isSelected { return Color.red.opacity(0.12) }
        return Color(.systemBackground)
    }

    private func borderColor(isSelected: Bool, isCorrect: Bool) -> Color {
        guard session.hasAnswered else { return Color.secondary.opacity(0.3) }
        if isCorrect { return .green }
        if isSelected { return .red }
        return Color.secondary.opacity(0.3)
    }
}
