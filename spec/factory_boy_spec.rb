require 'rspec'
require './src/factory_boy'
require './src/user'

describe FactoryBoy do

	FactoryBoy.define do
		factory :user do
			name 'mao chao'
			gender 'male'
		end
		factory :admin do
		end
	end

	it	'should create User model' do
		user = FactoryBoy.create(:user)
		expect(user.name).to eq('mao chao')
		expect(user.gender).to eq('male')
	end
end