
import SwiftUI

struct LoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var content: () -> Content
    let cornerRadius = CGFloat(20)

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                self.content()
                    .disabled(isShowing)
                    .blur(radius: isShowing ? 3 : 0)
                VStack {
                    Text(loadingText)
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(cornerRadius)
                .opacity(isShowing ? 1 : 0)
            }
        }
    }
    
    private let loadingText = "Loading..."
}

struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView { return UIActivityIndicatorView(style: style) }
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) { isAnimating ? uiView.startAnimating() : uiView.stopAnimating() }
}
