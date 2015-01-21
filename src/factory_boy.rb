class FactoryBoy
	def self.define(name = nil, &block)
		@factory = Factory.new unless @factory
		@factory.instance_eval(&block) if block_given?
	end
	def self.create(name)
		@factory.create(name)
	end
end

class Factory
	def initialize
		@defines = {}
	end
	def factory(name, &block)
		@defines[name] = Model.new(name) unless @defines.key?(name)
		@defines[name].instance_eval(&block) if block_given?
	end
	def create(name)
		@defines[name].create
	end
end

class Model
	def initialize(name)
		@name, @params = name, {}
	end
	def create
		Object.const_get(@name.capitalize).new(@params)
	end
	def method_missing(name, params, &block)
		@params[name.to_sym] = params
	end
end