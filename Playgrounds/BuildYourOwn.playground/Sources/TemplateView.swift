import SwiftUI
import SbjGauge

public enum Template {
	public struct TemplateView: View {
		let model: Model

		public init(_ model: Model = .init(template: 0)) {
			self.model = model
		}

		public var body: some View {
			ZStackSquare() { geom in
				SwirlView()
				Standard.TickSetView(geom: geom, model: model)
			}
		}
	}
}

public extension Model {
	init(template value: Double) {
		self.init(value: value)
	}
}
