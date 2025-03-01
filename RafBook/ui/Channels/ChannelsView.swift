import SwiftUI

struct ChannelsView: View {
    @State var viewModel = ChannelsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.currentCategories) { category in
                    CategorySectionView(category: category)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(viewModel.currentStudyProgram?.name ?? "Study program")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        ForEach(viewModel.studyPrograms) { program in
                            Button(action: {
                                viewModel.setCurrentStudyProgram(program)
                            }) {
                                Text(program.name ?? "No name")
                            }
                        }
                    } label: {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                    }
                }
            }
        }
        .task {
            _ = await viewModel.getInitialState()
        }
    }
}

#Preview {
    ChannelsView()
}
