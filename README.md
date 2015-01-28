# factory-boy

## support sequence
```ruby
FactoryBoy.define do
  sequence(:cellphone, 100) {|n| n} # 100 is init value
  factory :user do
    cellphone {generate(:cellphone)}
  end
end
```
## support replace default value, like 
```ruby
FactoryBoy.create(:user, name: '123')
```

## support reference factory, like 
```ruby
FactoryBoy.define do
  factory :user do
  end
  factory :admin do
    user
  end
end
```
