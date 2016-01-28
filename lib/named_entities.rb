require 'open-nlp'
require 'nameable'
require 'pp'

class NamedEntities

  def process(text)

    OpenNLP.load

    tokenizer   = OpenNLP::TokenizerME.new
    segmenter   = OpenNLP::SentenceDetectorME.new
    ner_models  = ['person', 'location', 'money']

    ner_finders = ner_models.map do |model|
      OpenNLP::NameFinderME.new("en-ner-#{model}.bin")
    end

    sentences = segmenter.sent_detect(text)
    named_entities = Hash.new { |h,k| h[k] = [] }

    sentences.each do |sentence|

      tokens = tokenizer.tokenize(sentence)

      ner_models.each_with_index do |model,i|
        finder = ner_finders[i]
        name_spans = finder.find(tokens)
        # name_probs = finder.probs()
        name_spans.each_with_index do |name_span,j|
          start = name_span.get_start
          stop  = name_span.get_end-1
          slice = tokens[start..stop].to_a
          # prob  = name_probs[j]
          named_entities[model] << slice
        end
      end
    end

    named_entities

    names = []

    Nameable::Latin::Patterns::PREFIX['Senator'] = /^\(*(sen\.*|senator)\)*$/i

    named_entities['person'].each do |name|
      name = name.join(" ")
      names << Nameable.parse(name)
    end

    names.each do |name|
      if name.first && !name.last
        name.last, name.first = name.first, name.last
      end
      if name.last =~ /\Ws/
        name.last = name.last.gsub(/\Ws/, "")
      end
    end

    names.each_with_index do |name, index|
      names[index..-1].each do |other|
        next if name == other || other.first && other.first != name.first
        if name.last == other.last || name.last == other.first
          name.first ||= other.first
          name.middle ||= other.middle
          name.last ||= other.last
          name.prefix ||= other.prefix
          name.suffix ||= other.suffix
          names.delete(other)
        end
      end
    end

    locations = named_entities['location'].map { |loc| loc.join(" ") }.uniq

    locations.map! do |location|
      Location.find_or_create_by(name: location)
    end

    names.map! do |name|
      gender = name.gender
      hash = name.to_hash
      hash[:gender] = gender.to_s if gender
      hash.delete(:suffix)
      if name = Name.where(first:hash[:first], last: hash[:last])[0]
        name
      else
        Name.create(hash)
      end
    end

    [names, locations]
  end
end


# names, locations = NamedEntities.new.process
#
# names.each do |name|
#   pp name.first
# end
# pp names
# pp locations
