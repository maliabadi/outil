## Outil

### Installation

```bash
gem install outil
```

To set up a local index and config file:

```bash
outil-bootstrap
```

### Usage

Adding methods to your Outil method index on the fly.

```ruby

class MyClass
  include Outil

  outil :register
  def foo
    'bar'
  end
end

```

The functionality of the method isn't changed in your code.

```ruby
instance = MyClass.new()
instance.foo
 => "bar" 
```

By including Outil and calling the "register" decorator, Outil will add the enclosed method to your universal Outil module called 'foo' that, when included in any project, will behave exactly the way it's written to here.

```ruby
module SomeOtherProject
  class MyUnrelatedClass
    include Outil

    def baz
      "#{foo} baz"
    end
  end
end

another_instance = SomeOtherProject::MyUnrelatedClass.new
another_instance.foo
 => "bar" 
 another_instance.baz
 => "bar baz"

```

### Current Status

Very early in the development stage. How exactly this might be useful is probably unclear right now, but should become clear down the line. Watch this space.

