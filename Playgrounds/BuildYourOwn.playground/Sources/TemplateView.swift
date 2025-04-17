import SwiftUI
import SbjGauge

public enum Template {
	public struct TemplateView: View {
		@State private var model: Model = .init(template: 0)
		@State private var increment: Double = 1.0

		let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()

		public init(_ model: Model = .init(template: 2.5)) {
			self.model = model
		}

		public var body: some View {
			ZStackSquare() { geom in
				SwirlView()
				Clock.SecondsHandView(geom: geom)
				Standard.NeedleSetView(geom: geom, model: model, clockwise: false) { geom, _, _ in
					Standard.TickSetView(geom: geom, model: model)
				}
			}
			.onReceive(timer) { input in
				if model[0] >= model.range.upperBound {
					increment = -1.0
				}
				else if model[0] <= model.range.lowerBound {
					increment = 1.0
				}
				model[0] += increment
			}
		}
	}
}

public extension Model {
	init(template value: Double) {
		self.init(value: value)
	}
}
