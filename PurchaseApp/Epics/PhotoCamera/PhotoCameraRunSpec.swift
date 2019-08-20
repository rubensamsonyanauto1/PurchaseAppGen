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
        print("event \(event)")
        return nil
    }
}

private struct MockAssembly: Assembly {
    public func assemble(container: Container) {
        container.register(PhotoCamera.Context.self) { _ in
            PhotoCamera.Context(translator: .just(LocalizationMock()))
        }
    }
}

final class PhotoCameraRunSpec: QuickSpec {
    override func spec() {
        let builder = RxEventResponderBuilder(withHandlers: RunSpecEventHandler(), isEnabled: .just(true))

        let resolver = Assembler([
            PhotoCamera.Assembly(),
            HandlersAssembly(),
            MockAssembly()]).resolver

        runSpec {
            let viewController = UIViewController()
            let handler = resolver.resolveHandler(with: .photoCamera, viewController: viewController)

            UIWindow.showWindow(with: viewController)

            _ = handler.handleOrReturn(
                event: PhotoCamera.PresentEvent.present(
                    data: PhotoCamera.InputData(),
                    responder: builder.build()),
                outputResponder: builder.build())
        }
    }
}