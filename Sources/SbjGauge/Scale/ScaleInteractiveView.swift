//
//  ScaleInteractiveView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/18/25.
//

import SwiftUI

public extension Scale {
	struct InteractiveView: View {
		@State private var model: FullModel

		public init() {
			_model = State(initialValue: FullModel(scale: 0))
		}

		public var body: some View {
			ScaleView(model)
				.contentShape(Rectangle())
				.onLongPressGesture {
					withAnimation(.easeOut(duration: 3.0)) {
						model[norm: 0] = 0.95
					}
				} onPressingChanged: { isPressing in
					withAnimation(.easeOut(duration: 3.0)) {
						model[norm: 0] = isPressing ? 0.47 : 0
					}
				}
		}
	}
}

#Preview {
	Scale.InteractiveView()
}
