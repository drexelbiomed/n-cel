###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
page "index.html", :layout => "home-page"

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
# which_fake_page: "Rendering a fake page with a local variable" }

activate :external_pipeline,
  name: :gulp,
  command: build? ? 'npm run build' : 'npm run development',
  source: ".tmp",
  latency: 1


###
# Helpers
###

helpers do
  def http_prefix
    build? ? "/labs/nce/" : "/"
  end
  def current_page?(page)
    if page.title == current_resource.data.title
      return true
    else
      return false
    end
  end

  def current_page_is_a_sub_page?(page)
    is_sub_page = false                     # set the switch in the off position

    if page.sub_pages?
      page.sub_pages.each do |sub|
        if sub.title == current_resource.data.title # if we are on the sub page
          is_sub_page = true                  # trip the switch
        end
      end
    end
    return is_sub_page                      # return the switch's state (true or false)
  end

  def test_values_compared_in_cp_vs_subpage(page)
    a = ""
    page.sub_pages.each do |sub|
      a+="<p>#{sub.title}, #{current_resource.data.title} "
      a+="is #{sub.title == current_resource.data.title}</p>"
    end
    return a
  end
end

###
# Environment List
###

# Server Environment
configure :server do

  # Debug assets
  set :debug_assets, true

end

# Development Environment
configure :development do

  #To activate the middleman-sprockets
  files.watch :source, path: "/Users/Dave/src/_shared/source", priority: -1

  # Automatic image dimensions on image_tag helpers
  # activate :automatic_image_sizes

  # Reload the browser automatically whenever files change
  activate :livereload,  :no_swf => true

  # Haml Configuration
  # Disable Haml warnings
  Haml::TempleEngine.disable_option_validator!
  Haml::Options.defaults[:format] = :html5

  # Assets Pipeline Sets
  set :css_dir, 'assets/stylesheets'
  set :js_dir, 'assets/javascripts'
  set :images_dir, 'assets/images'
  set :fonts_dir, 'assets/fonts'

  #To activate the middleman-sprockets

  # Pretty URLs
  activate :directory_indexes

  # Ignore large files
  ignore '*.psd'

end

# Build Environment
configure :build do
  ignore '*/vendor/**'
  ignore '*.psd'

  files.watch :source, path: "/Users/Dave/src/_shared/source", priority: -1

  #To activate the middleman-sprockets
  after_configuration do
    sprockets.append_path "/Users/Dave/src/_shared/source"
  end

  # Minify CSS on build
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # GZIP text files
  # activate :gzip

  # Use relative URLs
  activate :relative_assets

  ignore "*.psd"

  # Middleman Deploy (https://github.com/middleman-contrib/middleman-deploy/)
  case ENV['TARGET'].to_s.downcase
    when 'biomed'
      activate :deploy do |deploy|
        deploy.deploy_method   = :ftp
        deploy.host            = ENV["BIOMED_HOST"]
        deploy.path            = ENV["BIOMED_PATH"] + "labs/nce"
        deploy.user            = ENV["BIOMED_USER"]
        deploy.password        = ENV["BIOMED_PASS"]
        deploy.build_before = true
      end
    when 'azure'
      activate :deploy do |deploy|
        deploy.deploy_method   = :ftp
        deploy.host            = ENV["AZURE_HOST"]
        deploy.path            = ENV["AZURE_PATH"] + "/labs/nce"
        deploy.user            = ENV["AZURE_USER"]
        deploy.password        = ENV["AZURE_PASS"]
        deploy.build_before = true
      end
    end
end

# Production Environment
configure :production do

  # Assets Pipeline Sets
  set :css_dir, 'assets/stylesheets'
  set :js_dir, 'assets/javascripts'
  set :images_dir, 'assets/images'
  set :fonts_dir, 'assets/fonts'

  # Middleman Production dev server run code
  # 'middleman server -e production'

end
