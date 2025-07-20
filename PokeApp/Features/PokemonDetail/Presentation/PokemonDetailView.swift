import SwiftUI

struct PokemonDetailView: View {
    @ObservedObject var viewModel: PokemonDetailViewModel

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            } else {
                detailContent
            }
        }
        .padding()
        .navigationTitle(viewModel.entity.name)
        .navigationBarTitleDisplayMode(.inline)
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
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}