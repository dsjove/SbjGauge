//
//  Spanning.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/17/25.
//

import Foundation
import SwiftUI

public struct Span {
	public typealias Value = Double
	public let range: ClosedRange<Value>

	public init(_ range: ClosedRange<Value>) {
		self.range = range
	}

	public func contains(_ value: Value) -> Bool {
		range.contains(value)
	}
}

public protocol Spanning {
	typealias Value = Span.Value
	typealias SpanIdx = Int
	var spans: [Span]  { get set }
}

public extension Spanning {
	func span(for value: Value) -> (offset: SpanIdx, element: Span)? {
		for span in spans.enumerated().reversed() {
			if span.element.contains(value) {
				return (span.offset, span.element)
			}
		}
		return nil
	}
}

public struct SpanArc {
	public typealias Value = Double
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

public extension Spanning where Self: Radial {
	func spanArcs() -> [SpanArc] {
		return spans.enumerated().map { span in
			let angle1 = angle(value: span.element.range.lowerBound)
			let angle2 = angle(value: span.element.range.upperBound)
			return .init(span.offset, values.count, span.element.range, angle1 ... angle2)
		}
	}
}
