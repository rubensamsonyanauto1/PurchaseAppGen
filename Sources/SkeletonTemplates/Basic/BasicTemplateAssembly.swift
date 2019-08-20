import Foundation

struct BasicTemplateAssembly: Template {
    let fileNameSuffix = "Assembly"
    let content =
        """
        import Model
        import RxSwift
        import A1Common
        import Swinject
        import EventResponder

        extension $NAME$ {
            struct Assembly: Swinject.Assembly {
                func assemble(container: Container) {
                    container.register(Context.self) { resolver in
                        Context(translator: resolver.resolve())
                    }

                    container.register(ViewModelFactory.self) { (resolver, responder: RxEventResponder, data: InputData) in {
                        ViewModel(
                            context: resolver.resolve(),
                            viewEvents: $0,
                            data: data,
                            eventResponder: responder
                            )
                    }
                    }

                    container.register($NAME$ViewController.self) { (resolver, responder: RxEventResponder, data: InputData) in
                        let controller = $NAME$ViewController()
                        controller.set(makeViewModel: resolver.resolve(arguments: responder, data))
                        return controller
                    }
                }
            }
        }

        extension Resolver {
            func resolve$NAME$ViewController(data: $NAME$.InputData, responder: RxEventResponder) -> $NAME$ViewController {
                return resolve(arguments: responder, data)
            }
        }

        """
}
