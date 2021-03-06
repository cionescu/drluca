module Fetchers
  class Paintings < Fetcher
    attr_reader :json_data

    DOMAIN = "https://www.brushwiz.com"
    FILE_PATH = Rails.root.join("config", "data", "paintings.json").freeze
    IMAGE_PATH = Rails.root.join("public", "paintings").freeze

    def call run_local = false
      @json_data = if run_local
        JSON.parse(File.read(FILE_PATH))
      else
        urls.map.with_index do |url, idx|
          puts "Processing #{url} idx: #{idx}"
          get_painting_details(url)
        end
      end
      save_json_data_to_config FILE_PATH
      download_images IMAGE_PATH
      create_painter_questions
      create_painting_questions
    end

    private

    def download_images image_path
    end

    def create_painter_questions
      json_data.each do |painting|
        title = "Cine a pictat opera #{painting['title']}?"
        next if Question.find_by(title: title)
        Question.create!({
          title: title,
          category: :painter,
          url: painting['url'],
          answer: painting['painter'],
          autogenerated: true,
          incorrect_answers: find_incorrect_answers('painter', painting['painter'])
        })
      end
    end

    def create_painting_questions
      json_data.each do |painting|
        title = "Cum se numeste opera lui #{painting['painter']}?"
        next if Question.find_by(title: title)
        Question.create!({
          title: title,
          category: :art_work,
          url: painting['url'],
          answer: painting['title'],
          autogenerated: true,
          incorrect_answers: find_incorrect_answers('title', painting['title'])
        })
      end
    end

    def get_painting_details url
      response = Net::HTTP.get(URI(url))
      document = Nokogiri::HTML(response)
      parse_document(document)
    end

    def parse_document doc
      {
        url: "#{DOMAIN}#{doc.css(".image-framed img").first['src']}",
        title: doc.css("h1").inner_text.strip,
        painter: doc.css(".main-container p a").first.inner_text.strip
      }
    end

    def urls
      URLS.split("\n")
    end

    URLS = <<~EOF
      https://www.brushwiz.com/catalog/leonardo-da-vinci-mona-lisa-oil-painting-reproduction-104/
      https://www.brushwiz.com/catalog/vincent-van-gogh-the-starry-night-oil-painting-reproduction-74/
      https://www.brushwiz.com/catalog/edvard-munch-the-scream-oil-painting-reproduction-115/
      https://www.brushwiz.com/catalog/rembrandt-the-night-watch-oil-painting-reproduction-1060/
      https://www.brushwiz.com/catalog/gustav-klimt-the-kiss-oil-painting-reproduction-112/
      https://www.brushwiz.com/catalog/jan-van-eyck-the-arnolfini-portrait-oil-painting-reproduction-2373/
      https://www.brushwiz.com/catalog/johannes-vermeer-the-girl-with-a-pearl-earring-oil-painting-reproduction-110/
      https://www.brushwiz.com/catalog/claude-monet-impression-sunrise-oil-painting-reproduction-95/
      https://www.brushwiz.com/catalog/diego-velazquez-las-meninas-oil-painting-reproduction-5215/
      https://www.brushwiz.com/catalog/michelangelo-the-creation-of-adam-oil-painting-reproduction-109/
      https://www.brushwiz.com/catalog/pierre-auguste-renoir-luncheon-of-the-boating-party-oil-painting-reproduction-5243/
      https://www.brushwiz.com/catalog/jean-auguste-dominique-ingres-the-grand-odalisque-oil-painting-reproduction-6368/
      https://www.brushwiz.com/catalog/jean-honore-fragonard-the-happy-accidents-of-the-swing-oil-painting-reproduction-2417/
      https://www.brushwiz.com/catalog/eugene-delacroix-the-liberty-leading-the-people-oil-painting-reproduction-113/
      https://www.brushwiz.com/catalog/sandro-botticelli-the-birth-of-venus-oil-painting-reproduction-5720/
      https://www.brushwiz.com/catalog/jacques-louis-david-napoleon-crossing-the-alps-oil-painting-reproduction-1498/
      https://www.brushwiz.com/catalog/caravaggio-musicians-oil-painting-reproduction-729/
      https://www.brushwiz.com/catalog/grant-wood-american-gothic-oil-painting-reproduction-1242/
      https://www.brushwiz.com/catalog/georges-seurat-sunday-afternoon-on-the-island-of-la-grande-jatte-oil-painting-reproduction-956/
      https://www.brushwiz.com/catalog/henri-rousseau-the-sleeping-gypsy-oil-painting-reproduction-116/
      https://www.brushwiz.com/catalog/raphael-the-triumph-of-galatea-oil-painting-reproduction-4153/
      https://www.brushwiz.com/catalog/jean-francois-millet-the-gleaners-oil-painting-reproduction-111/
      https://www.brushwiz.com/catalog/sandro-botticelli-primavera-oil-painting-reproduction-5486/
      https://www.brushwiz.com/catalog/francisco-goya-the-third-of-may-1808-oil-painting-reproduction-5990/
      https://www.brushwiz.com/catalog/anthony-van-dyck-charles-i-in-three-positions-oil-painting-reproduction-432/
      https://www.brushwiz.com/catalog/caspar-david-friedrich-the-wanderer-above-the-sea-of-fog-oil-painting-reproduction-117/
      https://www.brushwiz.com/catalog/edouard-manet-olympia-oil-painting-reproduction-748/
      https://www.brushwiz.com/catalog/pieter-bruegel-the-elder-the-tower-of-babel-oil-painting-reproduction-3520/
      https://www.brushwiz.com/catalog/el-greco-view-of-toledo-oil-painting-reproduction-1154/
      https://www.brushwiz.com/catalog/edgar-degas-a-cotton-office-in-new-orleans-oil-painting-reproduction-1214/
      https://www.brushwiz.com/catalog/titian-bacchus-and-ariadne-oil-painting-reproduction-4783/
      https://www.brushwiz.com/catalog/gustave-courbet-the-sleepers-oil-painting-reproduction-1083/
      https://www.brushwiz.com/catalog/thomas-eakins-the-gross-clinic-oil-painting-reproduction-5822/
      https://www.brushwiz.com/catalog/ivan-aivazovsky-the-ninth-wave-oil-painting-reproduction-1673/
      https://www.brushwiz.com/catalog/leonardo-da-vinci-the-last-supper-oil-painting-reproduction-1665/
      https://www.brushwiz.com/catalog/paolo-uccello-st-george-and-the-dragon-oil-painting-reproduction-5629/
      https://www.brushwiz.com/catalog/thomas-gainsborough-mr-and-mrs-robert-andrews-oil-painting-reproduction-105/
      https://www.brushwiz.com/catalog/jean-leon-gerome-pollice-verso-oil-painting-reproduction-3366/
      https://www.brushwiz.com/catalog/antoine-watteau-pilgrimage-to-cythera-oil-painting-reproduction-4400/
      https://www.brushwiz.com/catalog/paul-cezanne-large-bathers-oil-painting-reproduction-5214/
      https://www.brushwiz.com/catalog/johannes-vermeer-the-astronomer-oil-painting-reproduction-1921/
      https://www.brushwiz.com/catalog/william-adolphe-bouguereau-wave-oil-painting-reproduction-1990/
      https://www.brushwiz.com/catalog/peter-paul-rubens-the-fall-of-the-damned-oil-painting-reproduction-6365/
      https://www.brushwiz.com/catalog/edouard-manet-a-bar-at-the-folies-bergere-oil-painting-reproduction-87/
      https://www.brushwiz.com/catalog/rembrandt-the-storm-on-the-sea-of-galilee-oil-painting-reproduction-1089/
      https://www.brushwiz.com/catalog/frans-hals-the-laughing-cavalier-oil-painting-reproduction-6370/
      https://www.brushwiz.com/catalog/gustave-caillebotte-paris-street-in-rainy-weather-oil-painting-reproduction-96/
      https://www.brushwiz.com/catalog/franz-marc-foxes-oil-painting-reproduction-3273/
      https://www.brushwiz.com/catalog/leonardo-da-vinci-the-lady-with-the-ermine-oil-painting-reproduction-1664/
      https://www.brushwiz.com/catalog/john-singleton-copley-watson-and-the-shark-oil-painting-reproduction-6112/
      https://www.brushwiz.com/catalog/joshua-reynolds-the-ladies-waldegrave-oil-painting-reproduction-5855/
      https://www.brushwiz.com/catalog/james-abbott-mcneill-whistler-arrangement-in-grey-and-black-no-1-oil-painting-reproduction-1740/
      https://www.brushwiz.com/catalog/pierre-auguste-renoir-dance-at-the-moulin-de-la-galette-oil-painting-reproduction-91/
      https://www.brushwiz.com/catalog/winslow-homer-breezing-up-oil-painting-reproduction-4840/
      https://www.brushwiz.com/catalog/katsushika-hokusai-the-great-wave-off-kanagawa-oil-painting-reproduction-6369/
      https://www.brushwiz.com/catalog/amedeo-modigliani-large-seated-nude-oil-painting-reproduction-653/
      https://www.brushwiz.com/catalog/george-bellows-stag-night-at-sharkeys-oil-painting-reproduction-103/
      https://www.brushwiz.com/catalog/vincent-van-gogh-the-night-cafe-oil-painting-reproduction-78/
      https://www.brushwiz.com/catalog/childe-hassam-the-avenue-in-the-rain-oil-painting-reproduction-108/
      https://www.brushwiz.com/catalog/leonardo-da-vinci-annunciation-oil-painting-reproduction-326/
      https://www.brushwiz.com/catalog/hans-holbein-the-younger-the-ambassadors-oil-painting-reproduction-5698/
      https://www.brushwiz.com/catalog/frederic-leighton-flaming-june-oil-painting-reproduction-5030/
      https://www.brushwiz.com/catalog/artemisia-gentileschi-susanna-and-the-elders-oil-painting-reproduction-959/
      https://www.brushwiz.com/catalog/wassily-kandinsky-composition-viii-oil-painting-reproduction-1344/
      https://www.brushwiz.com/catalog/jacques-louis-david-the-oath-of-horatii-oil-painting-reproduction-1674/
      https://www.brushwiz.com/catalog/cassius-marcellus-coolidge-a-friend-in-need-oil-painting-reproduction-6172/
      https://www.brushwiz.com/catalog/william-adolphe-bouguereau-dante-and-virgil-in-hell-oil-painting-reproduction-6201/
      https://www.brushwiz.com/catalog/francisco-goya-saturn-devouring-his-son-oil-painting-reproduction-2314/
      https://www.brushwiz.com/catalog/albrecht-altdorfer-battle-of-issus-oil-painting-reproduction-6358/
      https://www.brushwiz.com/catalog/vincent-van-gogh-the-potato-eaters-oil-painting-reproduction-85/
      https://www.brushwiz.com/catalog/alexandre-cabanel-the-birth-of-venus-oil-painting-reproduction-6367/
      https://www.brushwiz.com/catalog/louis-jean-francois-lagrenee-mars-and-venus-allegory-of-peace-oil-painting-reproduction-6233/
      https://www.brushwiz.com/catalog/paul-klee-red-balloon-oil-painting-reproduction-3396/
      https://www.brushwiz.com/catalog/john-william-waterhouse-the-lady-of-shalott-oil-painting-reproduction-5857/
      https://www.brushwiz.com/catalog/gilbert-stuart-portrait-of-a-gentleman-skating-oil-painting-reproduction-1529/
      https://www.brushwiz.com/catalog/john-constable-the-hay-wain-oil-painting-reproduction-5834/
      https://www.brushwiz.com/catalog/mary-cassatt-the-boat-trip-oil-painting-reproduction-4087/
      https://www.brushwiz.com/catalog/titian-sleeping-venus-oil-painting-reproduction-3425/
      https://www.brushwiz.com/catalog/gentile-da-fabriano-adoration-of-the-magi-oil-painting-reproduction-4717/
      https://www.brushwiz.com/catalog/raphael-portrait-of-a-young-man-oil-painting-reproduction-6243/
      https://www.brushwiz.com/catalog/camille-pissarro-boulevard-montmartre-spring-oil-painting-reproduction-1754/
      https://www.brushwiz.com/catalog/paolo-veronese-the-wedding-at-cana-oil-painting-reproduction-4159/
      https://www.brushwiz.com/catalog/rembrandt-the-anatomy-lesson-of-dr-nicolaes-tulp-oil-painting-reproduction-6303/
      https://www.brushwiz.com/catalog/theodore-gericault-the-raft-of-the-medusa-oil-painting-reproduction-4142/
      https://www.brushwiz.com/catalog/francesco-hayez-the-kiss-oil-painting-reproduction-1040/
      https://www.brushwiz.com/catalog/jean-leon-gerome-the-bath-oil-painting-reproduction-3462/
      https://www.brushwiz.com/catalog/joseph-mallord-william-turner-fort-vimieux-oil-painting-reproduction-5048/
      https://www.brushwiz.com/catalog/claude-monet-the-japanese-bridge-oil-painting-reproduction-6359/
      https://www.brushwiz.com/catalog/emanuel-gottlieb-leutze-washington-crossing-the-delaware-oil-painting-reproduction-2956/
      https://www.brushwiz.com/catalog/hieronymus-bosch-the-garden-of-earthly-delights-central-panel-oil-painting-reproduction-3112/
      https://www.brushwiz.com/catalog/caravaggio-supper-at-emmaus-oil-painting-reproduction-1611/
      https://www.brushwiz.com/catalog/albrecht-durer-feast-of-the-rosary-oil-painting-reproduction-527/
      https://www.brushwiz.com/catalog/william-holman-hunt-the-hireling-shepherd-oil-painting-reproduction-2418/
      https://www.brushwiz.com/catalog/pieter-bruegel-the-elder-hunters-in-the-snow-oil-painting-reproduction-3298/
      https://www.brushwiz.com/catalog/paul-gauguin-the-seed-of-areoi-oil-painting-reproduction-5950/
      https://www.brushwiz.com/catalog/ilya-repin-barge-haulers-on-the-volga-oil-painting-reproduction-360/
      https://www.brushwiz.com/catalog/francois-boucher-odalisque-oil-painting-reproduction-743/
      https://www.brushwiz.com/catalog/caravaggio-cardsharps-oil-painting-reproduction-416/
      https://www.brushwiz.com/catalog/hubert-robert-the-pont-du-gard-oil-painting-reproduction-3503/
      https://www.brushwiz.com/catalog/edouard-manet-the-luncheon-on-the-grass-oil-painting-reproduction-5873/
      https://www.brushwiz.com/catalog/caravaggio-taking-of-christ-oil-painting-reproduction-8392/
    EOF
  end
end
