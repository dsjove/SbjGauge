import SwiftUI
import SbjGauge
import PlaygroundSupport

PlaygroundPage.current.setLiveView(
	VStack {
		Text("The following gauges are built in.").multilineTextAlignment(.center)
		Spacer()
		Text("Standard").bold()
		SbjGauge.Standard.StandardView(.init(standard: 1.5))
		Text("Clock").bold()
		SbjGauge.Clock.ClockView()
		Text("Power").bold()
		SbjGauge.Power.PowerView()
		Text("Up to 11").bold()
		SbjGauge.UpTo11.UpTo11View()
	}
	.frame(width: 300)
)

