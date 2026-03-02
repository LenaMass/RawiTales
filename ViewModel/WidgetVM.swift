import SwiftUI
import Combine

@MainActor
final class HeroRingWidgetViewModel: ObservableObject {
    @Published var segments: [RingSegment]

    let ringWidth: CGFloat
    let ringHeight: CGFloat
    let lineWidth: CGFloat
    let iconRadius: CGFloat
    let centerSize: CGFloat

    init(
        segments: [RingSegment],
        ringWidth: CGFloat = 200,
        ringHeight: CGFloat = 150,
        lineWidth: CGFloat = 20,
        iconRadius: CGFloat = 75,
        centerSize: CGFloat = 92
    ) {
        self.segments = segments
        self.ringWidth = ringWidth
        self.ringHeight = ringHeight
        self.lineWidth = lineWidth
        self.iconRadius = iconRadius
        self.centerSize = centerSize
    }

    static var preset: HeroRingWidgetViewModel {
        HeroRingWidgetViewModel(
            segments: [
                .init(from: 0.04, to: 0.18, color: Color.pastelP, icon: "heart", iconAngleDegrees: 65),
                .init(from: 0.23, to: 0.35, color: Color.pastelB, icon: "moon.stars", iconAngleDegrees: 126),
                .init(from: 0.40, to: 0.53, color: Color.pastelM, icon: "leaf", iconAngleDegrees: 191),
                .init(from: 0.58, to: 0.69, color: Color.pastelO, icon: "brain.head.profile", iconAngleDegrees: -110),
                .init(from: 0.74, to: 0.99, color: Color.pastelY, icon: "sparkles", iconAngleDegrees: -3)
            ]
        )
    }
}


