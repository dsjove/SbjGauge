//
//  Radial.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/17/25.
//

import SwiftUI

public protocol Radial {
	var angles: ClosedRange<Angle> { get set }
}

public extension Radial where Self: Values {
	func angle(value: Value) -> Angle {
		angles.value(range.norm(value))
	}

	func value(angle: Angle) -> Value {
		range.value(angles.norm(angle))
	}
}
