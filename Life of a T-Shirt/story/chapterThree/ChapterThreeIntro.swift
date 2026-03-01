
import SwiftUI

struct ChapterThreeIntro: View {
    @EnvironmentObject var setting: Settings

    var body: some View {
        VStack{
            Text("Chapter Three: The Choice")
            Text("You've worn your T-shirt many times. It’s been with you through different days and memories.")
            Text("But with every wear and wash, the fibers slowly weaken. This is a normal part of a garment’s life.")
            
            Button("Continue") {
                setting.progress.goTo(chapter: .three, page: 2)
            }.buttonStyle(ButtonCustom())
        }.notebookBackground()
    }
}
#Preview {
    ChapterThreeIntro()
        .environmentObject(Settings())
}
