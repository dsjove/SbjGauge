import SwiftUI
import SbjGauge
import PlaygroundSupport

PlaygroundPage.current.setLiveView(
	VStack {
		Text("All built in gauge components are designed without runtime state; i.e @State. Building a custom gauge with live or interactive state is easy.")
		.multilineTextAlignment(.center)
		Spacer()
		Text("Animated Clock").bold()
		SbjGauge.Clock.AnimatedView()
		Text("Knob with Gesture (try it)").bold()
		SbjGauge.UpTo11.InteractiveView()
	}
	.frame(width: 300)
)

