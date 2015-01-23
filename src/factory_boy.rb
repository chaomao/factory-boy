class FactoryBoy
	def self.define(name = nil, &block)
		@factory = FactoryBoy.new unless @factory
		@factory.instance_eval(&block) if block_given?
	end
	
	def self.create(name)
		@factory.instance_exec{@models}[name].create
	end

	def initialize
		@models = {}
	end

	def factory(name, &block)
		@models[name] = Model.new(name) unless @models.key?(name)
		@models[name].instance_eval(&block) if block_given?
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