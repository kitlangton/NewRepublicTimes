require 'open-nlp'
require 'nameable'
require 'pp'

class NamedEntities

  SENTENCE = "MARSHALLTOWN, Iowa — Donald J. Trump and Fox News, the candidate who has reordered the Republican presidential race and the cable network of choice for many of the party’s voters, stared each other down on Tuesday over his demand that the news anchor Megyn Kelly be dumped from moderating Thursday’s debate, the last before Monday’s caucuses.

The network did not blink. So Mr. Trump walked.

Mr. Trump’s announcement here that he would “probably,” or would “most likely,” or was “pretty close to” irrevocably planning to skip the debate — an aide put it more directly — created a gaping uncertainty at the center of the Republican nominating contest just as it was formally about to begin in Iowa.

It was the most intense confrontation yet between two mutually dependent but increasingly antagonistic powerhouses of media and politics. Mr. Trump, who has made the presidential race into a riveting television spectacle, was overtly exploiting the ratings leverage his candidacy has created to try to bend Fox News to his will.

“Let’s see how much money Fox is going to make on the debate without me,” he said at a news conference here.

Fox News said Mr. Trump’s refusal to debate his rivals was “near unprecedented.”

“This is rooted in one thing — Megyn Kelly, whom he has viciously attacked since August and has now spent four days demanding be removed from the debate stage,” the network said in a statement.

On her program Tuesday night, Ms. Kelly observed that “what’s interesting here is Trump is not used to not controlling things, as the chief executive of a large organization.”"

  def process(text = SENTENCE)

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
  end
end

# parsed = []
#
# pp named_entities = NamedEntities.new.process
#
# named_entities['person'].each do |name|
#   name = name.join(" ")
#   parsed << Nameable.parse(name)
# end
#
# pp parsed
