//
//  Values.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/17/25.
//

import Foundation

public protocol Values {
	typealias Value = Double
	typealias ValueIdx = Int
	var range: ClosedRange<Value> { get set }
	var values: [Value] { get set }
}

public extension Values {
	func norm(value: Value) -> Double {
		range.norm(value)
	}

	func value(norm: Double) -> Value {
		range.value(norm)
	}

	subscript(index: ValueIdx) -> Value {
		get { values[index] }
		set { values[index] = range.clamp(newValue) }
	}

	subscript(norm index: ValueIdx) -> Value {
		get { norm(value: values[index]) }
		set { values[index] = value(norm: newValue) }
	}
}
