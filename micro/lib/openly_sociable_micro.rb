require 'rubygems'
require 'camping'
require 'mongrel/camping'
require 'builder'

module OpenSocial
  def self.make_app(name)
    Camping.goes(name)
    name.constantize::Views.class_eval do
      
      def layout
        xml = Builder::XmlMarkup.new(:target => self, :indent => 2)
        xml.instruct!
        xml.Module do 
          xml.ModulePrefs(:title => @title) { xml.Require(:feature => "opensocial-0.5") }
          xml.Content(:type => "html") { 
            xml.cdata!(yield)
          }
        end
      end

      def javascript(*list)
        script(:type => "text/javascript") { 
          self << list.collect{|file| read("#{file}.js")}.join("\n") 
        } 
      end

      def read(this_file); File.open(this_file).readlines.to_s; end
      
    end
  end
  
  def self.start_mongrel(name, opts={})
    port = opts.delete(:port) || 3301
    root = opts.delete(:root) || '/'
    puts "** Server is running at http://localhost:#{port}#{root} **"
    Mongrel::Camping::start("0.0.0.0", port, root, name.constantize).run.join
  end
end

# From Rails' ActiveSupport
class String
  def constantize
    unless /\A(?:::)?([A-Z]\w*(?:::[A-Z]\w*)*)\z/ =~ self
      raise NameError, "#{self.inspect} is not a valid constant name!"
    end 
    Object.module_eval("::#{$1}", __FILE__, __LINE__)
  end
end

class Symbol
  def constantize
    self.to_s.constantize
  end
end