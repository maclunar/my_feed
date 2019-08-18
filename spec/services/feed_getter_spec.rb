require 'rails_helper'

describe FeedGetter do
  subject(:getter) { described_class.new(params) }

  let(:params) do
    {
      tag: tag_param,
      sources: sources_param
    }
  end

  let(:tag_param) { 'ruby' }
  let(:sources_param) {}

  let(:stackoverflow_connection) { instance_double(StackoverflowFeedFetcher) }
  let(:twitter_connection) { instance_double(TwitterFeedFetcher) }
  let(:youtube_connection) { instance_double(YoutubeFeedFetcher) }

  before do
    allow(StackoverflowFeedFetcher).to receive(:new).with(tag_param).and_return(stackoverflow_connection)
    allow(TwitterFeedFetcher).to receive(:new).with(tag_param).and_return(twitter_connection)
    allow(YoutubeFeedFetcher).to receive(:new).with(tag_param).and_return(youtube_connection)

    allow(stackoverflow_connection).to receive(:call).and_return({ source: 'stackoverflow' })
    allow(twitter_connection).to receive(:call).and_return({ source: 'twitter' })
    allow(youtube_connection).to receive(:call).and_return({ source: 'youtube' })
  end

  context 'when no sources selected' do
    it 'returns empty hash' do
      expect(getter.call).to eq({})
    end
  end

  context 'when twitter selected' do
    let(:sources_param) do
      {
        'stackoverflow' => '0',
        'twitter' => '1',
        'youtube' => '0'
      }
    end

    it 'returns stackoverflow and youtube feeds' do
      expect(getter.call).to eq(
        "twitter" => { source: "twitter" }
      )
    end
  end

  context 'when stackoverflow and youtube selected' do
    let(:sources_param) do
      {
        'stackoverflow' => '1',
        'twitter' => '0',
        'youtube' => '1'
      }
    end

    it 'returns stackoverflow and youtube feeds' do
      expect(getter.call).to eq(
                               "stackoverflow" => { source: "stackoverflow" },
                               "youtube" => { source: "youtube" }
                             )
    end
  end
end
