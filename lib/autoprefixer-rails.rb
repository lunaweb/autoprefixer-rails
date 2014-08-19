# Ruby integration with Autoprefixer JS library, which parse CSS and adds
# only actual prefixed
module AutoprefixerRails
  autoload :Sprockets, 'autoprefixer-rails/sprockets'

  # Add prefixes to `css`. See `Processor#process` for options.
  def self.process(css, opts = {})
    browsers = opts.delete(:browsers)
    options  = opts.has_key?(:cascade) ? { :cascade => opts.delete(:cascade) } : {}
    processor(browsers, options).process(css, opts)
  end

  # Add Autoprefixer for Sprockets environment in `assets`.
  # You can specify `browsers` actual in your project.
  def self.install(assets, browsers = nil, opts = {}, postcss = {})
    Sprockets.new( processor(browsers, opts) ).install(assets, postcss)
  end

  # Cache processor instances
  def self.processor(browsers = nil, opts = {})
    @cache  ||= {}
    cache_key = browsers.hash.to_s + opts.hash.to_s
    @cache[cache_key] ||= Processor.new(browsers, opts)
  end
end

require File.expand_path('../autoprefixer-rails/result', __FILE__)
require File.expand_path('../autoprefixer-rails/version', __FILE__)
require File.expand_path('../autoprefixer-rails/processor', __FILE__)

require File.expand_path('../autoprefixer-rails/railtie', __FILE__) if defined?(Rails)
