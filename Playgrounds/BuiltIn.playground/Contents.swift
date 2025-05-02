import SwiftUI
import SbjGauge
import PlaygroundSupport

PlaygroundPage.current.setLiveView(
	HStack {
		VStack {
			Text("Standard").bold()
			SbjGauge.Standard.StandardView(.init(standard: 1.5))
			Text("Clock").bold()
			SbjGauge.Clock.ClockView()
		}
		.frame(width: 200)
		VStack {
			Text("Power").bold()
			SbjGauge.Power.PowerView()
			Text("Scale").bold()
			SbjGauge.Scale.ScaleView()
		}
		.frame(width: 200)
		VStack {
			Text("Up to 11").bold()
			SbjGauge.UpTo11.UpTo11View()
			//Text("Colors").bold()
			//SbjGauge.Colors.ColorsView()
			Spacer()
		}
		.frame(width: 200)
	}
)

