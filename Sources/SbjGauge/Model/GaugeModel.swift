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
	//TODO: this should be stridable
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
	//TODO: do we need to support open Ranges?
	var range: ClosedRange<Value> { get set }
	
	var values: [Value] { get set }
}

public extension GaugeModel {
	subscript(index: Int) -> Value {
		get { values[index] }
		set { values[index] = range.clamp(newValue) }
	}

	subscript(norm index: Int) -> Double {
		get { range.norm(values[index]) }
		set { values[index] = range.clamp(range.value(newValue)) }
	}

	var value: Value {
		get { self[0] }
		set { self[0] = newValue }
	}

	subscript<Name: RawRepresentable>(index: Name) -> Value where Name.RawValue == Int {
		get { self[index.rawValue] }
		set { self[index.rawValue] = newValue }
	}

	subscript<Name: RawRepresentable>(norm index: Name) -> Double where Name.RawValue == Int {
		get { self[norm: index.rawValue] }
		set { self[norm: index.rawValue] = newValue }
	}
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
