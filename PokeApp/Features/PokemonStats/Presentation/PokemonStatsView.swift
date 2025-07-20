import SwiftUI
import Charts

struct PokemonStatsView: View {
    @ObservedObject var viewModel: PokemonStatsViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                Text("Base Stats")
                    .font(.title2.bold())

                Chart {
                    ForEach(viewModel.stats, id: \.name) { stat in
                        BarMark(
                            x: .value("Stat", stat.name),
                            y: .value("Value", stat.value)
                        )
                        .foregroundStyle(.blue.gradient)
                    }
                }
                .frame(height: 200)

                Divider()

                Text("Types")
                    .font(.title2.bold())
                HStack {
                    ForEach(viewModel.types, id: \.self) { type in
                        Text(type)
                            .padding(8)
                            .background(Color.orange.opacity(0.2))
                            .cornerRadius(10)
                    }
                }

                Divider()

                Text("Abilities")
                    .font(.title2.bold())
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(viewModel.abilities, id: \.self) { ability in
                        Text(ability)
                    }
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle(viewModel.pokemon.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}