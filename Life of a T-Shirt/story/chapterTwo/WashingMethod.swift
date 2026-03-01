


import SwiftUI

struct WashingMethod: View {
    @EnvironmentObject var setting: Settings
    //@State var waterSetting: HotOrCold? = nil
    var body: some View {
        VStack {
            
        }.notebookBackground()
    }
}

#Preview {
    WashingMethod()
        .environmentObject(Settings())
}
