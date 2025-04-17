//
//  FullModel.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

//TODO: Continue protocol refactoring

public struct FullModel: Values, Radial, Ticking, Spanning {
	public init(value: Value, range: ClosedRange<Value>) {
		self.values = [range.clamp(value)]
		self.range = range
	}

	public var range: ClosedRange<Value>
	public var values: [Value]
	public var angles: ClosedRange<Angle> = .degrees(0) ... .degrees(360)
	public var ticks: [Tick] = [.init(), .init()]
	public var tickEnds: TickEnds = .start
	public var spans: [ClosedRange<Value>] = []
}
