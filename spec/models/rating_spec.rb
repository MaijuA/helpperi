require 'rails_helper'

RSpec.describe Rating, type: :model do

  it 'saves the rating' do
    rating = Rating.create reviewer_id: 2,
                       reviewed_id: 3,
                       post_id: 1,
                       score: 2,
                       review: 'Hyvää työtä'

    expect(rating.valid?).to be(true)
    expect(Rating.count).to eq(1)
  end

  it 'doesn´t save rating if score under 1' do
    rating = Rating.create reviewer_id: 2,
                           reviewed_id: 3,
                           post_id: 1,
                           score: 0.9,
                           review: 'Hyvää työtä'

    expect(rating.valid?).to be(false)
    expect(Rating.count).to eq(0)
  end

  it 'doesn´t save rating if score over 3' do
    rating = Rating.create reviewer_id: 2,
                           reviewed_id: 3,
                           post_id: 1,
                           score: 3.1,
                           review: 'Hyvää työtä'

    expect(rating.valid?).to be(false)
    expect(Rating.count).to eq(0)
  end

  it 'doesn´t save rating without post_id' do
    rating = Rating.create reviewer_id: 2,
                           reviewed_id: 3,
                           score: 3,
                           review: 'Hyvää työtä'

    expect(rating.valid?).to be(false)
    expect(Rating.count).to eq(0)
  end

  it 'doesn´t save rating without score' do
    rating = Rating.create reviewer_id: 2,
                           reviewed_id: 3,
                           post_id: 3,
                           review: 'Hyvää työtä'

    expect(rating.valid?).to be(false)
    expect(Rating.count).to eq(0)
  end

  it 'doesn´t save rating without reviewer_id' do
    rating = Rating.create reviewed_id: 3,
                           post_id: 1,
                           score: 2,
                           review: 'Hyvää työtä'

    expect(rating.valid?).to be(false)
    expect(Rating.count).to eq(0)
  end

  it 'doesn´t save rating without reviewed_id' do
    rating = Rating.create reviewer_id: 3,
                           post_id: 1,
                           score: 2,
                           review: 'Hyvää työtä'

    expect(rating.valid?).to be(false)
    expect(Rating.count).to eq(0)
  end

  it 'doesn´t save rating if already rated' do
    rating1 = Rating.create reviewed_id: 2,
                           reviewer_id: 3,
                           post_id: 1,
                           score: 2,
                           review: 'Hyvää työtä'

    expect(rating1.valid?).to be(true)
    expect(Rating.count).to eq(1)

    rating2 = Rating.create reviewed_id: 2,
                            reviewer_id: 3,
                            post_id: 1,
                            score: 2,
                            review: 'Hyvää työtä'

    expect(rating2.valid?).to be(false)
    expect(Rating.count).to eq(1)
  end
end