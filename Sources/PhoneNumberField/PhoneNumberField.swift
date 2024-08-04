import SwiftUI

public struct PhoneNumberField: View {
    
    @State private var model = PhoneNumberModel()
    
    public var body: some View {
        HStack(spacing: 3) {
            if model.showPrefix {
                Text(model.prefix)
            }
            
            TextField("Phone number", text: $model.text, prompt: Text(model.placeholder))
                .onChange(of: model.text) {
                    model.textDidChange?(model.fullPhoneNumber)
                    model.handleInput()
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
    
    public func textDidChange(_ onTextChange: @escaping (String) -> Void) -> PhoneNumberField {
        model.setTextDidChangeCallback(onTextChange)
        return self
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var number = ""
        
        var body: some View {
            PhoneNumberField()
                .showPrefix(true)
                .style(.rounded)
                .borderColor(.blue)
                .placeholder("Phone number")
                .textDidChange { text in
                    number = text
                    debugPrint(number)
                }
                .padding(.horizontal)
        }
    }
    return PreviewWrapper()
}
