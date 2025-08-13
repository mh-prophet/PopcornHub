//
//  HomeView.swift
//  PopcornHub
//
//  Created by Mohd on 12/08/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeViewModel()
    var body: some View {
        NavigationStack {
            MovieGridView()
                .environmentObject(vm)
                .navigationTitle("Popular Movies")
                .navigationBarTitleDisplayMode(.large)
                .searchable(text: $vm.searchText, prompt: "Search movies...")
                .task { vm.loadMovies() }
                .onSubmit(of: .search) {
                    vm.search()
                }
                .onChange(of: vm.searchText, { _ , newValue in
                    if newValue.isEmpty {
                        vm.loadMovies()
                    }

                })
                .overlay {
                    ZStack {
                        if vm.isLoading{
                            Color.black.opacity(0.5).ignoresSafeArea()
                            ProgressView().progressViewStyle(.circular).tint(.white)
                        }
                    }
                }
                .alert(isPresented: Binding<Bool>(
                    get: { vm.errorMessage != nil },
                    set: { _ in vm.errorMessage = nil }
                )) {
                    Alert(title: Text("Error"), message: Text(vm.errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
