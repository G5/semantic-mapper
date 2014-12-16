# Semantic::Mapper

Takes some markup of the form:
```html
<div class="p-author h-card">
  <div class="form-field">
    <label for="p-first-name" class="required">First Name</label>
    <input type="text" id="p-first-name" class="p-first-name" name="p-first-name" data-mapping="first_name" required>
  </div>

  <div class="form-field">
    <label for="p-last-name" class="required">Last Name</label>
    <input type="text" id="p-last-name" class="p-last-name" name="p-last-name" data-mapping="last_name" required>
  </div>
</div>
```

and returns an indifferent hash of the form:
```ruby
  {first_name: 'p-first-name', last_name: 'p-last-name'}
```

Supports mapping multiple properties to the same form field
```html
<div class="p-author h-card">
  <div class="form-field">
    <label for="p-first-name" class="required">First Name</label>
    <input type="text" id="p-first-name" class="p-first-name" name="p-first-name" data-mapping="first_name billing_first_name" required>
  </div>
```
```ruby
  {first_name: 'p-first-name', billing_first_name: 'p-first-name'}
```

Supports nested properties
```html
<div class="p-author h-card">
  <div class="form-field">
    <label for="p-first-name" class="required">First Name</label>
    <input type="text" id="p-first-name" class="p-first-name" name="p-first-name" data-mapping="customer[first_name]" required>
    <input type="text" id="p-state" class="p-state" name="p-state" data-mapping="customer[address][state]" required>
  </div>
```
```ruby
  {customer: {first_name: 'p-first-name', address: {state: 'p-state'}}}
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'semantic-mapper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install semantic-mapper

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/semantic-mapper/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
