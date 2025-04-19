# SbjGauge

Customizable analog multi-indicator SwiftUI gauge.

Inspired by: https://github.com/Will-tm/WMGaugeView

## Design Goals

I struggle with the oversimplified symbolic UI in most applications; done in the name of minimalism. Many gauges are a a single color arc with maybe an arrow. That is not enough information for a glanceable read. We have to learn the symbol langauge, often per application. Is the arced arrow a refresh action, progress indicator, or rotate action?

My goal is to create a library that makes it easy to construct a detailed multi-value gauge with the level of skeuomorphism that fits your application's visual language.

This library is continuing to evolve as my knowledge of SwiftUI increases and SwiftUI's capabilties evolve. Every rendering strategy and value is being bubbled to the public interface; with reasonable defaults. And the composition model is breaking into smaller and more reuasable parts.

The gauges have no intrinsic size. On the highest level, a gauge is a Centered-Origin ZStack GeometryReader. Every component should specify its dimensions using normalized values.

The gauges render well on iPhone, iPad, Watch, and AppleTV. I have not thought about the 3D space of AppleVision.

## Simple Instantiation

To create a basic uncustomized gauge:

`SbjGauge.Standard.StandardView(.init(standard: 1.5))`

<img src="Sample-Default.png" alt="Default" width="200">

I have created several built-in views of the gauge. See the included playgrounds for usage; including a build-your-own template.

<img src="Images/Sample-Clock.png" alt="Clock" width="200"><img src="Images/Sample-Power.png" alt="Power" width="200"><img src="Images/Sample-UpTo11.png" alt="11" width="200"><img src="Images/Sample-Scale.png" alt="11" width="200">


## TODOS
- Continue to break down the composition of Model and 'Set' views.
- Correct transition animations to have entire gauge animate together.
- Fix NeedleSetView warnings
- Swiftui-ify ScrubView
