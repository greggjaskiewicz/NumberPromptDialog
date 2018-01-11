
Number dialog input. 
Simple example:

```

    fileprivate var prompt: NumberPromptDialog?

    override func viewDidAppear(_ animated: Bool) {
        self.prompt = NumberPromptDialog()

        let promptControllerx = self.prompt?.promptUserForNumber(title: "type in a number") { (number, success) in
            print("number \(number), success: \(success)")
            self.prompt = nil
        }

        print("prompt \(promptControllerx)")
        if let promptController = promptControllerx {
            self.present(promptController, animated: true, completion: nil)
        }

        super.viewDidAppear(animated)
    }
```


