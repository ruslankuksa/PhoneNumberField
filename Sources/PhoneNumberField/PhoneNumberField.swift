import SwiftUI

public struct PhoneNumberField: View {
    
    @State private var model = PhoneNumberModel()
    @Binding public var input: String
    
    public init(input: Binding<String>) {
        self._input = input
    }
    
    public var body: some View {
        HStack(spacing: 3) {
            if model.showPrefix {
                Text(model.prefix)
            }
            
            TextField("Phone number", text: $model.phoneNumber, prompt: Text(model.placeholder))
                .onChange(of: model.phoneNumber) {
                    model.handleInput()
                    input = model.fullPhoneNumber
                }
        }
        .padding(8)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay {
            switch model.fieldStyle {
            case .plain:
                EmptyView()
            case .rounded:
                roundedStyleOverlay()
            }
        }
    }
    
    private func roundedStyleOverlay() -> some View {
        RoundedRectangle(cornerRadius: 8)
            .strokeBorder(model.roundBorderedStyleColor, lineWidth: 1)
    }
}

extension PhoneNumberField {
    
    public func showPrefix(_ value: Bool) -> PhoneNumberField {
        model.togglePrefixPresentation(value)
        return self
    }
    
    public func borderColor(_ color: Color) -> PhoneNumberField {
        model.setRoundBorderedStyleColor(color)
        return self
    }
    
    public func style(_ style: FieldStyle) -> PhoneNumberField {
        model.setStyle(style)
        return self
    }
    
    public func placeholder(_ value: String) -> PhoneNumberField {
        model.setPlaceholder(value)
        return self
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var number = ""
        
        var body: some View {
            VStack {
                PhoneNumberField(input: $number)
                    .showPrefix(true)
                    .style(.rounded)
                    .borderColor(.blue)
                    .padding(.horizontal, 32)
                
                Text(number)
            }
        }
    }
    return PreviewWrapper()
}
