//
//  GaugeModel.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/17/25.
//

import Foundation
import SwiftUI

public protocol GaugeValue: Comparable, Strideable {
	init(double: Double)
	var toDouble: Double { get }
}

extension Double : GaugeValue {
	public init(double: Double) { self = double }
	public var toDouble: Double { self }
}

extension Int : GaugeValue {
	public init(double: Double) { self = Int(double) }
	public var toDouble: Double { Double(self) }
}

public enum ClampStyle {
	case closed
	case cycleOpenUpper
	case cycleOpenLower
}

public protocol GaugeModel {
	associatedtype Value: GaugeValue = Double
	
	var range: ClosedRange<Value> { get set }
	var clampStyle: ClampStyle { get }

	var values: [Value] { get set }
}

public extension GaugeModel {
	var clampStyle: ClampStyle { .closed }

	subscript(index: Int) -> Value {
		get { values[index] }
		set { values[index] = range.clamp(newValue, clampStyle) }
	}

	subscript(norm index: Int) -> Double {
		get { range.norm(values[index]) }
		set { values[index] = range.clamp(range.value(newValue), clampStyle) }
	}

	var value: Value {
		get { self[0] }
		set { self[0] = newValue }
	}

	var norm: Double {
		get { self[norm: 0] }
		set { self[norm: 0] = newValue }
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
	func clamp(_ value : Bound, _ style: ClampStyle = .closed) -> Bound {
		switch style {
			case .closed:
				value < self.lowerBound ? self.lowerBound :
				value > self.upperBound ? self.upperBound :
				value
			case .cycleOpenUpper:
				value < self.lowerBound ? self.lowerBound :
				value >= self.upperBound ? self.lowerBound :
				value
			case .cycleOpenLower:
				value <= self.lowerBound ? self.upperBound :
				value > self.upperBound ? self.upperBound :
				value
		}
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
