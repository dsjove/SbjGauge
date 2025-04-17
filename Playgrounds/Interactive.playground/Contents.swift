import SwiftUI
import PlaygroundSupport
import SbjGauge

//struct RandomView : View {
//	@State private var model: Model = .init(standard: 0)
//
//	public var body: some View {
//		SbjGauge.ZStackSquare() { geom in
//			SbjGauge.Standard.BackgroundView(geom: geom)
//			SbjGauge.Standard.TickSetView(geom: geom, model: model)
//			SbjGauge.Standard.SpanSetView(geom: geom, model: model)
//			SbjGauge.Standard.IndicatorSetView(geom: geom, model: model)
//			SbjGauge.Standard.NeedleSetView(geom: geom, model: model)
//			SbjGauge.Standard.RimView(geom: geom)
//		}
//	}
//}

PlaygroundPage.current.setLiveView(
	VStack {
		Text("All built in gauge components are designed without runtime state; i.e @State. But is easy build out a custom gauge with live or interactive state.")
		.multilineTextAlignment(.center)
		Spacer()
		Text("Animated Clock").bold()
		SbjGauge.Clock.AnimatedView()
		Text("Knob with Gesture (try it)").bold()
		SbjGauge.UpTo11.InteractiveView()
//		Text("Random (Code in Playground)").bold()
//		RandomView()
	}
	.frame(width: 300)
)

