import SwiftUI

struct RingSegment: Identifiable, Hashable {
    let id: UUID
    let from: CGFloat
    let to: CGFloat
    let color: Color
    let icon: String
    let iconAngleDegrees: CGFloat

    init(
        id: UUID = UUID(),
        from: CGFloat,
        to: CGFloat,
        color: Color,
        icon: String,
        iconAngleDegrees: CGFloat
    ) {
        self.id = id
        self.from = from
        self.to = to
        self.color = color
        self.icon = icon
        self.iconAngleDegrees = iconAngleDegrees
    }
}


