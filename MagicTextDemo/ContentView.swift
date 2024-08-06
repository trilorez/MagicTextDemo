import SwiftUI
import MagicText

struct ContentView: View {

    @State private var shouldRefresh = true
    @State private var state: MagicTextState = .loading

    var body: some View {
        MagicText(shouldRefresh: $shouldRefresh) { state in
            self.state = state
        }
        .overlay {
            switch state {
            case .loading:
                ProgressView()
            case .loaded:
                EmptyView()
            case .failed(let error):
                VStack(spacing: 40) {
                    Text("Failed to load: \(error.localizedDescription)")
                        .multilineTextAlignment(.center)

                    Button("Retry", systemImage: "arrow.clockwise") {
                        shouldRefresh = true
                    }
                }
                .padding()
            }
        }
    }

}

#Preview {
    ContentView()
}
