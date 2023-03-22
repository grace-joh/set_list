require 'rails_helper'

RSpec.describe 'songs show page', type: :feature do
  it 'displays the song title, length, and play count' do
    crj = Artist.create!(name: 'Carly Rae Jepsen')
    song_1 = crj.songs.create!(title: 'I Really Like You',
                                  length: 208,
                                  play_count: 243810867,
                                  artist_id: crj.id)
    song_2 = crj.songs.create!(title: 'Call Me Maybe',
                                  length: 199,
                                  play_count: 1214722172,
                                  artist_id: crj.id)

    visit "/songs/#{song_1.id}"

    expect(page).to have_content(song_1.title)
    expect(page).to have_content(song_1.length)
    expect(page).to have_content(song_1.play_count)
    expect(page).to_not have_content(song_2.title)
    expect(page).to_not have_content(song_2.length)
    expect(page).to_not have_content(song_2.play_count)
  end

  it 'displays the name of the songs artist' do
    crj = Artist.create!(name: 'Carly Rae Jepsen')
    song_1 = crj.songs.create!(title: 'I Really Like You',
                                  length: 208,
                                  play_count: 243810867,
                                  artist_id: crj.id)

    visit "/songs/#{song_1.id}"

    expect(page).to have_content(crj.name)
  end

  it 'has a link back to the songs index page' do
    crj = Artist.create!(name: 'Carly Rae Jepsen')
    song_1 = crj.songs.create!(title: 'I Really Like You',
                                  length: 208,
                                  play_count: 243810867,
                                  artist_id: crj.id)

    visit "/songs/#{song_1.id}"

    save_and_open_page

    expect(page).to have_link('Back to All Songs')
    click_link 'Back to All Songs'
    expect(current_path).to eq('/songs')
  end
end
