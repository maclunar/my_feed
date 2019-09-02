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

  let(:stackoverflow_connection) { instance_double(FeedFetcher::Stackoverflow) }
  let(:twitter_connection) { instance_double(FeedFetcher::Twitter) }
  let(:youtube_connection) { instance_double(FeedFetcher::Youtube) }

  let(:stackoverflow_feed) { { source: 'stackoverflow' } }
  let(:twitter_feed) { { source: 'twitter' } }
  let(:youtube_feed) { { source: 'youtube' } }

  before do
    allow(FeedFetcher::Stackoverflow).to receive(:new).with(tag_param).and_return(stackoverflow_connection)
    allow(FeedFetcher::Twitter).to receive(:new).with(tag_param).and_return(twitter_connection)
    allow(FeedFetcher::Youtube).to receive(:new).with(tag_param).and_return(youtube_connection)

    allow(stackoverflow_connection).to receive(:call).and_return(stackoverflow_feed)
    allow(twitter_connection).to receive(:call).and_return(twitter_feed)
    allow(youtube_connection).to receive(:call).and_return(youtube_feed)
  end

  context 'when no sources selected' do
    it 'returns empty hash' do
      expect(getter.call).to be_blank
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

    it 'returns twitter feed' do
      expect(getter.call).to eq(
        'twitter' => twitter_feed
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
        'stackoverflow' => stackoverflow_feed,
        'youtube' => youtube_feed
      )
    end
  end
end
