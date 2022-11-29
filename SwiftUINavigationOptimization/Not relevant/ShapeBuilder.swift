//
//  ShapeBuilder.swift
//  Capture
//
//  Created by Jean-Baptiste Beau on 02/07/2022.
//  Copyright © 2022 Sublime. All rights reserved.
//

// from: https://github.com/ohitsdaniel/ShapeBuilder/

import SwiftUI

#if swift(>=5.4)
@resultBuilder
public enum ShapeBuilder {
  public static func buildBlock<S: Shape>(_ builder: S) -> some Shape {
    builder
  }
}
#else
@_functionBuilder
public enum ShapeBuilder {
  public static func buildBlock<S: Shape>(_ builder: S) -> some Shape {
    builder
  }
}
#endif

public extension ShapeBuilder {
  static func buildOptional<S: Shape>(_ component: S?) -> EitherShape<S, EmptyShape> {
    component.flatMap(EitherShape.first) ?? EitherShape.second(EmptyShape())
  }

  static func buildEither<First: Shape, Second: Shape>(first component: First) -> EitherShape<First, Second> {
    .first(component)
  }

  static func buildEither<First: Shape, Second: Shape>(second component: Second) -> EitherShape<First, Second> {
    .second(component)
  }
}

public enum EitherShape<First: Shape, Second: Shape>: Shape {
  case first(First)
  case second(Second)

  public func path(in rect: CGRect) -> Path {
    switch self {
    case let .first(first):
      return first.path(in: rect)
    case let .second(second):
      return second.path(in: rect)
    }
  }
}

public struct EmptyShape: InsettableShape {
  public init() {}

  public func path(in rect: CGRect) -> Path {
    Path()
  }

  public func inset(by amount: CGFloat) -> some InsettableShape {
    self
  }
}
