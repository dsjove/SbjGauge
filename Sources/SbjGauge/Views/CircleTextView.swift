//
//  CircleTextView.swift
//  SbjGauge
//
//  Created by David Giovannini on 12/12/22.
//  Inspired by: https://github.com/viettrungphan/SwiftUIGeometryPractice

import Foundation
import SwiftUI

/**
 * CircleTextView renders a sequnce of variable width views over an arch.
 * Variable widths are accounted for.
 * Text kerning is not accounted for.
 */
public struct CircleTextView<S: Sequence, Content: View>: View {
	private let sequence: S
	private let offset: Angle
	//TODO: have init with horizontal align enum
	private let alignment: Double //0 ... 1
	//TODO: use truncation style
	private let clip360: Bool
	//TODO: modifier as strategy and combine efforts with clip360
	private let maxWidth: Angle?
	//TODO: option for different baselines
	//TODO: have view default with String describing
	private let view: (Int, S.Element) ->Content

	@State private var textSizes: [Int:CGSize] = [:]

	public init(
		sequence: S,
		offset: Angle = .init(),
		alignment: Double = 0.5,
		clip360: Bool = true,
		maxWidth: Angle? = nil,
		@ViewBuilder view: @escaping (Int, S.Element) -> Content) {
			self.sequence = sequence
			self.offset = offset
			self.alignment = alignment
			self.clip360 = clip360
			self.maxWidth = maxWidth
			self.view = view
	}

	public var body: some View {
		GeometryReader { geometry in
			let diameter = min(geometry.size.width, geometry.size.height)
			let radius = diameter / 2.0
			let lastAngle = self.calcAngles(at: self.textSizes.count, radius: radius).rotate
			ZStack {
				ForEach(Array(sequence.enumerated()), id: \.self.offset) { (offset, element) in
					let angles = self.calcAngles(at: offset, radius: radius)
					if !clip360 || angles.width <= .degrees(360) {
						VStack {
							view(offset, element)
								.background(Sizeable())
								.onPreferenceChange(SizePreferenceKey.self, perform: { size in
									self.textSizes[offset] = size
								})
							Spacer()
						}
						.frame(width: diameter, height: diameter)
						.rotationEffect(angles.rotate)
					}
				}
			}
			.rotationEffect(-lastAngle * self.alignment + self.offset)
			.opacity(maxWidth.map { lastAngle <= $0 ? 1.0 : $0.degrees / lastAngle.degrees } ?? 1.0)
		}
		.aspectRatio(1.0, contentMode: .fit)
	}

	private func calcAngles(at index: Int, radius: Double) -> (rotate: Angle, width: Angle) {
		guard textSizes.isEmpty == false else { return (Angle(), Angle()) }
		var length = textSizes.filter{$0.key < index}.map{$0.value.width}.reduce(0,+)
		var bounds = length
		let height: Double
		if let mySize = textSizes[index] {
			length += mySize.width * 0.5
			bounds += mySize.width
			height = mySize.height
		}
		else {
			//TODO: height is almost what we want
			height = textSizes.first!.value.height
		}
		let realRadius = radius - height
		return (.radians(length/realRadius), .radians(bounds/realRadius))
	}
}

public extension CircleTextView where S: StringProtocol {
	init(
		string: S,
		offset: Angle = .init(),
		alignment: Double = 0.5,
		clip360: Bool = true,
		maxWidth: Angle? = nil,
		@ViewBuilder view: @escaping (Int, S.Element) -> Content = {Text(String($1))}
		) {
			self.init(
				sequence: string,
				offset: offset,
				alignment: alignment,
				clip360: true,
				maxWidth: maxWidth,
				view: view)
		}
}

public extension CircleTextView where S == String {
	init<D: CustomStringConvertible>(
		convertable: D,
		offset: Angle = .init(),
		alignment: Double = 0.5,
		clip360: Bool = true,
		maxWidth: Angle? = nil,
		@ViewBuilder view: @escaping (Int, S.Element) -> Content = {Text(String($1))}
		) {
			self.init(
				string: convertable.description,
				offset: offset,
				alignment: alignment,
				clip360: clip360,
				maxWidth: maxWidth,
				view: view)
		}
}

private struct SizePreferenceKey: PreferenceKey {
	typealias Value = CGSize
	static var defaultValue = CGSize()
	static func reduce(value: inout Value, nextValue: () -> Value) {
		value = nextValue()
	}
}

private struct Sizeable: View {
	var body: some View {
		GeometryReader { geometry in
			Color.clear
				.preference(key: SizePreferenceKey.self, value: geometry.size)
		}
	}
}

fileprivate struct CircleTextPreviewView<S: Sequence>: View {
	let text: S
	let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
	@State var offset =  Angle()

	var body: some View {
		CircleTextView(
				sequence: text,
				offset: offset,
				alignment: 0.0,
				clip360: true) {
					Text(String(describing: $1))
						.border(Color.green, width: 1)
				}
			.font(.title2)
			.bold(true)
			.italic(true)
			.frame(width: 200)
			.border(Color.green, width: 3)
			.animation(.linear(duration: 0.5), value: offset)
			.onReceive(timer) { _ in
				offset -= .degrees(10)
			}
	}
}

#Preview {
	CircleTextPreviewView(text: "The quick brown fox jumps over the lazy dog.")

	CircleTextPreviewView(text: 0...30)
}
