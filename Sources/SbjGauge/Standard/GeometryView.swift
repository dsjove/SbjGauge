//
//  GeometryView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

let CoordinateSpace = "SbjGauge.CoordinateSpace"

public extension Standard {
	/**
	 * SwiftUI builds a compostion from inner most view's intrinsic size outward.
	 * The gauge has no intrinsic size, stacks its views and origin is center.
	 * This view sets that up.
	 */
	struct GeometryView<Content: View>: View {
		@ViewBuilder private let content: (GeometryProxy) -> Content

		public init(@ViewBuilder _ content: @escaping (GeometryProxy) -> Content) {
			self.content = content
		}

	//TODO: on many parent-view transition animations, the components of the ZStack animate with seperate timing. It looks like crap. How do we tell the framework 'This is one view for animations'?
		public var body: some View {
			GeometryReader { geometry in
				ZStack {
					content(geometry)
				}
				.coordinateSpace(name: CoordinateSpace)
				.frame(width: geometry.diameter, height: geometry.diameter, alignment: .center)
			}
			//TODO: have more aspect options with alignments
			// - sepecifically 'scale gauge' is half height
			.aspectRatio(1.0, contentMode: .fit)
			.background(isPreview ? Color.mint : Color.clear)
			.background(Color.clear)
		}
	}
}

#Preview {
	Standard.GeometryView() { geom in
		Text("Hello")
			.foregroundColor(Color.blue)
	}
}
