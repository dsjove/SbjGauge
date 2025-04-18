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
}

public protocol Spanning {
	typealias Value = Span.Value
	typealias SpanIdx = Int
	var spans: [Span]  { get set }
}

public extension Spanning {
	func span(for value: Value) -> (SpanIdx, Span)? {
		for span in spans.enumerated().reversed() {
			if span.element.range.contains(value) {
				return (span.offset, span.element)
			}
		}
		return nil
	}
}

public extension Spanning where Self: Radial & Values {
	func angles(for span: Span) -> ClosedRange<Angle> {
		let angle1 = angle(value: span.range.lowerBound)
		let angle2 = angle(value: span.range.upperBound)
		return (angle1 ... angle2)
	}
}
