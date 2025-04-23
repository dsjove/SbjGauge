//
//  GaugeModel.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/17/25.
//

import Foundation
import SwiftUI

public protocol GaugeValue: Comparable {
	init(double: Double)
	var toDouble: Double { get }
	//TODO: this needs to be stridable
	static func += (lhs: inout Self, rhs: Self)
}

extension Double : GaugeValue {
	public init(double: Double) { self = double }
	public var toDouble: Double { self }
}

extension Int : GaugeValue {
	public init(double: Double) { self = Int(double) }
	public var toDouble: Double { Double(self) }
}

public protocol GaugeModel {
	associatedtype Value: GaugeValue = Double
	//TODO: not always a closed range
	var range: ClosedRange<Value> { get set }
}

public extension ClosedRange where Bound: GaugeValue {
	func clamp(_ value : Bound) -> Bound {
		self.lowerBound > value ? self.lowerBound :
		self.upperBound < value ? self.upperBound :
		value
	}

	func norm(_ value: Bound) -> Double {
		let u = upperBound.toDouble
		let l = lowerBound.toDouble
		let v = clamp(value).toDouble
		return (v - l) / (u - l)
	}

	func value(_ norm: Double) -> Bound {
		let u = upperBound.toDouble
		let l = lowerBound.toDouble
		return Bound(double: l + (norm * (u - l)))
	}
}
