//
//  CheckerboardView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

/**
 * A basic checkerboard handy for previews and testing
 */
public struct CheckerboardView: View {
	private let rows: Int
	private let columns: Int
	private let oddColor: Color
	private let evenColor: Color

	public init(
		rows: Int = 16,
		columns: Int = 16,
		oddColor: Color = .black,
		evenColor: Color = .white) {
			self.rows = rows
			self.columns = columns
			self.oddColor = oddColor
			self.evenColor = evenColor
	}

	public var body: some View {
		let rowCount = Double(rows)
		let columnCount = Double(columns)
		let ratio = columnCount / rowCount
		GeometryReader { geometry in
			let squareSize = min(geometry.size.height / rowCount, geometry.size.width / columnCount)
			VStack(spacing: 0) {
				ForEach(0..<rows, id: \.self) { row in
					HStack(spacing: 0) {
						ForEach(0..<columns, id: \.self) { column in
							Rectangle()
								.fill((row + column).isMultiple(of: 2) ? evenColor : oddColor)
								.frame(width: squareSize, height: squareSize)
						}
					}
				}
			}
			.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
		}
		.aspectRatio(ratio, contentMode: .fit)
	}
}

#Preview {
	CheckerboardView()
		.background(Color.gray)
}
