require 'httparty'
require 'open-uri'
require 'FileUtils'
require 'time'

def save_image(url, created_at)
  created = Time.parse(created_at).strftime("%Y%m%d%I%M")
  fileName = "#{created}.jpg"
  dirName = "/tmp/gyazo/"
  filePath = dirName + fileName

  FileUtils.mkdir_p(dirName) unless FileTest.exist?(dirName)
  open(filePath, 'wb') do |output|
    open(url) do |data|
      output.write(data.read)
    end
  end
  `touch -t #{created} #{filePath}`
end

def download(data)
  data.each do |image|
    save_image(image['url'], image['created_at'])
  end
end

def all_download(page = 1, remaining_count = nil)
  query = {:page => page}
  url = "https://api.gyazo.com/api/images"
  query[:access_token] = 'your_gyazo_token'
  res = HTTParty.get url, {
                            :query => query,
                            :header => {
                                'User-Agent' => "GyazoDownloader"
                            }
                        }
  raise Gyazo::Error, res.body unless res.code == 200
  json = JSON.parse res.body
  download(json)

  total = res.headers['x-total-count'].to_i
  per_page = res.headers['x-per-page'].to_i

  remaining_count = total if remaining_count.nil?
  remaining_count -= per_page
  page += 1
  return if remaining_count <= 0

  all_download(page, remaining_count)
end

all_download
