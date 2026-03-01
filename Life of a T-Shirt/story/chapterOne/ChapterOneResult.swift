//
//  ChapterOneResult.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-28.
//

import SwiftUI

struct ChapterOneResult: View {
@EnvironmentObject var setting: Settings

        var body: some View {
            VStack {
                Text("So far...")
                
                // small stats
                
                
                Button("Next") {
                    setting.progress.goTo(chapter: .two, page: 1)
                }
                .buttonStyle(ButtonCustom())
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 20)
            }.notebookBackground()
        }
    }
#Preview {
    ChapterOneResult()
        .environmentObject(Settings())
}
