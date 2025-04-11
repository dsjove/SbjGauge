//
//  Standard.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/3/25.
//

import SwiftUI

public extension Gauge {
	enum Standard {
	}

	@ViewBuilder
	static func standard(_ model: Model) -> some View {
		ZStackSquare() { geom in
			Standard.BackgroundView(geom: geom)
			Standard.TickSetView(geom: geom, model: model)
			Standard.IndicatorSetView(geom: geom, model: model)
			Standard.SpanSetView(geom: geom, model: model)
			Standard.NeedleSetView(geom: geom, model: model)
			Standard.RimView(geom: geom)
		}
	}
}

#Preview {
	Gauge.standard(.init(value: 1.5))
}
