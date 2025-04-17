//
//  ClosedRange+.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/17/25.
//

import Foundation
import SwiftUI

/**
 * Convenience method to clamp a value in a closed ranged
 * I think this is built in now.
 */
extension ClosedRange {
	func clamp(_ value : Bound) -> Bound {
		self.lowerBound > value ? self.lowerBound :
		self.upperBound < value ? self.upperBound :
		value
	}
}

extension ClosedRange where Bound == Double {
	func norm(_ value: Double) -> Double {
		(clamp(value) - lowerBound) / (upperBound - lowerBound)
	}

	func value(_ norm: Double) -> Double {
		lowerBound + (norm * (upperBound - lowerBound))
	}
}

extension ClosedRange where Bound == Angle {
	func norm(_ angle: Angle) -> Double {
		(angle.degrees - lowerBound.degrees) / (upperBound.degrees - lowerBound.degrees)
	}

	func value(_ norm: Double) -> Angle {
		.degrees(lowerBound.degrees + (norm * (upperBound.degrees - lowerBound.degrees)))
	}
}
