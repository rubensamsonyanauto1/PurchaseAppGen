import Swinject
import EventResponder

extension PhotoCamera {
    final class NavigationHandler: SwinjectNavigator, NavigationEventHandler {
        func handleOrReturn(event: PresentEvent, viewController: UIViewController, outputResponder: RxEventResponder) -> EventType? {
            switch event {
            case let .present(data):
                let controller = resolver.resolvePhotoCameraViewController(data: data, responder: outputResponder)
                viewController.present(controller, animated: true)
                return nil
            }
        }
    }
}