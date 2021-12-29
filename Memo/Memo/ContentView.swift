//
//  ContentView.swift
//  Memo
//
//  Created by 宮本大新 on 2021/12/29.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Memo.index, ascending: true)], animation: .spring()) private var results: FetchedResults<Memo>
    @State var TrashMemo: FetchedResults<Memo>.Element = FetchedResults<Memo>.Element()
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if results.isEmpty {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("メモがありません。")
                            .fontWeight(.black)
                            .font(.system(size: 35))
                        Spacer()
                    }
                    Spacer()
                }
            } else {
                List(results) { memo in
                    Button(action: {
                        viewModel.EditMemo(item: memo)
                    }) {
                        HStack {
                            Text(memo.title)
                            Spacer()
                            Button(action: {
                                context.delete(memo)
                                try! context.save()
                            }) {
                                Image(systemName: "xmark")
                            }
                            .padding(.trailing, 10)
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
            Button(action: {
                viewModel.Item = nil
                viewModel.title = ""
                viewModel.text = ""
                viewModel.isNewMemo.toggle()
            }) {
                ZStack {
                    Circle()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.blue)
                        .padding()
                    Image(systemName: "plus")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                }
            }
        }
        .fullScreenCover(isPresented: $viewModel.isNewMemo) {
            MemoView(viewModel: viewModel)
        }
    }
}
