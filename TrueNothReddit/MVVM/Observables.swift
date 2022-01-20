//
//  Observables.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/20/22.
//

import Foundation


public final class TrueNorthObservableWhenValueChange<T: Equatable> {
    
    struct Observer<T> {
        weak var observer: AnyObject?
        let block: (T) -> Void
    }
    
    private var observers = [Observer<T>]()
    public var value: T {
        didSet { notifyObserversIfNeeded(oldValue: oldValue, value: value)}
    }
    
    public init(_ value: T){
        self.value = value
    }
    
    public func observeChangesAndReadCurrent(on observer: AnyObject, observerBlock: @escaping (T) -> Void) {
        observers.append(Observer(observer: observer, block: observerBlock))
        observerBlock(self.value)
    }
    
    public func observeChanges(on observer: AnyObject, observerBlock: @escaping (T) -> Void){
        observers.append(Observer(observer: observer, block: observerBlock))
    }
    
    public func remove(observer: AnyObject){
        observers = observers.filter { $0.observer !== observer}
    }
    
    public func simulateChange(){
        observers.forEach {$0.block(value) }
    }
    
    public func notifyObserversIfNeeded(oldValue: T, value: T){
        guard value != oldValue else { return }
        observers.forEach { $0.block(value)
            
        }
    }
}
