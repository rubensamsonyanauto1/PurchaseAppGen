import Foundation

struct BasicTemplateRunSpec: Template {
    let fileNameSuffix = "RunSpec"
    let content =
        """
        import Quick
        import Nimble
        import RxSwift
        import RxCocoa
        import Swinject
        import Model

        @testable import PurchaseApp
        @testable import EventResponder
        @testable import A1Common

        private final class RunSpecEventHandler: EventHandler {
            func handleOrReturn(event: EventType, outputResponder: RxEventResponder) -> EventType? {
                print("event \\(event)")
                return nil
            }
        }

        private struct MockAssembly: Assembly {
            public func assemble(container: Container) {
                container.register($NAME$.Context.self) { _ in
                    $NAME$.Context(translator: .just(LocalizationMock()))
                }
            }
        }

        final class $NAME$RunSpec: QuickSpec {
            override func spec() {
                let builder = RxEventResponderBuilder(withHandlers: RunSpecEventHandler(), isEnabled: .just(true))

                let resolver = Assembler([
                    $NAME$.Assembly(),
                    HandlersAssembly(),
                    MockAssembly()]).resolver

                runSpec {
                    let viewController = UIViewController()
                    let handler = resolver.resolveHandler(with: .$CAMELCASED_NAME$, viewController: viewController)

                    UIWindow.showWindow(with: viewController)

                    _ = handler.handleOrReturn(
                        event: $NAME$.PresentEvent.present($NAME$.InputData()),
                        outputResponder: builder.build()
                    )
                }
            }
        }

        """
}
