//
//  PokemonStatsView.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import SwiftUI
import Charts

enum ChartType: String, CaseIterable, Identifiable {
    case bar = "Bar Chart"
    case line = "Line Chart"
    case pie = "Pie Chart"

    var id: String { rawValue }
}

struct PokemonStatsView: View {
    @ObservedObject var viewModel: PokemonStatsViewModel
    @State private var selectedChart: ChartType = .bar

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Estadísticas de \(viewModel.pokemon.name)")
                .font(.title.bold())

            Picker("Chart Type", selection: $selectedChart) {
                ForEach(ChartType.allCases) { chart in
                    Text(chart.rawValue).tag(chart)
                }
            }
            .pickerStyle(.segmented)
            .padding(.bottom)

            chartView
                .frame(height: 300)

            Spacer()
        }
        .padding()
        .navigationTitle(viewModel.pokemon.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private var chartView: some View {
        switch selectedChart {
        case .bar:
            Chart {
                ForEach(viewModel.stats, id: \.name) { stat in
                    BarMark(
                        x: .value("Stat", stat.name),
                        y: .value("Value", stat.value)
                    )
                    .foregroundStyle(.blue.gradient)
                }
            }

        case .line:
            Chart {
                ForEach(viewModel.stats, id: \.name) { stat in
                    LineMark(
                        x: .value("Stat", stat.name),
                        y: .value("Value", stat.value)
                    )
                    .foregroundStyle(.green)
                }
            }

        case .pie:
            Chart {
                ForEach(viewModel.stats, id: \.name) { stat in
                    SectorMark(
                        angle: .value("Value", stat.value),
                        innerRadius: .ratio(0.5),
                        angularInset: 2
                    )
                    .foregroundStyle(by: .value("Stat", stat.name))
                }
            }
        }
    }
}
