//
//  ComputerList.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI

struct DevicesList: View {
    @Binding var devices: [DeviceData]
    let onSelect: (DeviceData) -> Void // Callback for item selection
    let onRefresh: () -> Void // Callback for refresh
    var body: some View {
        List(devices) { device in
            Button {
                onSelect(device)
            } label: {
                VStack(alignment: .leading) {
                    AssignmentText(text: device.name)
                }
            }
        }.refreshable {
            onRefresh()
        }
    }
}
