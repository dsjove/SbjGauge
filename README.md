# SbjGauge

Custumizable analog multi-indicator SwiftUI gauge

Inspired by: https://github.com/Will-tm/WMGaugeView

## Design Goals

I struggle with the oversimplified symbolic UI in most applications; done in the name of minimalism. It is easy to draw a single color incomplete circle and call it a gauge. My goal is create a library that makes it easy to create a detailed multi-value gauge with the level of skeuomorphism that fits your application's visual language.

This library has continued to evolve as my knowledge of SwiftUI increases and SwiftUI's capabilties evolve. Every rendering strategy and value is being bubbled to the public interface; with reasonable defaults.

The gauge renders well on iPhone, iPad, Watch, and AppleTV. I have not thought about the 3D space of AppleVision.

## Simple Instantiation

To create the basic uncustomized gauge:

`Gauge.CompositionView(.init(value: 1.5))`

<img src="Sample-Default.png" alt="Default" width="200">

The CompositionView's constructor exposes all the view builders for the various components. I have created two other builtin schemes for the Gauge; Clock and Power.

<img src="Sample-Clock.png" alt="Clock" width="200">
<img src="Sample-Power.png" alt="Power" width="200">
<img src="Sample-UpTo11.png" alt="11" width="200">




