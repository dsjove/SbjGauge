//
//  SpanningModel.swift
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

public protocol SpanningModel {
	typealias Value = Double
	typealias SpanIdx = Int
	var spans: [Span]  { get set }
}

public extension SpanningModel {
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
	public typealias SpanIdx = Int
	public let idx: SpanIdx
	public let count: Int
	public let range: ClosedRange<Value>
	public let angles: ClosedRange<Angle>

	public init(
		_ idx: SpanIdx,
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
	func spanArcs() -> [SpanArc] {
		return spans.enumerated().map { span in
			let angle1 = angle(value: span.element.range.lowerBound)
			let angle2 = angle(value: span.element.range.upperBound)
			return .init(span.offset, spans.count, span.element.range, angle1 ... angle2)
		}
	}
}
