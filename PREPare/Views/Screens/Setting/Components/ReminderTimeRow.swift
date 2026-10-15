import SwiftUI

/// Settings row with an inline time picker for the daily reminder.
struct ReminderTimeRow: View {
    @Binding var time: Date

    var body: some View {
        HStack(spacing: 14) {
            SettingIcon(systemName: "clock")

            VStack(alignment: .leading, spacing: 2) {
                Text("Reminder Time")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(Color.slate900)

                Text("Every day at this time")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.slate500)
            }

            Spacer(minLength: 8)

            DatePicker("Reminder Time", selection: $time, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .tint(.primaryColor)
        }
        .settingCard()
    }
}

#Preview {
    ReminderTimeRow(time: .constant(Date()))
        .padding()
        .background(Color(UIColor.systemGroupedBackground))
}
