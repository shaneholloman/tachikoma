import Testing
@testable import Tachikoma

struct AnthropicMessageEncodingTests {
    @Test
    func `encodes string without quotes`() {
        let value = AnyAgentToolValue(string: "hello")
        #expect(AnthropicMessageEncoding.encodeToolResult(value) == "hello")
    }

    @Test
    func `encodes booleans and numbers`() {
        #expect(AnthropicMessageEncoding.encodeToolResult(AnyAgentToolValue(bool: true)) == "true")
        #expect(AnthropicMessageEncoding.encodeToolResult(AnyAgentToolValue(int: 42)) == "42")
        #expect(AnthropicMessageEncoding.encodeToolResult(AnyAgentToolValue(double: 3.5)) == "3.5")
    }

    @Test
    func `encodes objects as JSON`() {
        let object = AnyAgentToolValue(object: [
            "name": AnyAgentToolValue(string: "Peekaboo"),
            "count": AnyAgentToolValue(int: 2),
        ])
        #expect(AnthropicMessageEncoding.encodeToolResult(object) == "{\"count\":2,\"name\":\"Peekaboo\"}")
    }

    @Test
    func `encodes arrays and null values`() {
        let array = AnyAgentToolValue(array: [AnyAgentToolValue(int: 1), AnyAgentToolValue(int: 2)])
        #expect(AnthropicMessageEncoding.encodeToolResult(array) == "[1,2]")

        let nullValue = AnyAgentToolValue(null: ())
        #expect(AnthropicMessageEncoding.encodeToolResult(nullValue) == "null")
    }
}
