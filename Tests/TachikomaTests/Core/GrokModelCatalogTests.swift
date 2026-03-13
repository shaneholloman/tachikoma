import Foundation
import Testing
@testable import Tachikoma

struct GrokModelCatalogTests {
    private static let catalog: [Model.Grok] = [
        .grok4,
        .grok4FastReasoning,
        .grok4FastNonReasoning,
        .grokCodeFast1,
        .grok3,
        .grok3Mini,
        .grok2,
        .grok2Vision,
        .grok2Image,
        .grokVisionBeta,
        .grokBeta,
    ]

    private func requireModernPlatforms(_ body: () throws -> Void) rethrows {
        if #available(macOS 13.0, iOS 16.0, tvOS 16.0, watchOS 9.0, *) {
            try body()
        } else {
            Issue.record("ModelSelector requires macOS 13.0+ / iOS 16.0+")
        }
    }

    @Test
    func `CaseIterable reflects the official Grok catalog`() {
        self.requireModernPlatforms {
            #expect(Model.Grok.allCases == Self.catalog)
        }
    }

    @Test
    func `ModelSelector parses every Grok model identifier`() throws {
        try self.requireModernPlatforms {
            for model in Self.catalog {
                let parsed = try ModelSelector.parseModel(model.modelId)
                #expect(parsed == .grok(model))
            }
        }
    }

    @Test
    func `Available-model CLI listing matches catalog IDs`() {
        self.requireModernPlatforms {
            let listed = Set(ModelSelector.availableModels(for: "grok"))
            let expected = Set(Self.catalog.map(\.modelId))
            #expect(listed == expected)
        }
    }

    @Test
    func `Vision capability only flips on for vision/image Grok models`() {
        self.requireModernPlatforms {
            let visionModels: Set<Model.Grok> = [.grok2Vision, .grok2Image, .grokVisionBeta]

            for model in Self.catalog {
                let languageModel = Model.grok(model)
                #expect(languageModel.supportsVision == visionModels.contains(model))
            }
        }
    }
}
