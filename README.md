# RangeDatePicker

RangeDatePicker is a SwiftUI component that allows the users to select a range of date in an iOS native calendar.
To have it, it uses the native SwiftUI component `MultiDatePicker` as a base.

# Demo

https://github.com/user-attachments/assets/7619a59e-e89a-45b2-85af-4e28a4eb3c5f

# Limitation

Since it is using `MultiDatePicker`, RangeDatePicker supports iOS 16+ and you can customize it as much as the native SwiftUI components allowed it

# Installation

Use Swift Package Manager (SPM), to install it

```
https://github.com/Gregory-Hoareau/RangeDatePicker.git
```

# Usages

Here is an example on how to use it, in your project

```swift
import SwiftUI
import RangeDatePicker

struct MyView: View {
  @State private var dates: Set<DateComponents> = []

  var body: some View {
    RangeDatePicker(dates: $dates)
  }
}
```

I have made the component so it uses the same init parameters as `MultiDatePicker`, but in the future I will add more possible init to it.

## Parameters

| Parameters | Type | Default value | Description |
| ---------- | ---- | ------------- | ----------- |
| title | LocalizedStringKey | "" | The key for the localized title of self, describing its purpose. (Same as `MultiDatePicker`) |
| dates | Binding<Set<DateComponents>> | required | A binding of the selected range of dates |

# License

This project is licensed under the MIT License. See the [LICENSE](https://github.com/Gregory-Hoareau/RangeDatePicker/blob/main/LICENSE) file for details.
