//
//  ContentView.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var path: [DeviceData] = [] // Navigation path
    
    // Serach Field View
    var searchField: some View{
        TextField(text: $viewModel.searchText) {
            Text("Search Devices")
                .opacity(0.5)
            
        }.frame(height: 45)
            .padding(.horizontal, 30)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.1))
                    .padding(.horizontal, 20)
            }
    }
    
    // Empty Message View
    @ViewBuilder func getEmptyDataMessage(_ msg: String) -> some View{
        VStack{
            Text(msg)
        }.frame(maxHeight: .infinity)
    }
    
    // Main Body View
    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if viewModel.deviceData.count > 0 && viewModel.errorMessage == nil {
                    VStack{
                        searchField
                        if viewModel.deviceData.count > 0 {
                            DevicesList(devices: $viewModel.deviceData, onSelect : { selectedComputer in
                                path.append(selectedComputer)
                            }, onRefresh :{
                                viewModel.fetchDeviceData(true)
                            })
                        } else {
                            getEmptyDataMessage("No Data Available")
                        }
                    }
                } else {
                    if let errMsg = viewModel.errorMessage{
                        getEmptyDataMessage(errMsg)
                    } else {
                        ProgressView("Loading...")
                    }
                }
            }
            .navigationTitle("Devices")
            .navigationDestination(for: DeviceData.self) { computer in
                DetailView(device: computer)
            }
            .onAppear {
                viewModel.fetchDeviceData()
            }
        }
    }
}

#Preview {
    ContentView()
}
