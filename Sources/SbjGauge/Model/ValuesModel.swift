//
//  ValuesModel.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/17/25.
//

import Foundation

public protocol ValuesModel: GaugeModel {
	typealias ValueIdx = Int
	var values: [Value] { get set }
}

public extension ValuesModel {
	subscript(index: ValueIdx) -> Value {
		get { values[index] }
		set { values[index] = range.clamp(newValue) }
	}

	subscript(norm index: ValueIdx) -> Double {
		get { range.norm(values[index]) }
		set { values[index] = range.value(newValue) }
	}
}
