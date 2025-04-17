import SwiftUI
import SbjGauge
import PlaygroundSupport

PlaygroundPage.current.setLiveView(
	VStack {
		Text("Modify Template View Source").multilineTextAlignment(.center)
		Spacer()
		Template.TemplateView()
	}
	.frame(width: 300)
)
