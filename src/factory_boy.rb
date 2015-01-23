class FactoryBoy
	def self.define(name = nil, &block)
		@factory = FactoryBoy.new unless @factory
		@factory.instance_eval(&block) if block_given?
	end
	def self.create(name)
		@factory.instance_exec{@models}[name].create
	end
	def self.clean_sequence
		@factory.instance_exec{@sequences}.each {|name, hash| hash[:count] = 0}
	end
	def initialize
		@models, @sequences = {}, {}
	end
	def factory(name, &block)
		@models[name] = Model.new(name, self) unless @models.key?(name)
		@models[name].instance_eval(&block) if block_given?
	end
	def sequence(name, value, &block)
		@sequences[name] = {init: value, block: block, count: 0}
	end
	def generate(seq_name)
		value = @sequences[seq_name][:init] + @sequences[seq_name][:count]
		@sequences[seq_name][:block].call(value).tap { @sequences[seq_name][:count] = @sequences[seq_name][:count] + 1 }
	end
end

class Model
	def initialize(name, factory)
		@name, @params, @factory = name, {}, factory
	end
	def create
		values = @params.inject({}) do |memo, (key, value)|
			memo[key] = value.is_a?(Proc) ? @factory.instance_eval(&value) : value
			memo
		end
		Object.const_get(@name.capitalize).new(values)
	end
	def method_missing(name, *params, &block)
		@params[name.to_sym] = block_given? ? block : params.first
	end
end