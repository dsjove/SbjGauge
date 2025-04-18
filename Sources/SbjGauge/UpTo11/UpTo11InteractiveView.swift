//
//  UpTo11InteractiveView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/16/25.
//

import SwiftUI

public extension UpTo11 {
	struct InteractiveView: View {
		@State private var model: FullModel

		public init() {
			_model = State(initialValue: FullModel(upTo11: 11))
		}

		public var body: some View {
			UpTo11View(model)
				.overlay(GeometryReader { geometry in
						Color.clear
							.contentShape(Circle())
#if !os(tvOS)
							.gesture(
								DragGesture()
									.onChanged { gesture in
										let l1 = gesture.translation.height
										let l2 = gesture.translation.width
										let l = abs(l1) > abs(l2) ? l1 : l2
										model[0] += l / geometry.size.width
									})
#endif
				})
		}
	}
}

#Preview {
	UpTo11.InteractiveView()
}


