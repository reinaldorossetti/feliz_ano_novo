# encoding: utf-8
require "capybara/dsl"

Capybara.run_server = false
Capybara.default_driver = :selenium_chrome
Capybara.app_host = "https://web.whatsapp.com"
Capybara.default_max_wait_time = 15

class UploadWhatsApp

  include Capybara::DSL

  def initialize
    visit '/'
    $nameList = ["Qualidade como Cultura"]
    $dir = "#{__dir__}\\arquivo\\"
  end

  def upload_file
    $nameList.each do |name|
      files = Dir.entries($dir).reject { |e| File.directory? e }
      filepath = "#{__dir__}\\arquivo\\#{files.sample}"
      puts filepath, name

      find_element(name).click()
      find('div[role=button] span[data-icon="clip"]').click()
      find('input[accept="image/*,video/mp4,video/3gpp,video/quicktime"]', :visible => false).send_keys(filepath)

      find("div[data-animate-media-caption='true'] div[class*='copyable-text selectable-text']").
        send_keys("Feliz Ano Novo!!! Sucesso...")
      find('span[data-testid="send"]').click()
      sleep(10)
    end
  end

  # procura o elemento da lista, caso nao encontrado dar um scroll
  def find_element(name)
    elem = nil
    begin
      elem = find("#pane-side span[title*='#{name}']")
    rescue
      scroll_to_element(pula_para_ultimo_elem)
      elem = find("#pane-side span[title*='#{name}']")
    end
    elem
  end

  def scroll_to_element(elem)
    execute_script('arguments[0].scrollIntoView();', elem)
  end

  # pega o ultimo usuario visivel na DOM
  def pula_para_ultimo_elem
    maior_valor = 0
    ultimo_elemento = nil
    elementos = find_all("#pane-side div[style*=translateY]")
    elementos.each do |elem|

      property = elem[:style]
      regex = /\((.*?)px/
      property = property[regex, 1].to_i
      if maior_valor < property
        maior_valor = property
        ultimo_elemento = elem
        puts maior_valor
      end

    end
    ultimo_elemento
  end

end

test = UploadWhatsApp.new
test.upload_file