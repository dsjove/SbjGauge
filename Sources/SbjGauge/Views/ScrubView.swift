//
//  ScrubView.swift
//  SbjGauge
//
//  Created by David Giovannini on 12/15/22.
//

import SwiftUI

/**
 * The built in slider control is not sufficient for controlling IOT values.
 * This class is a bit of a mess and needs some SwiftUI best-practices.
 */
public struct ScrubView: View {
	//TODO: break out these members into view builders and modifiers
	private let value: Double
	private let range: ClosedRange<Double>
	private let increment: Double?
	private let autoCentering: Double?
	private let minMaxSplit: Double?
	private let gradient: Bool
	private let thumbColor: Color
	private let minTrackColor: Color
	private let maxTrackColor: Color
	private let change: (Double) -> Void

	//@FocusState private var focused: Bool
	@Environment(\.isFocused) private var isFocused: Bool
	@Environment(\.isEnabled) private var isEnabled: Bool
	@State private var initialPressLocation: CGPoint? = nil

	public init(
		value: Double = 0.0,
		range: ClosedRange<Double> = 0.0...1.0,
		increment: Double? = nil,
		autoCentering: Double? = nil,
		minMaxSplit: Double? = nil,
		gradient: Bool = false,
		thumbColor: Color = .sbjGauge("ScrubView/Standard/Thumb"),
		minTrackColor: Color = .sbjGauge("ScrubView/Standard/Min"),
		maxTrackColor: Color = .sbjGauge("ScrubView/Standard/Max"),
		change: @escaping (Double) -> Void = {_ in}) {
			self.value = value
			self.range = range
			self.increment = increment
			self.autoCentering = autoCentering
			self.minMaxSplit = minMaxSplit
			self.gradient = gradient
			self.thumbColor = thumbColor
			self.minTrackColor = minTrackColor
			self.maxTrackColor = maxTrackColor
			self.change = change
	}

	public var body: some View {
		GeometryReader { gr in
			let width = gr.size.width
			let height = gr.size.height
			let inset = width * 0.015
			let railHeight = height * 0.25
			let thumbWidth = height

			let minPos = inset + thumbWidth * 0.5
			let maxPos = width - minPos
			let posLength = maxPos - minPos
			let valueLength = range.upperBound - range.lowerBound

			let currentPosition = {
				let safeValue = range.clamp(self.value)
				let normValue = (safeValue - range.lowerBound) / valueLength
				let sliderPos = minPos + (normValue * posLength)
				return sliderPos
			}

			let splitPosition = {
				let safeValue = range.clamp(minMaxSplit ?? self.value)
				let normValue = (safeValue - range.lowerBound) / valueLength
				let sliderPos = minPos + (normValue * posLength)
				return sliderPos
			}

			let proposeValue = { (location: Double) in
				let normPos = (location - minPos) / posLength
				var value = range.lowerBound + (normPos * valueLength)
				if let increment {
					value = round(value / increment) * increment
				}
				let safeValue = range.clamp(value)
				change(safeValue)
			}

			ZStack {
				Group {
					if gradient {
						if isEnabled {
							RoundedRectangle(cornerRadius: railHeight * 0.5)
								.fill(
									LinearGradient(
										gradient: Gradient(colors: [minTrackColor, maxTrackColor]),
										startPoint: .leading,
										endPoint: .trailing
									))
								.overlay(
										RoundedRectangle(cornerRadius: railHeight * 0.5)
											.stroke(thumbColor, lineWidth: 0.5)
									)
								.frame(width: width, height: height * 0.25)
						}
						else {
							RoundedRectangle(cornerRadius: railHeight * 0.5)
								.stroke(thumbColor, lineWidth: 0.5)
								.frame(width: width, height: height * 0.25)
						}
					}
					else {
						HStack {
							RoundedRectangle(cornerRadius: railHeight * 0.5)
								.fill(isEnabled ? minTrackColor : Color.clear)
								.overlay(
									RoundedRectangle(cornerRadius: railHeight * 0.5)
										.stroke(thumbColor, lineWidth: 0.5)
								)
								.frame(width: splitPosition(), height: height * 0.25)
							Spacer()
						}
						HStack {
							Spacer()
							RoundedRectangle(cornerRadius: railHeight * 0.5)
								.fill(isEnabled ? maxTrackColor : Color.clear)
								.overlay(
									RoundedRectangle(cornerRadius: railHeight * 0.5)
										.stroke(thumbColor, lineWidth: 0.5)
								)
								.frame(width: width - splitPosition(), height: height * 0.25)
						}
					}
				}
#if !os(tvOS)
				.gesture(
					DragGesture(minimumDistance: 0)
						.onChanged { dragValue in
							if initialPressLocation == nil {
								initialPressLocation = dragValue.location
								proposeValue(dragValue.location.x)
							}
						}
						.onEnded { _ in
							initialPressLocation = nil
							if let autoCentering {
								change(autoCentering)
							}
						}
				)
#endif
				HStack {
					RoundedRectangle(cornerRadius: thumbWidth * 0.5)
						.frame(width: thumbWidth)
						.foregroundColor(thumbColor)
						.offset(x: currentPosition() - thumbWidth * 0.5)
						.shadow(radius: isFocused || isEnabled ? thumbWidth * 0.5 : 0.0)
#if !os(tvOS)
					.gesture(DragGesture(minimumDistance: 0)
						.onChanged { drag in
							proposeValue(drag.location.x)
						}.onEnded({ _ in
							if let autoCentering {
								change(autoCentering)
							}
						}))
#endif
					Spacer()
				}
			}
		}
#if os(tvOS)
		.focusable()
#endif
	}
}

fileprivate struct PreviewView : View {
	@State private var value = 0.3333
	var body: some View {
		ScrubView(value: value, increment: 0.1) { value = $0 }
	}
}

#Preview {
	PreviewView().frame(height: 44)
}
