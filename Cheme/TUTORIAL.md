## Declare a variable

Cheme only support `int` and `char` now, as `char` is a alias for `int`, so there're no difference between them. You can use `int` or `char` keywords to declare the variable.

```cheme
(int a)  ;;; declare a local variable a
(char b) ;;; declare a local variable b
```

You can use `global` keywords to declare a global variable.

```cheme
(global int _initd?)
(global int _pi)
```

## Assignment

```cheme
(int a)
(set a 5)
(set b 6)

(set (int a) 5)
```

## If expression

```cheme
(if cond-exp then-clause [alternate])
```

## For expression

```cheme
(for init-expression check-exp increte-exp [body])
```

## Function Declare

```cheme
(function function-name (arg-list)
  function-body)
```

```cheme
(function (int fib) ((int x))
  (if (or (= x 0) (= x 1))
    (ret 1)
    (ret (+ (fib (- x 1))
            (fib (- x 2))))))
```

Mostly, it can be translated into following C code:

```c
int fib(int x)
{
	if (x == 0 || x == 1)
		return 1;
	else
		return fib(x - 1) + fib(x - 2);
}
```

Ignoreless the type, the scheme version of this cheme codes is like following:

```scheme
(define (fib x)
  (if (or (= x 0) (= x 1))
    1
    (+ (fib (- x 1))
       (fib (- x 2)))))
```