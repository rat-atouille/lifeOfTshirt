
import SwiftUI

struct ChapterThreeIntro: View {
    @EnvironmentObject var setting: Settings

    var body: some View {
        VStack{
            VStack {
                Text(highlight("Chapter Three: The Choice", target: "The Choice"))
                    .foregroundColor(.black)
                    .fontWeight(.black)
                    .font(.system(size:50))
                    .padding(.top, 60)
                
                VStack (spacing: 10){
                    Text("You've worn your T-shirt many times.")
                        .foregroundColor(Color(hex: "#1a1a2e").opacity(0.72))
                        .fontWeight(.semibold)
                        .font(.title)
                        .padding(.top, 60)
                    
                    Text("It’s been with you through different days and memories.")
                        .foregroundColor(Color(hex: "#1a1a2e").opacity(0.72))
                        .fontWeight(.semibold)
                        .font(.title)
                    
                    Text("But with every wear and wash, the fibers slowly weaken.")
                        .foregroundColor(Color(hex: "#1a1a2e").opacity(0.72))
                        .fontWeight(.semibold)
                        .font(.title)
                    
                    Text("This is a normal part of a garment’s life.")
                        .foregroundColor(Color(hex: "#1a1a2e").opacity(0.72))
                        .fontWeight(.semibold)
                        .font(.title)
                }
            }.padding(130)
            //  .border(.red, width: 3)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            Button("Continue") {
                setting.progress.goTo(chapter: .three, page: 2)
            }.buttonStyle(ButtonCustom())
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, 25)
                .padding(.vertical, 25)
        }.notebookBackground()
    }
}
#Preview {
    ChapterThreeIntro()
        .environmentObject(Settings())
}
