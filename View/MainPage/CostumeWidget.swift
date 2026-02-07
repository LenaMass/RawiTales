import SwiftUI

struct HeroRingWidget: View {
    @ObservedObject var vm: HeroRingWidgetViewModel

    var body: some View {
        ZStack {
            ZStack {
                ForEach(vm.segments) { seg in
                    Circle()
                        .trim(from: seg.from, to: seg.to)
                        .stroke(seg.color, style: StrokeStyle(lineWidth: vm.lineWidth, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                }

                ForEach(vm.segments) { seg in
                    Group {
                        let rad = (seg.iconAngleDegrees - 90) * .pi / 180
                        let x = cos(rad) * vm.iconRadius
                        let y = sin(rad) * vm.iconRadius

                        RingIcon(symbol: seg.icon)
                            .offset(x: x, y: y)
                    }
                }
            }

            Circle()
                .fill(Color.clear)
//                .frame(width: vm.centerSize, height: vm.centerSize)
                .overlay(
                    Image("grandpa")
                )
        }
        .frame(width: vm.ringWidth, height: vm.ringHeight)
    }
}

private struct RingIcon: View {
    let symbol: String

    var body: some View {
        Image(systemName: symbol)
            .font(.system(size: 12, weight: .semibold))
            .foregroundStyle(.black.opacity(0.6))
            .frame(width: 20, height: 20)
            .background {
                Circle().fill(Color.clear).glassEffect(.clear)
            }
            .overlay {
                Circle().strokeBorder(.white.opacity(0.18), lineWidth: 1)
            }
    }
}

#Preview {
    ZStack {
        Color.black.opacity(0.9).ignoresSafeArea()
        HeroRingWidget(vm: .preset)
    }
}


