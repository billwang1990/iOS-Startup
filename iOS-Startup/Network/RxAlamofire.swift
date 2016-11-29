import Foundation
import RxSwift
import Alamofire
import ObjectMapper

public typealias RxAlamofireJSON = [String: AnyObject]

extension DataRequest {
    func rx_responseObject<T: Mappable>(_ cancelOnDispose: Bool = true, keyPath: String? = nil) -> Observable<T> {
        return Observable.create {
            observer in
            self.responseObject(queue: nil, keyPath: keyPath, mapToObject: nil, context: nil, completionHandler: { (response: DataResponse<T>) in
                
                if response.result.isSuccess {
                    if let value = response.result.value {
                        observer.on(.next(value))
                    }
                    observer.on(.completed)
                } else {
                    if let error = response.result.error {
                        observer.on(.error(error))
                    }
                }
                
            })
            return Disposables.create {
                if (cancelOnDispose == true ) {
                    self.cancel()
                }
            }
        }
    }
    func rx_responseArray<T: Mappable>(_ cancelOnDispose: Bool = true, keyPath: String? = nil) -> Observable<[T]> {
        
        return Observable.create {
            observer in
            self.responseArray(queue: nil, keyPath: keyPath, completionHandler: { (response: DataResponse<[T]>) -> Void in
                if response.result.isSuccess {
                    if let value = response.result.value {
                        observer.on(.next(value))
                    }
                    observer.on(.completed)
                } else {
                    if let error = response.result.error {
                        observer.on(.error(error))
                    }
                }
            })
            return Disposables.create {
                if (cancelOnDispose == true ) {
                    self.cancel()
                }
            }
        }
    }
    
    func rx_responseJSON(_ cancelOnDispose: Bool = true, keyPath: String? = nil) -> Observable<RxAlamofireJSON> {
        return Observable.create {
            observer in
            self.responseJSON(completionHandler: { (response: DataResponse<Any>)  in
                if response.result.isSuccess {
                    if let value = response.result.value as? RxAlamofireJSON {
                        observer.on(.next(value))
                    }
                    observer.on(.completed)
                    
                } else {
                    if let error = response.result.error {
                        observer.on(.error(error))
                    }
                }
            })
            return Disposables.create {
                if(cancelOnDispose) {
                    self.cancel()
                }
            }
        }
    }
}
