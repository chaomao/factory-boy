require 'rspec'
require './src/factory_boy'
require './src/user'
require './src/admin'

RSpec.configure do |config|
	config.before :each do
		FactoryBoy.clean_sequence
	end
end

describe FactoryBoy do

	FactoryBoy.define do
		sequence(:cellphone, 100) { |n| n }

		factory :user do
			name 'mao chao'
			gender 'male'
			cellphone { generate(:cellphone) }
		end

		factory :admin do
			user
		end
	end

	context 'user' do
		it	'should create User model' do
			user = FactoryBoy.create(:user)
			expect(user.name).to eq('mao chao')
			expect(user.gender).to eq('male')
		end

		it	'should generate different cellphone' do
			expect(FactoryBoy.create(:user).cellphone).to eq(100)
			expect(FactoryBoy.create(:user).cellphone).to eq(101)
		end

		it	'should replace default value' do
			expect(FactoryBoy.create(:user, name: 'jie ge').name).to eq('jie ge')
		end
	end

	context 'admin' do
		it 'should create' do
			expect(FactoryBoy.create(:admin).user.name).to eq('mao chao')
		end
	end
end