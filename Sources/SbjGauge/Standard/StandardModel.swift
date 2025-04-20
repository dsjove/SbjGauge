//
//  StandardModel.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

public struct StandardModel: ValuesModel & RadialModel & TickModel & SpanningModel {

	public init(value: Value, range: ClosedRange<Value>) {
		self.values = [range.clamp(value)]
		self.range = range
	}

	public var range: ClosedRange<Value>
	public var values: [Value]
	public var angles: ClosedRange<Angle> = .degrees(0) ... .degrees(360)
	public var ticks: [Tick<Value>] = [.init(1.0)]
	public var spans: [Span<Value>] = []
}
