import SwiftUI
import SbjGauge

//TODO: improve
public enum Template {
	public struct TemplateView: View {
		@State private var model: StandardModel
		@State private var increment: Double = 1.0

		let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()

		public init(_ model: StandardModel = StandardModel(template: 2.5)) {
			_model = State(initialValue: model)
		}

		public var body: some View {
			Standard.GeometryView() { geom in
				SwirlView()
				Clock.SecondsHandView(geom: geom)
				Standard.RadialTickView(geom, model, model.ticks[0]) { notch in
					Standard.TickLineView(geom: geom)
					Standard.TickTextView(geom: geom,
						text: Int(notch.value).description,
						length: 0.2)
				}
				.radialRotate(model.needle())
			}
			.onReceive(timer) { input in
				if model.value >= model.range.upperBound {
					increment = -1.0
				}
				else if model.value <= model.range.lowerBound {
					increment = 1.0
				}
				model.value += increment
			}
		}
	}
}

public extension StandardModel {
	init(template value: Double) {
		self.init(standard: value)
	}
}
