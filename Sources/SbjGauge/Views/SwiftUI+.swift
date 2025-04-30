//
//  SwiftUI+.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

/**
 * Convenience methods on GeometryProxy for radial computations.
 */
public extension GeometryProxy {
	var diameter: Double {
		min(size.width, size.height)
	}

	var radius: Double {
		diameter / 2.0
	}

	var center: CGPoint {
		CGPoint(x: size.width / 2.0, y: size.height / 2.0)
	}

	var centerOffset: CGSize {
		CGSize(width: size.width / 2.0, height: size.height / 2.0)
	}

	func center(x: Double, y: Double) -> CGPoint {
		CGPoint(x: (size.width / 2.0) + x, y: (size.height / 2.0) + y)
	}

	func radius(_ unit: Double) -> Double {
		radius * unit
	}

	func width(_ unit: Double) -> Double {
		diameter * unit
	}
}

/**
 * Convenience constructor to read this module's colors outside this module
 */
public extension Color {
	static func sbjGauge(_ name: String) -> Color {
		Color(name, bundle: .module)
	}
}

extension View {
	//SwiftPlayground App-Preview has this set, not great.
	var isPreview: Bool {
		return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
	}
}
