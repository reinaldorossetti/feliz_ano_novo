# encoding: utf-8
require "capybara/dsl"

Capybara.run_server = false
Capybara.default_driver = :selenium_chrome
Capybara.app_host = "https://web.whatsapp.com"
Capybara.default_max_wait_time = 30

class UploadWhatsApp

  include Capybara::DSL

  def initialize
    visit '/'
    $nameList = ["ruby", "QA Produtos", "Qualidade como Cultura"]
    $dir = "#{__dir__}\\arquivo\\"
  end

  def upload_file
    $nameList.each do |name|
      files = Dir.entries($dir)
      filepath = "#{__dir__}\\arquivo\\#{files.sample}"
      puts filepath, name

      find("#pane-side span[title*='#{name}']").click()
      find('div[role=button] span[data-icon="clip"]').click()
      find('input[accept="image/*,video/mp4,video/3gpp,video/quicktime"]', :visible => false).send_keys(filepath)

      find("div[data-animate-media-caption='true'] div[class*='copyable-text selectable-text']").
        send_keys("Feliz Ano Novo!!! Sucesso...")
      find('span[data-testid="send"]').click()
    end
  end

end

test = UploadWhatsApp.new
test.upload_file