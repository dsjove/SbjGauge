import SwiftUI
import SbjGauge

public enum Template {
	public struct TemplateView: View {
		@State private var model: FullModel
		@State private var increment: Double = 1.0

		let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()

		public init(_ model: FullModel = FullModel(template: 2.5)) {
			_model = State(initialValue: model)
		}

		public var body: some View {
			ZStackSquare() { geom in
				SwirlView()
				Clock.SecondsHandView(geom: geom)
				Standard.NeedleSetView(geom: geom, model: model, clockwise: false) { geom, _, _ in
					Standard.RadialTickView(geom, model, model.ticks[0]) { _ in
						Standard.TickView(geom: geom)
					}
					Standard.RadialTickView(geom, model, model.ticks[1]) { notch in
						Standard.TickView(
							geom: geom,
							style: .text(Int(notch.value).description),
							offset: 0.1,
							length: 0.2)
					}
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

public extension FullModel {
	init(template value: Double) {
		self.init(standard: value)
	}
}
