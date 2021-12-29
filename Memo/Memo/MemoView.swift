//
//  MemoView.swift
//  Memo
//
//  Created by 宮本大新 on 2021/12/29.
//

import SwiftUI

struct MemoView: View {
    @ObservedObject var viewModel : ViewModel
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Back")
                    }
                    Spacer()
                    Button(action: {
                        viewModel.CreateMemo(context: context)
                    }) {
                        Text("Save")
                            .foregroundColor(viewModel.title == "" ? Color.gray : .blue)
                    }
                    .disabled(viewModel.title == "" ? true : false)
                }
                .padding(.vertical)
                .padding(.horizontal)
                ZStack(alignment: .topLeading) {
                    if viewModel.title.isEmpty {
                        Text("Title")
                            .font(.system(size: 30, weight: .black, design: .default))
                            .foregroundColor(.gray)
                            .padding(.top, 2)
                            .padding(.leading, 3)
                    }
                    TextField("", text: $viewModel.title)
                        .font(.system(size: 30, weight: .black, design: .default))
                }
                .padding(.horizontal)

                ZStack(alignment: .topLeading) {
                    if viewModel.text.isEmpty {
                        Text("Text")
                            .font(.system(size: 15, weight: .bold, design: .default))
                            .foregroundColor(.gray)
                            .padding(.top, 7)
                            .padding(.leading, 5)
                    }
                    TextEditor(text: $viewModel.text)
                        .font(.system(size: 15, weight: .bold, design: .default))
                        .frame(height: geo.size.height-100, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.top)
                .padding(.horizontal)
                Spacer()
            }
            .onAppear() {
                UITextView.appearance().backgroundColor = .clear
            }
            .onDisappear() {
                UITextView.appearance().backgroundColor = nil
            }
        }
    }
}
