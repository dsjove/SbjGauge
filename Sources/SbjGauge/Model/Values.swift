//
//  Values.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/17/25.
//

import Foundation

public protocol Values {
	typealias Value = Double //DoubleCovertible
	typealias ValueIdx = Int
	var range: ClosedRange<Value> { get set }
	var values: [Value] { get set }
}

public extension Values {
	subscript(index: ValueIdx) -> Value {
		get { values[index] }
		set { values[index] = range.clamp(newValue) }
	}

	subscript(norm index: ValueIdx) -> Value {
		get { range.norm(values[index]) }
		set { values[index] = range.value(newValue) }
	}


}
