//
//  CompositionView.swift
//  SbjGauge
//
//  Created by David Giovannini on 4/1/25.
//

import SwiftUI

/**
 * CompositionView is the view that renders all the layers of the Gauge.
 * The constructor receives a view builder for every layer.
 *
 * The design will change given paramter packs, protocols, and view
 * modifiers.
 */
public extension Gauge {
	struct CompositionView<
		Background: View,
		Tick: View,
		Indicators: View,
		Needle: View,
		Span: View,
		Foreground: View>: View {

		public typealias TickSetView = Standard.TickSetView<Tick>
		public typealias IndicatorSetView = Standard.IndicatorSetView<Indicators>
		public typealias NeedleSetView = Standard.NeedleSetView<Needle>
		public typealias SpanSetView = Standard.SpanSetView<Span>

		public typealias BackgroundBuilder = (GeometryProxy, Model) -> Background
		public typealias TickBuilder = TickSetView.Builder
		public typealias IndicatorsBuilder = IndicatorSetView.Builder
		public typealias NeedleBuilder = NeedleSetView.Builder
		public typealias SpanBuilder = SpanSetView.Builder
		public typealias ForegroundBuilder = (GeometryProxy, Model) -> Foreground

		let preview: Bool
		let model: Model
		let background: BackgroundBuilder
		let tick: TickBuilder
		let tickRadius: Double
		let indicators: IndicatorsBuilder
		let needle: NeedleBuilder
		let span: SpanBuilder
		let foreground: ForegroundBuilder

		public init(
			preview: Bool = false,
			_ model: Model = .init(),
			@ViewBuilder
			background: @escaping (GeometryProxy, Model)->Background = { geom,_ in Standard.BackgroundView(geom: geom) },
			tickRadius: Double = 0.95,
			@ViewBuilder
			tick: @escaping Standard.TickSetView<Tick>.Builder = Standard.TickSetView<Tick>.defaultBuilder,
			@ViewBuilder
			indicators: @escaping Standard.IndicatorSetView<Indicators>.Builder = Standard.IndicatorSetView<Indicators>.defaultBuilder,
			@ViewBuilder
			needle: @escaping Standard.NeedleSetView<Needle>.Builder = Standard.NeedleSetView<Needle>.defaultBuilder,
			@ViewBuilder
			span: @escaping Standard.SpanSetView<Span>.Builder = Standard.SpanSetView<Span>.defaultBuilder,
			@ViewBuilder
			foreground: @escaping (GeometryProxy, Model)->Foreground = { geom,_ in
				Standard.RimView(geom: geom)
			}
			) {
				self.preview = preview
				self.model = model
				self.background = background
				self.tick = tick
				self.tickRadius = tickRadius
				self.indicators = indicators
				self.needle = needle
				self.span = span
				self.foreground = foreground
			}

		public var body: some View {
			ZStackSquare(preview: preview) { geom in
				background(geom, model)
				TickSetView(geom: geom, model: model, radius: tickRadius, builder: tick)
				IndicatorSetView(geom: geom, model: model, builder: indicators)
				SpanSetView(geom: geom, model: model, builder: span)
				NeedleSetView(geom: geom, model: model, builder: needle)
				foreground(geom, model)
			}
		}
	}
}

#Preview {
	Gauge.CompositionView(preview: true, .init(value: 1.5))
}
