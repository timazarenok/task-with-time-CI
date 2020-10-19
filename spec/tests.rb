# frozen_string_literal: true

require 'rspec/autorun'
require '../lib/time.rb'

describe Intervals do
  it 'without intersections' do
    times = Intervals.new([['10:00', '10:20'], ['10:40', '11:00'], ['11:50', '12:00'], ['12:10', '13:00'], ['10:00', '10:20']])
    expect(times.free_time).to eq([['10:20', '10:40'], ['11:00', '11:50'], ['12:00', '12:10']])
  end

  it 'with one intersection' do
    times = Intervals.new([['10:00', '10:20'], ['10:10', '11:00'], ['11:50', '12:00'], ['12:10', '13:00'], ['10:00', '10:20']])
    expect(times.free_time).to eq([['11:00', '11:50'], ['12:00', '12:10']])
  end

  it 'with chain of the intersection' do
    times = Intervals.new([['10:00', '10:20'], ['10:10', '11:00'], ['11:00', '12:00'], ['12:00', '13:00'], ['10:00', '10:20']])
    expect(times.free_time).to eq([])
  end

  it 'with intersection in middle' do
    times = Intervals.new([['10:00', '10:20'], ['10:40', '11:00'], ['11:00', '12:00'], ['12:30', '13:00'], ['10:00', '10:20']])
    expect(times.free_time).to eq([['10:20', '10:40'], ['12:00', '12:30']])
  end

  it 'first and last arent intersection' do
    times = Intervals.new([['10:00', '10:20'], ['10:40', '11:00'], ['11:00', '12:00'], ['12:00', '13:00'], ['13:30', '18:20']])
    expect(times.free_time).to eq([['10:20', '10:40'], ['13:00', '13:30']])
  end

  it 'funsorted input array' do
    times = Intervals.new([['10:00', '10:20'], ['12:00', '13:00'], ['10:40', '11:00'], ['11:00', '12:00'], ['13:30', '18:20']])
    expect(times.free_time).to eq([['10:20', '10:40'], ['13:00', '13:30']])
  end
end
