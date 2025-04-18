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
 * Text kerning is not accounted for.
 */
public struct CircleTextView<S: Sequence, Content: View>: View {
	private let text: S
	private let angle: Angle
	private let alignment: Double
	private let tooFar: Angle
	//TODO: option to center align first letter
	//TODO: option to span letters across range of angles
	//TODO: option for different baselines
	//TODO: have view default with String describing
	private let view: (Int, S.Element) ->Content

	@State private var textSizes: [Int:CGSize] = [:]

	public init(
		text: S,
		angle: Angle = .init(),
		alignment: Double = 0.5,
		tooFar: Angle = .init(degrees: 360),
		@ViewBuilder view: @escaping (Int, S.Element) -> Content) {
			self.text = text
			self.angle = angle
			self.alignment = alignment
			self.tooFar = tooFar
			self.view = view
	}

	public var body: some View {
		GeometryReader { geometry in
			let diameter = min(geometry.size.width, geometry.size.height)
			let radius = diameter / 2.0
			let fullAngle = self.angle(at: self.textSizes.count, radius: radius).0
			ZStack {
				ForEach(Array(text.enumerated()), id: \.self.offset) { (offset, element) in
					let angle = self.angle(at: offset, radius: radius)
					VStack {
						view(offset, element)
							.background(Sizeable())
							.onPreferenceChange(SizePreferenceKey.self, perform: { size in
								self.textSizes[offset] = size
							})
						Spacer()
					}
					.frame(width: diameter, height: diameter)
					.rotationEffect(angle.0)
					.opacity(angle.1 > .degrees(360) ? 0 : 1)
				}
			}
			.rotationEffect(-fullAngle * self.alignment + self.angle)
			.opacity(fullAngle <= tooFar ? 1.0 : tooFar.degrees / fullAngle.degrees)
		}
		.aspectRatio(1.0, contentMode: .fit)
	}

	private func angle(at index: Int, radius: Double) -> (Angle, Angle) {
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
		text: S,
		angle: Angle = .init(),
		alignment: Double = 0.5,
		tooFar: Angle = .init(degrees: 360),
		@ViewBuilder view: @escaping (Int, S.Element) -> Content = {Text(String(describing: $1))}
		) {
			self.text = text
			self.angle = angle
			self.alignment = alignment
			self.tooFar = tooFar
			self.view = view
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
	@State var angle =  Angle()

	var body: some View {
		CircleTextView(
				text: text,
				angle: angle,
				alignment: 0.0) {
					Text(String(describing: $1))
						.bold(true)
						.italic(true)
						.border(Color.green, width: 1)
				}
			.font(.title2)
			.frame(width: 200)
			.border(Color.green, width: 3)
			.animation(.linear(duration: 0.5), value: angle)
			.onReceive(timer) { _ in
				angle -= .degrees(10)
			}
	}
}

#Preview {
	CircleTextPreviewView(text: "The quick brown fox jumps over the lazy dog.")

	CircleTextPreviewView(text: 0...100)
}
