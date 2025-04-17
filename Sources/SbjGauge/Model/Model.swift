//
//  Model.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

//TODO: Continue protocol refactoring

public struct Model: Values, Radial, Ticking, Spanning {
	public init(value: Double, range: ClosedRange<Double> = 0 ... 10) {
		self.values = [range.clamp(value)]
		self.range = range
	}

	public var range: ClosedRange<Double>
	public var values: [Double]
	public var angles: ClosedRange<Angle> = .degrees(0) ... .degrees(360)
	public var ticks: [Tick] = [.init(), .init()]
	public var spans: [ClosedRange<Value>] = []
	public var tickEnds: TickEnds = .start
}
