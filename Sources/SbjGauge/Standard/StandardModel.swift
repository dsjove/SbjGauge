//
//  StandardModel.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

public struct StandardModel: RadialModel & SpanningModel {

	public init(value: Value, range: ClosedRange<Value>, clampStyle: ClampStyle = .closed) {
		self.range = range
		self.clampStyle = clampStyle
		self.values = [range.clamp(value, clampStyle)]
	}

	public init(values: [Value], range: ClosedRange<Value>, clampStyle: ClampStyle = .closed) {
		self.range = range
		self.clampStyle = clampStyle
		self.values = values.map { range.clamp($0, clampStyle) }
	}

	public var range: ClosedRange<Value>
	public var clampStyle: ClampStyle;
	public var values: [Value]
	public var angles: ClosedRange<Angle> = .degrees(0) ... .degrees(360)
	public var ticks: [Tick<Value>] = [.init(1.0)]
	public var spans: [Span<Value>] = []
}
