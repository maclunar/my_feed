require 'rails_helper'

describe FeedFetcher::Twitter do
  subject(:fetcher) { described_class.new(tag, page) }

  let(:tag) {}
  let(:page) { 1 }

  context 'when tag is sinatra' do
    let(:tag) { 'sinatra' }

    it 'returns expected keys' do
      VCR.use_cassette('twitter feed') do
        expect(fetcher.call.first.keys).to contain_exactly(:author, :image, :published_at, :source, :text, :title, :url)
      end
    end

    it 'has source set to stackoverflow' do
      VCR.use_cassette('twitter feed') do
        expect(fetcher.call.first).to include(source: 'twitter')
      end
    end

    it 'includes 10 results' do
      VCR.use_cassette('twitter feed') do
        expect(fetcher.call.size).to eq(10)
      end
    end
  end
end
