import SwiftUI
import SbjGauge
import PlaygroundSupport

PlaygroundPage.current.setLiveView(
	VStack {
		Text("All standard gauge components are designed without runtime state; i.e @State. Building a custom gauge with live or interactive state is easy.")
		.multilineTextAlignment(.center)
		Spacer()
		Text("Animated Clock").bold()
		SbjGauge.Clock.AnimatedView()
		Text("Knob with Gesture (try it)").bold()
		SbjGauge.UpTo11.InteractiveView()
		Text("Long Press to add weight (try it)").bold()
		SbjGauge.Scale.InteractiveView()
	}
	.frame(width: 300)
)

