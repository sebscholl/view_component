---
layout: default
title: Templates
parent: How-to guide
---

# Templates

When a new component is generated using the CLI (`rails generate component ComponentName [OPTIONS]`) a dedicated template file is created alongside the component's class definition:

``sh
$ rails g component MyComponent 
  create  app/components/my_component.rb
  create  app/components/my_component.html.erb
```

Be default a component will look for a template file that matches its name and namespace when being rendered.

```sh
rails g component namespaced/MyComponent
```
```ruby
# app/components/namespaced/my_component.rb
class Namespaced::MyComponent < ViewComponent::Base; end
```
```html
<!-- app/components/namespaced/my_component.html.erb -->
<div>Add Namespaced::My template here</div>
```

## Inline Templates

Instead of using a separate template file, component templates can be defined directly within the component definition as a heredoc:

```ruby
class MyComponent < ViewComponent::Base
  erb_template <<~TEMPLATE
    <article><%= content %></article>
  TEMPLATE
end
```

Inline template definitions behave no differently than separate template files. The behave the same both in development and testing.

### Embedded Syntax Highlighting

Depending on your developer environment, syntax highlighting may be available or configurable for inline templates. Explicitly set the open and close tags on there heredoc to the required language.

```ruby
class MyComponent < ViewComponent::Base
  erb_template <<~EMBEDDED_RUBY
    <article><%= content %></article>
  EMBEDDED_RUBY
end
```
