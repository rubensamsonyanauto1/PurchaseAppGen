import Foundation

struct BasicTemplateNavigationHandler: Template {
    let fileNameSuffix = "NavigationHandler"
    let content =
        """
        import Swinject
        import EventResponder

        extension $NAME$ {
            final class NavigationHandler: SwinjectNavigator, NavigationEventHandler {
                func handleOrReturn(event: PresentEvent, viewController: UIViewController, outputResponder: RxEventResponder) -> EventType? {
                    switch event {
                    case let .present(data):
                        let controller = resolver.resolve$NAME$ViewController(data: data, responder: outputResponder)
                        viewController.present(controller, animated: true)
                        return nil
                    }
                }
            }
        }

        """
}
