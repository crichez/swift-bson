// Generated using Sourcery 1.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

@resultBuilder
public struct DocBuilder {
    public static func buildBlock<T: DocComponent>(_ t: T) -> T {
        t
    }

    public static func buildBlock<T0, T1> (_ t0: T0, _ t1: T1) -> some DocComponent
    where T0 : DocComponent, T1 : DocComponent {
        Tuple2(t0, t1)
    }

    public static func buildBlock<T0, T1, T2> (_ t0: T0, _ t1: T1, _ t2: T2) -> some DocComponent
    where T0 : DocComponent, T1 : DocComponent, T2 : DocComponent {
        Tuple3(t0, t1, t2)
    }

    public static func buildBlock<T0, T1, T2, T3> (_ t0: T0, _ t1: T1, _ t2: T2, _ t3: T3) -> some DocComponent
    where T0 : DocComponent, T1 : DocComponent, T2 : DocComponent, T3 : DocComponent {
        Tuple4(t0, t1, t2, t3)
    }

    public static func buildBlock<T0, T1, T2, T3, T4> (_ t0: T0, _ t1: T1, _ t2: T2, _ t3: T3, _ t4: T4) -> some DocComponent
    where T0 : DocComponent, T1 : DocComponent, T2 : DocComponent, T3 : DocComponent, T4 : DocComponent {
        Tuple5(t0, t1, t2, t3, t4)
    }

    public static func buildBlock<T0, T1, T2, T3, T4, T5> (_ t0: T0, _ t1: T1, _ t2: T2, _ t3: T3, _ t4: T4, _ t5: T5) -> some DocComponent
    where T0 : DocComponent, T1 : DocComponent, T2 : DocComponent, T3 : DocComponent, T4 : DocComponent, T5 : DocComponent {
        Tuple6(t0, t1, t2, t3, t4, t5)
    }

    public static func buildBlock<T0, T1, T2, T3, T4, T5, T6> (_ t0: T0, _ t1: T1, _ t2: T2, _ t3: T3, _ t4: T4, _ t5: T5, _ t6: T6) -> some DocComponent
    where T0 : DocComponent, T1 : DocComponent, T2 : DocComponent, T3 : DocComponent, T4 : DocComponent, T5 : DocComponent, T6 : DocComponent {
        Tuple7(t0, t1, t2, t3, t4, t5, t6)
    }

    public static func buildBlock<T0, T1, T2, T3, T4, T5, T6, T7> (_ t0: T0, _ t1: T1, _ t2: T2, _ t3: T3, _ t4: T4, _ t5: T5, _ t6: T6, _ t7: T7) -> some DocComponent
    where T0 : DocComponent, T1 : DocComponent, T2 : DocComponent, T3 : DocComponent, T4 : DocComponent, T5 : DocComponent, T6 : DocComponent, T7 : DocComponent {
        Tuple8(t0, t1, t2, t3, t4, t5, t6, t7)
    }

    public static func buildBlock<T0, T1, T2, T3, T4, T5, T6, T7, T8> (_ t0: T0, _ t1: T1, _ t2: T2, _ t3: T3, _ t4: T4, _ t5: T5, _ t6: T6, _ t7: T7, _ t8: T8) -> some DocComponent
    where T0 : DocComponent, T1 : DocComponent, T2 : DocComponent, T3 : DocComponent, T4 : DocComponent, T5 : DocComponent, T6 : DocComponent, T7 : DocComponent, T8 : DocComponent {
        Tuple9(t0, t1, t2, t3, t4, t5, t6, t7, t8)
    }

    public static func buildBlock<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9> (_ t0: T0, _ t1: T1, _ t2: T2, _ t3: T3, _ t4: T4, _ t5: T5, _ t6: T6, _ t7: T7, _ t8: T8, _ t9: T9) -> some DocComponent
    where T0 : DocComponent, T1 : DocComponent, T2 : DocComponent, T3 : DocComponent, T4 : DocComponent, T5 : DocComponent, T6 : DocComponent, T7 : DocComponent, T8 : DocComponent, T9 : DocComponent {
        Tuple10(t0, t1, t2, t3, t4, t5, t6, t7, t8, t9)
    }

    public static func buildEither<T>(first component: T) -> T where T : DocComponent {
        component
    }

    public static func buildEither<T>(second component: T) -> T where T : DocComponent {
        component
    }

    public static func buildOptional<T>(_ component: T?) -> some DocComponent where T : DocComponent {
        OptionalComponent(component)
    }

    public static func buildLimitedAvailability<T>(_ component: T) -> T where T : DocComponent {
        component
    }
}