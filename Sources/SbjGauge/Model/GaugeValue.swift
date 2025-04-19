//
//  ClosedRange+.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/17/25.
//

import Foundation
import SwiftUI

/**
 *
 */
public protocol GaugeValue: Comparable {
	init(double: Double)
	var toDouble: Double { get }
}

extension Double : GaugeValue {
	public init(double: Double) { self = double }
	public var toDouble: Double { self }
}

extension Angle : GaugeValue {
	public init(double: Double) { self = .degrees(double) }
	public var toDouble: Double { self.degrees }
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
