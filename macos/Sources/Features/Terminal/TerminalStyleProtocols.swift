/// Protocol for responders that need to update their appearance when terminal window
/// state or configuration changes.
///
/// Views conforming to this protocol receive notifications when:
/// - The window's key status changes (active/inactive)
/// - The Ghostty configuration is updated
///
/// Typically, `BaseTerminalController` receives these notifications and propagates
/// them to child views that conform to this protocol.
///
/// When implementing cascading updates, update own state first, then notify
/// dependent components to avoid circular dependencies.
protocol TerminalStyleResponder: AnyObject {
    /// Called when the window's key status changes.
    ///
    /// - Parameters:
    ///   - isKeyWindow: `true` if the window became key, `false` if it resigned.
    ///   - sender: The object that initiated the notification, or `nil` if not applicable.
    @MainActor func keyWindowStatusDidChange(_ isKeyWindow: Bool, sender: Any?)

    /// Called when the Ghostty configuration has been updated.
    ///
    /// Re-evaluate any configuration-dependent styling such as colors, opacity,
    /// blur effects, or other visual properties.
    ///
    /// - Parameters:
    ///   - newConfig: The updated configuration to apply.
    ///   - sender: The object that initiated the notification, or `nil` if not applicable.
    @MainActor func ghosttyConfigurationDidChange(_ newConfig: Ghostty.Config, sender: Any?)
}

extension TerminalStyleResponder {
    func keyWindowStatusDidChange(_ isKeyWindow: Bool, sender: Any?) {}
    func ghosttyConfigurationDidChange(_ newConfig: Ghostty.Config, sender: Any?) {}
}

/// Protocol for objects that can provide style information.
///
/// Conforming types expose visual properties that a responder (such as `TerminalStyleResponder`)
/// can query when updating its appearance — for example, reading a window's preferred background
/// color when configuring a glass effect tint.
protocol TerminalStyleProvider: AnyObject {
    /// The background color that this object prefers be used for styling purposes.
    var preferredBackgroundColor: OSColor? { get }

    /// The cornerRadius that this object prefers be used for styling purposes.
    var cornerRadius: CGFloat? { get }
}

extension TerminalStyleProvider {
    var preferredBackgroundColor: OSColor? { nil }
    var cornerRadius: CGFloat? { nil }
}
