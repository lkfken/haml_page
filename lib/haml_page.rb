# frozen_string_literal: true

require 'ostruct'
require 'haml'
# no comment
class HamlPage
  attr_accessor :layout, :view, :context

  def initialize(layout: nil, view: nil, context: nil)
    @context = context || OpenStruct.new
    @layout                 = layout
    @view                   = view
  end

  def to_s
    if layout.nil?
      render_template(view)
    else
      render_template(layout, escape_html: false) { render_template(view, escape_html: false) }
    end
  end

  alias to_str to_s

  private

  def render_template(template, **options)
    return Haml::Template.new(options) { template.to_s }.render(context) { yield if block_given? } if template.nil?

    if File.exist?(template)
      Haml::Template.new(template, options).render(context) { yield if block_given? }
    elsif template.is_a? String
      Haml::Template.new(options) { template }.render(context) { yield if block_given? }
    else
      raise "Can't load the template file. Pass a string with a path or an object that responds to 'to_str', 'path' or 'to_path'"
    end
  end

  def method_missing(meth, *args, &block)
    if user_defined_setter?(meth)
      context.send(meth, *args)
    elsif context.respond_to?(meth)
      context.send(meth)
    else
      super
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    context.respond_to?(method_name, include_private) || super
  end

  def user_defined_setter?(meth)
    name = meth.to_s
    !!name[/=$/]
  end
end
