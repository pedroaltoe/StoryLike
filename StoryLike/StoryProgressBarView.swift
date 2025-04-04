import SwiftUI

struct StoryProgressBarView: View {

    var progress: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: 3)
                    .opacity(0.3)
                    .foregroundColor(.white)
                Rectangle()
                    .frame(width: geometry.size.width * progress, height: 3)
                    .foregroundColor(.white)
                    .animation(.linear, value: progress)
            }
        }
    }
}
