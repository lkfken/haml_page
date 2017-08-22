require 'haml'
class HamlPage
  attr_accessor :layout, :view, :__user_defined_methods

  def initialize
    @__user_defined_methods = Hash.new
    @layout                 = nil
    @view                   = nil
  end

  def to_s
    if layout.nil?
      rendered_view(view)
    else
      rendered_view(layout) { rendered_view(view) }
    end
  end

  private

  def rendered_view(template, &block)
    engine = Object.new
    Haml::Engine.new(String(template)).def_method(engine, :render, *locals.keys)
    engine.render(locals){yield}
  end

  def method_missing(meth, *args, &block)
    if is_user_defined_setter?(meth)
      aname = meth.to_s.sub('=', '')
      __user_defined_methods.merge!({aname.to_sym => args.first})
    elsif is_user_defined_getter?(meth)
      __user_defined_methods[meth]
    else
      super
    end
  end

  def locals
    __user_defined_methods.merge(:__user_defined_methods => __user_defined_methods.keys)
  end

  def is_user_defined_getter?(meth)
    __user_defined_methods.has_key?(meth)
  end

  def is_user_defined_setter?(meth)
    name = meth.to_s
    !!name[/=$/]
  end
end
