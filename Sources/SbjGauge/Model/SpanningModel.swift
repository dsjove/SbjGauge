//
//  SpanningModel.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/17/25.
//

import Foundation
import SwiftUI

public struct Span<Value : GaugeValue> {
	public let range: ClosedRange<Value>

	public init(_ range: ClosedRange<Value>) {
		self.range = range
	}

	public func contains(_ value: Value) -> Bool {
		range.contains(value)
	}
}

public protocol SpanningModel: GaugeModel {
	var spans: [Span<Value>]  { get set }
}

public extension SpanningModel {
	subscript<Name: RawRepresentable>(span index: Name) -> Span<Value> where Name.RawValue == Int {
		get { self.spans[index.rawValue] }
		set { self.spans[index.rawValue] = newValue }
	}

	func span(for value: Value) -> (offset: Int, element: Span<Value>)? {
		for span in spans.enumerated().reversed() {
			if span.element.contains(value) {
				return (span.offset, span.element)
			}
		}
		return nil
	}
}

public struct SpanArc<Value : GaugeValue> {
	public let idx: Int
	public let count: Int
	public let range: ClosedRange<Value>
	public let angles: ClosedRange<Angle>

	public init(
		_ idx: Int,
		_ count: Int,
		_ range: ClosedRange<Value>,
		_ angles: ClosedRange<Angle>) {
			self.idx = idx
			self.count = count
			self.range = range
			self.angles = angles
	}
}

public extension SpanningModel where Self: RadialModel {
	func spanArcs() -> [SpanArc<Value>] {
		return spans.enumerated().map { span in
			let angle1 = angle(value: span.element.range.lowerBound)
			let angle2 = angle(value: span.element.range.upperBound)
			return .init(span.offset, spans.count, span.element.range, angle1 ... angle2)
		}
	}
}
