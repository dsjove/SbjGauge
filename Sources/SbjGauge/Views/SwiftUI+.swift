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

/**
 * Convenience constructor that includes alpha
 */
extension Color {
	init(_ r: Double, _ g: Double, _ b: Double, _ o: Double = 1.0) {
		self = Color( red: r, green: g, blue: b).opacity(o)
	}
}

extension Color: @retroactive CaseIterable {
	public static var allCases: [Color] {
		return [
			Color.red,
			Color.orange,
			Color.yellow,
			Color.green,
			Color.mint,
			Color.teal,
			Color.cyan,
			Color.blue,
			Color.indigo,
			Color.purple,
			Color.pink,
			Color.brown,
			Color.white,
			Color.gray,
			Color.black,
			Color.clear,
			Color.primary,
			Color.secondary,
		]
	}
}

extension View {
	var isPreview: Bool {
		return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
	}
}
