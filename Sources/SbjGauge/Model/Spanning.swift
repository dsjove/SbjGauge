//
//  Spanning.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/17/25.
//

import Foundation
import SwiftUI

public protocol Spanning {
	typealias Value = Double
	typealias SpanIdx = Int
	var spans: [ClosedRange<Value>]  { get set }
}

public extension Spanning {
	func span(for value: Value) -> (SpanIdx, ClosedRange<Value>)? {
		for span in spans.enumerated().reversed() {
			if span.element.contains(value) {
				return (span.offset, span.element)
			}
		}
		return nil
	}
}

public extension Spanning where Self: Radial & Values {
	func angles(for span: ClosedRange<Value>) -> ClosedRange<Angle> {
		let angle1 = angle(value: Double(span.lowerBound))
		let angle2 = angle(value: Double(span.upperBound))
		return (angle1 ... angle2)
	}
}
