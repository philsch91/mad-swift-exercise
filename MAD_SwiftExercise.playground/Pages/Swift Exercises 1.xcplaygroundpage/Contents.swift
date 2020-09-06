//: # Swift Exercise
//: Welcome to the Swift Exercise. This document is an interactive Playground. The goal of this exercise is to familiarize yourself with the Swift syntax, terminology and concepts.
//:
//: If this text you're currently reading is being displayed as a code comment with `//:`, you can make it look prettier by selecting `Editor` --> `Show Rendered Markup` in the menu bar at the very top of your screen. You can switch back to the raw markup by clicking `Editor` --> `Show Raw Markup`. The document is designed to be viewed in Rendered Markup mode.
//:
//: You can type your Swift code in here and it'll automatically compile.
//: If the automatic compilation annoys you, you can turn it off by clicking-and-holding your mouse on the "Play" icon in the toolbar below. Then, select `Manually Run`.
//:
//: If you need help or have any questions, please feel free to contact me. You can find my contact info on the [course website](https://avf.github.io/mobile-app-dev/). I'm always happy to help!
//:
//: ## How to do the exercises
//: - Follow the instructions for the exercises.
//: - Please write any code that I ask for right into the playground.
//: - Any time I ask a question in an exercise, **please add a comment with the explanation in your own words.**
//:
//: Here's an example:
//:
//: Write a Hello World program in Swift in a single line. Why is this a valid Swift program?

print("Hello, World!") // This works because Swift programs by default execute statements in the global scope. A `main` function or similar is not required.

//: ## Exercises
//: ### Variables and Constants
//: 1. Declare a variable with value `42` that is implicitly assigned type `Int`.
//: 1. Declare a constant with value `42` that is implicitly assigned type `Int`.
//: 1. Declare a variable with value `42.5`. What type does it have?
//: 1. Declare a variable with explicit type `Float` and value `42.5`.
//: 1. Declare an uninitialized constant with type `String`. Will you ever be able to assign a value to this constant?
// 1
var integerVar = 42
// 2
let integerConst = 42
// 3
var doubleVar = 42.5        // implicit type is Double
// 4
var floatVar: Float = 42.5  // explicit type is Float
// 5
let stringConst: String
stringConst = "HelloWorld"  // stringConstant is a constant that is only declared and can be initialized once
print(stringConst)
//stringConst = "HelloWorld2" // error: stringConstant is an already initialized constant that is immutable and cannot be mutated, reassigned or changed
//print(stringConst)
//: ### Strings and String interpolation
//: 1. Create a constant of type `String` containing the text `"This is a String."`.
//: 1. Create a mutable String with `"This is an Int: "` as its initial value.
//: 1. Create an `Int` constant with value 42 and append it to the mutable string, resulting in the value: `"This is an Int: 42"`.
//: 1. Create another constant containing the same string, but this time use a string literal and string interpolation (the `\()` syntax) to create it.
//: 1. Create a multiline string using the multiline string literal.
// 1
let stringConst2 = "This is a String."
// 2
var stringVar2 = "This is an Int: "
// 3
let integerConst2 = 42
stringVar2.append(contentsOf: String(integerConst2))
print(stringVar2)
// 4
var stringVar3 = "This is an Int: "
stringVar3.append("\(integerConst2)")
print(stringVar3)
// 5
var multilineStringVar = """
First line
Second line
"""
print(multilineStringVar)
// 6
// one-line string formatted in multiple lines of code
var singlelineStringVar2 = """
Word1 \
Word2 \
Word3
"""
print(singlelineStringVar2)
//: ### Arrays and Dictionaries
//: Arrays
//: 1. Create an immutable array and initialize it with an array literal containing 3 `String` elements
//: 1. Create an empty mutable array of type `[String]`
//: 1. Append the second element of the first (immutable) array to the second (mutable) array.
//: 1. Can you modify one of the `String` elements in the first array (for example, append a word to it)? Why/why not? What if the elements were not of type `String`, but instead of a class?
//: 1. What happens if you modify the `String` element in the second array (for example, if you append a word to it)? Will the second element in the first array also change, or stay the same? Explain why.
//: 1. Create an immutable empty array of type `[Int]` without any literals, using the name of the class (`Array`) and the standard initializer for generic types (`var value = ClassName<GenericType>()`)
// 1
let arrayConst = ["String1", "String2", "String3"]
print(arrayConst)
// 2
var arrayVar: [String] = []
print(arrayVar)
// 3
arrayVar.append(arrayConst[1])
print(arrayVar)
// 4
// No, because
// 1. the contained values (Strings) in an array constant named arrayConst are also implicit constants
// 2. Strings are immutable by design (and explicitly) if they are declared as a constant
//arrayConst[0].append(contentsOf: "x") // error
//print(arrayConst[0])

// Working solution
var arrayVar2 = ["String1", "String2", "String3"]
arrayVar2[0].append(contentsOf: "x")
print(arrayVar2[0])

// 4.1
// In general, objects in an immutable (i.e. constant) array cannot be reassigned
// Values that are embodied by the objects can be changed
// if the reference to the object is not changed and the value that is changed is an instance var

class CharacterSequence : CustomStringConvertible {
    let valConst: String
    var valVar: String?
    
    init(valConst: String) {
        self.valConst = valConst
    }
    
    init(valVar: String) {
        self.valVar = valVar
        self.valConst = ""
    }
    
    var description: String {
        guard !self.valConst.isEmpty else {
            return "<valVar: \(self.valVar!)>"
        }
        
        guard self.valVar != nil else {
            return "<valConst: \(self.valConst)>"
        }
        
        return "<valConst: \(self.valConst) valVar: \(self.valVar!)>"
    }
}

let arrayConst2 = [CharacterSequence(valConst: "Const1"), CharacterSequence(valConst: "Const2"), CharacterSequence(valConst: "Const3")]
//arrayConst2[0] = CharacterSequence(valConst: "ConstX")    // not working because arrayConst3 is a constant
print(arrayConst2)

let arrayConst3 = [CharacterSequence(valVar: "Var1"), CharacterSequence(valVar: "Var2"), CharacterSequence(valVar: "Var3")]
//arrayConst3[1] = CharacterSequence(valVar: "VarX")    // not working because arrayConst3 is a constant
arrayConst3[1].valVar = "VarY"  // works
print(arrayConst3)

// 5
// The second element in the first array constant will stay the same
// because the String type in Swift is a value type
// In general, if a new String value is created, that String value is copied when it’s passed to a function or method, or when it’s assigned to a constant or variable
// https://docs.swift.org/swift-book/LanguageGuide/StringsAndCharacters.html
arrayVar[0].append(contentsOf: "x")
print(arrayVar[0])
print(arrayConst[1])

// 6
let integerArrayConst = Array<Int>()
print(integerArrayConst)
//: Dictionaries
//: 1. Create a mutable empty Dictionary of type `[String: Double]`
//: 1. Set the value for the key `"Answer to Life, the Universe and Everything"` to `42`.
// 1
var dict: [String: Double] = [:]
print(dict)
// 2
dict["Answer to Life, the Universe and Everything"] = 42
print(dict)
// or
dict.updateValue(42, forKey: "Answer to Life, the Universe and Everything")
print(dict)
//: ### Optionals
//: 1. Create an optional `String` variable and assign a non-nil value of your choice
//: 1. Print the String on the console. Make sure the variable is first unwrapped and only the actual value is printed. You may either force-unwrap the string or use an `if let` construct.
//: 1. What happens if you force-unwrap an optional variable that contains `nil`?
//: 1. Create another optional `String` variable and asign the value `nil`. Use the nil coalescing operator (`??`) to print the first unwrapped String from above.
//: 1. Do the same thing again, but this time use the ternary conditional operator `(a ? b : c)`.
// 1
var optStr: String? = "Text"
// 2
if let str = optStr {
    print(str)  // prints "Text"
}
// 3
// A runtime error could occur
var optStr2: String? = nil
//print(optStr2!) // throws an error at runtime
print(optStr2)   // prints nil
// 4
var optStr3: String? = nil
print(optStr3 ?? optStr!)   // prints "Text"
// 5
print(optStr3 != nil ? optStr3 : optStr!)   // prints "Text"
//: Optional chaining
//: 1. Consider the following `struct`. Use optional chaining to change the value of `anOptionalInt` in `instance` to a new value of your choice in a single line of code. What would happen if we executed that line while `instance` is `nil`?
//: 1. Use the `if let` conditional and optional chaining to print the value of `anOptionalInt` in `instance`. What would happen if `instance` or `anOptionalInt` were `nil`?
//: 1. Use optional chaining to call the method `sayHelloWorld` of `instance`. What would happen if `instance` were `nil`?

struct MyStruct {
    var anOptionalInt: Int? = 5
    
    func sayHelloWorld() {
        print("Hello, World!")
    }
}

var instance: MyStruct? = MyStruct()
// 1
// If instance would be nil, nothing would happen or could be changed
instance?.anOptionalInt? = 20
// 2
// If instance would be nil, nothing would happen
if let inst = instance {
    if let instVar = inst.anOptionalInt {
        print(instVar)
    }
}
// If instance would be nil, nothing would happen
print(instance?.anOptionalInt)
// 3
// If instance would be nil, no error is thrown, but the method cannot be called either
instance = nil
instance?.sayHelloWorld()
//: ### Control flow
//: 1. Write a `for-in` loop that sums up all the values in `myNumbers`.
//: 1. Create an empty mutable `[Int: Int]` dictionary. Use a `for-in` loop to iterate over the elements in `myNumbers` and add each value to the dictionary, using the index of each element in `myNumbers` as its key. So for example, the dictionary should contain the key/value pair `0:12`, because 12 is element 0 of `myNumbers`.

let myNumbers = [12, 23, 1, 104]
// 1
var sum = 0
for num in myNumbers {
    sum += num
}
print(sum)
// 2
var numDict: [Int: Int] = [:]
for index in myNumbers.indices {
    print("index: \(index)")
    numDict[index] = myNumbers[index]
    //numDict.updateValue(myNumbers[index], forKey: index)
}

print(numDict)
// or
var numDict2: [Int: Int] = [:]
for (key, val) in myNumbers.enumerated() {
    print("key: \(key) val: \(val)")
    //numDict2[key] = val
    numDict2.updateValue(val, forKey: key)
}
print(numDict2)
//: ### Functions and Closures
//: Functions
//: 1. Declare and call a function without any parameters or return type that prints Hello World.
//: 1. Declare and call a function that takes two strings as parameters and returns a string. Remember that in Swift, most funtions have argument labels. Make sure to include them, you don't need to modify the argument labels in any way.
//: 1. Declare and call a function with the same signature (two strings as parameters and returns a string), but this time remove the first argument label.
//: 1. Declare and call a function with the same signature (two strings as parameters and returns a string), but this time make the first argument label **different** from the parameter name (=use a custom argument label).
//: 1. Declare a function with a default parameter value. Call the function twice, once with the argument present, once without.
//: 1. Declare a function with name `callAFunction` that takes another function as parameter and then executes it. Call your newly declared `callAFunction` and pass in one of the functions you previously declared.
// 1
func printFunction() {
    print("Hello World")
}

printFunction()

// 2
func appendStrings(args: String, args2: String) -> String {
    var str = args
    str.append(args2)
    return str
}

let appendedStr = appendStrings(args: "One", args2: "+Two")
print(appendedStr)

// 3
func appendStrings2(_ args: String, args2: String) -> String {
    var str = args
    str.append(args2)
    return str
}
let appendedStr2 = appendStrings2("Three", args2: "+Four")
print(appendedStr2)
// 4
func appendStrings3(args1 args: String, args2: String) -> String {
    var str = args
    str.append(args2)
    return str
}
let appendedStr3 = appendStrings3(args1: "Five", args2: "+Six")
print(appendedStr3)
// 5
func printString(_ args: String = "Hi") {
    print(args)
}

printString("Ciao")
printString()
// 6
func callAFunction(_ args: String, args2: String, function: (String, String) -> String) {
    let str = function(args, args2)
    print(str)
}

callAFunction("Seven", args2: "+Eight", function: appendStrings(args:args2:))
//: Closures
//: 1. Create an optional variable that holds a closure (with a `String` parameter and no return type) and assign `nil`.
//: 1. Call the closure using optional chaining. What will happen?
//: 1. Create a `typealias` for this type of closure.
// 1
var optClosure: ((String) -> Void)? = nil
// 2
// optClosure is nil and therefore not invoked
optClosure?("Hello")
// 3
typealias CompletionHandler = ((String) -> Void)?

func invokeCompletionHandler(_ completionHandler: CompletionHandler) -> Void {
    if let handler = completionHandler {
        handler("invoked by invokeCompletionHandler")
    }
}

invokeCompletionHandler(printString(_:))
//: 1. Take a look at the following function, which takes a closure as parameter and calls it. This function is then called. For each of the following exercises, call the function again, but each time use one more simplification:
//:   * Omit closure parameter types.
//:   * Omit the closure return type
//:   * Omit the round brackets and argument label (we can do that since it's the last function parameter)
//:   * Omit the closure parameters completely. In the closure body, use the shorthand argument names (for example `$0`)
//:   * Omit the keyword `return`

func callAClosure(closure: (String, String) -> String) {
    print(closure("Hello", "World"))
}
callAClosure(closure: { (item1: String, item2: String) -> String in
    return "\(item1) \(item2)"
})

// 1
callAClosure(closure: { (item1, item2) -> String in
    return "\(item1) \(item2)"
})
// 2
callAClosure(closure: { (item1, item2) in
    return "\(item1) \(item2)"
})
// 3
callAClosure(closure : { item1, item2 in
    return "\(item1) \(item2)"
})
// 4
callAClosure(closure: {
    return "\($0) \($1)"
})
// 5
callAClosure(closure: {
    "\($0) \($1)"
})
//: ### Classes
//: 1. Create a new class named `Person`. Add non-optional `firstName` and `lastName` properties and an initializer.
//: 1. Add a `name` computed property that returns a `String` containing the first and last name.
//: 1. Add a method named `greet` that returns the following `String`: `"Hi, I'm \(name)."`
//: 1. Create a subclass of `Person` and name it `Student`.
//: 1. Add a `Float?` optional property called `grade`. Use the `didSet` property observer to make sure that the grade is not lower than 1.0 and not higher than 5.0 after it was set. Clamp the new value to this interval - so if a value higher than 5.0 is set, set it to 5.0 afterwards. If a value lower than 1.0 is set, set it to 1.0 afterwards.
//: 1. Override the `greet` function from the superclass. If the `grade` property is set, it should now return `"Hi, I'm \(name). My grade is: \(grade)"`. If the `grade property isn't set, return the superclass's implementation.

//: ### Enums and Structs
//: 1. Create an enum named `PetType` with cases `dog` and `cat`
//: 1. In your new enum, create a function or computed property named `animalSound` that returns a `String`. Use a `switch` statement on `self` to differentiate between the cases and return `"woof"` for the `.dog` case and `"meow"` for the `.cat` case.
//: 1. Create a structure named `Pet`, with a `name` property of type `String` and a `type` constant of type `PetType` (both non-optional).
//: 1. Add a function to your structure named `makeNoise` that returns a `String`. In its implementation, return the `animalSound` of its `type`.
//: 1. Create 3 or more instances of your `Pet` struct and store them in `let` constants. Then create a new array that contains all your pets and store it in a variable.
//: 1. Change one of the names of the pets in your array. Does this change the name of any of the pets stored in the `let` constants? Explain why/why not.
//: 1. Can you change the name of one of the pets stored in the `let` constants? Explain why/why not.
//: 1. Create 3 or more instances of your `Student` class from above and store them in `let` constants. Then create a new array that contains all your students and store it in a variable.
//: 1. Change one of the names of the students in your array. Does this change the name of any of the students stored in the `let` constants? Explain why/why not.
//: 1. Can you change the name of one of the students stored in the `let` constants? Explain why/why not.

//: ### Protocols and extensions
//: 1. Create a protocol called `NamedThing`. Add a `get` variable of type `String`, with the name `name`.
//: 1. Use extensions to make your `Person` class and `Pet` structs from above conform to the new protocol.
//: 1. Create a new array that contains all the objects you declared as `let` constants above. You may have to explicitly specify the type of the array as `[NamedThing]`.
//: 1. Iterate over the objects in the array and print out their names.
//: 1. Create a protocol extension for `NamedThing` that contains a new computed property of type `String` called `initial`. Add a default implementation in your protocol extension, which returns the first character of the `name` property, or, if `name` is empty, an empty string.
//: 1. Print the new `initials` property in the loop you created above.
