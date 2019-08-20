import Model
import RxSwift
import A1Common
import Swinject
import EventResponder

extension PhotoCamera {
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

            container.register(PhotoCameraViewController.self) { (resolver, responder: RxEventResponder, data: InputData) in
                let controller = PhotoCameraViewController()
                controller.set(makeViewModel: resolver.resolve(arguments: responder, data))
                return controller
            }
        }
    }
}

extension Resolver {
    func resolvePhotoCameraViewController(data: PhotoCamera.InputData, responder: RxEventResponder) -> PhotoCameraViewController {
        return resolve(arguments: responder, data)
    }
}