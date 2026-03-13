import Testing
@testable import Tachikoma

struct ModelParsingTests {
    @Test
    func `parse GPT-5 mini alias`() {
        let parsed = LanguageModel.parse(from: "gpt-5-mini")
        #expect(parsed == .openai(.gpt5Mini))
    }

    @Test
    func `parse GPT-5.1 base model`() {
        let parsed = LanguageModel.parse(from: "gpt-5.1")
        #expect(parsed == .openai(.gpt51))
    }

    @Test
    func `parse GPT-5.2 base model`() {
        let parsed = LanguageModel.parse(from: "gpt-5.2")
        #expect(parsed == .openai(.gpt52))
    }

    @Test
    func `parse GPT-5.1 nano alias`() {
        let parsed = LanguageModel.parse(from: "gpt51-nano")
        #expect(parsed == .openai(.gpt5Nano))
    }

    @Test
    func `parse Claude Sonnet 4.5 snapshot id`() {
        let parsed = LanguageModel.parse(from: "claude-sonnet-4-5-20250929")
        #expect(parsed == .anthropic(.sonnet45))
    }

    @Test
    func `parse shorthand Claude alias`() {
        let parsed = LanguageModel.parse(from: "claude")
        #expect(parsed == .anthropic(.sonnet45))
    }

    @Test
    func `parse Gemini 3 Flash model id`() {
        let parsed = LanguageModel.parse(from: "gemini-3-flash")
        #expect(parsed == .google(.gemini3Flash))
    }

    @Test
    func `parse shorthand Gemini alias`() {
        let parsed = LanguageModel.parse(from: "gemini")
        #expect(parsed == .google(.gemini3Flash))
    }
}
