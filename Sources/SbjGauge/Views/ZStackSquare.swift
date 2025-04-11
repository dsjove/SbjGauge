//
//  ZStackSquare.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

/**
 * SwiftUI builds a compostion from inner most view's intrinsic size outward.
 * The gauge has no intrinsic size, stacks its views and origin is center.
 * This view sets that up.
 */
struct ZStackSquare<Content: View>: View {
	@ViewBuilder private let content: (GeometryProxy) -> Content

	public init(@ViewBuilder _ content: @escaping (GeometryProxy) -> Content) {
		self.content = content
	}

	public var body: some View {
		GeometryReader { geometry in
			ZStack {
				content(geometry)
			}
			.frame(width: geometry.diameter, height: geometry.diameter, alignment: .center)
		}
		.aspectRatio(1.0, contentMode: .fit)
		.background(isPreview ? Color.mint : Color.clear)
	}
}

#Preview {
	ZStackSquare() { geom in
		Text("Hello")
			.foregroundColor(Color.white)
	}
}
