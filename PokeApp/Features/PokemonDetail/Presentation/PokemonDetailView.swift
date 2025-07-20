//
//  PokemonDetailView.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import SwiftUI

struct PokemonDetailView: View {
    @ObservedObject var viewModel: PokemonDetailViewModel
    var onStatsTap: (() -> Void)? = nil
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else {
                detailContent
            }
        }
        .padding()
        .navigationTitle(viewModel.entity.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.toggleFavorite()
                }) {
                    Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                }
            }
        }
        .alert(isPresented: Binding<Bool>(
            get: { viewModel.errorMessage != nil },
            set: { newValue in
                if !newValue {
                    viewModel.errorMessage = nil
                }
            }
        )) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage ?? "Unknown error"),
                primaryButton: .default(Text("Retry")) {
                    viewModel.retry()
                },
                secondaryButton: .cancel(Text("OK"))
            )
        }
    }

    private var detailContent: some View {
        ScrollView {
            VStack(spacing: 16) {
                if let imageUrl = viewModel.entity.imageUrl,
                   let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 160, height: 160)
                        case .failure:
                            Image(systemName: "photo")
                        @unknown default:
                            EmptyView()
                        }
                    }
                }

                Text("ID: \(viewModel.entity.id)")
                Text("Height: \(viewModel.entity.height)")
                Text("Weight: \(viewModel.entity.weight)")

                HStack{
                    Button(action: {
                        viewModel.toggleFavorite()
                    }) {
                        Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.red)
                            .padding()
                            .background(Color(.systemGray6))
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                    Button("Ver estadísticas") {
                        onStatsTap?()
                    }
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
                    .disabled(!viewModel.isDetailLoaded)
                    .opacity(viewModel.isDetailLoaded ? 1 : 0.5)
                }
                
                Divider()

                Text("Types")
                    .font(.headline)
                ForEach(viewModel.entity.types, id: \.self) { type in
                    Text(type)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
                }

                Divider()

                Text("Stats")
                    .font(.headline)
                ForEach(viewModel.entity.stats, id: \.name) { stat in
                    HStack {
                        Text(stat.name)
                        Spacer()
                        Text("\(stat.value)")
                    }
                }

                Divider()

                Text("Abilities")
                    .font(.headline)
                ForEach(viewModel.entity.abilities, id: \.self) { ability in
                    Text(ability)
                }
            }
            .background(Color.red.opacity(0.5))
            .frame(maxWidth: .infinity, alignment: .leading)
        }.refreshable {
            viewModel.retry()
        }
    }
}
