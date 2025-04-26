//
//  ValuesModel.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/17/25.
//

import Foundation

//TODO: necessary?
//TODO: if keeping, user defined named Values
public protocol ValuesModel: GaugeModel {
	var values: [Value] { get set }
}

public extension ValuesModel {
	subscript(index: Int) -> Value {
		get { values[index] }
		set { values[index] = range.clamp(newValue) }
	}

	subscript(norm index: Int) -> Double {
		get { range.norm(values[index]) }
		set { values[index] = range.value(newValue) }
	}
}
