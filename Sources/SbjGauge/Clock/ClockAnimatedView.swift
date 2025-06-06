//
//  ClockAnimatedView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/16/25.
//

import SwiftUI

public extension Clock {
	struct AnimatedView: View {
		let calendar = Calendar.current
		let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
		@State private var currentTime: Date

		public init() {
			_currentTime = State(initialValue: Date())
		}

		public var body: some View {
			ClockView(.init(clock: currentTime))
				.onReceive(timer) { input in
					currentTime = input
				}
		}
	}
}

#Preview {
	Clock.AnimatedView()
}
