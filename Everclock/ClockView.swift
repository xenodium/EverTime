import SwiftUI

struct ClockView: View {

  @State var time = "--:--"

  @State var closeEnabled = false

  let formatter = DateFormatter()
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

  var body: some View {
    GeometryReader { geometry in
      ZStack {
        VStack {
          Text(self.time)
            .onReceive(self.timer) { input in
              formatter.locale = Locale.current
              formatter.timeStyle = .short
              self.time = formatter.string(from: input)
            }
            .font(
              Font.system(
                size: (pow(geometry.size.width, 2)
                  + pow(geometry.size.height, 2)).squareRoot() / 4
              ).bold()
            )
            .padding()
        }.frame(width: geometry.size.width, height: geometry.size.height)
          .background(Color.black)
          .cornerRadius(10)
          .frame(maxWidth: .infinity, maxHeight: .infinity)

        if self.closeEnabled {
          VStack {
            HStack {
              Spacer()
              Button(action: {
                NSApplication.shared.terminate(nil)
              }) {
                Image(systemName: "xmark")
                  .font(.system(size: 10, weight: .bold))
                  .foregroundColor(.white)
                  .frame(width: 18, height: 18)
                  .background(
                    Circle()
                      .fill(Color.red)
                  )
              }
              .buttonStyle(PlainButtonStyle())
            }.padding(.horizontal, 5)

            Spacer()
          }
          .padding(.vertical, 5)
        }
      }
      .onHover {
        self.closeEnabled = $0
      }
    }
  }
}
