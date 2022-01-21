//
//  Observables.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/20/22.
//

import Foundation


public final class TrueNorthObservable<Value>{
    
    struct Observer<Value> {
        weak var observer: AnyObject?
        let block: (Value) -> Void
    }
    
    private var observers = [Observer<Value>]()
    public var value: Value {
        didSet { notifyObservers() }
    }
    
    public init(_ value: Value){
        self.value = value
    }
    
    public func observe(on observer: AnyObject, observerBlock: @escaping (Value) -> Void){
        observers.append(Observer(observer: observer, block: observerBlock))
        observerBlock(self.value)
    }
    
    public func remove(observer: AnyObject) {
        observers = observers.filter{ $0.observer !== observer }
    }
    
    private func notifyObservers(){
        for observer in observers {
            observer.block(self.value)
        }
    }
    
}
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
