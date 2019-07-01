shared_examples "item sell in" do
  it "decrease sell in by 1" do
    expect{
      GildedRose.new(items).update_quality()
    }.to change(items[0], :sell_in).by(-1)
  end
end

shared_examples "item quality" do |n|
  it "change quality by #{n}" do
    expect{
      GildedRose.new(items).update_quality()
    }.to change(items[0], :quality).by(n)
  end
end

shared_examples "unchangable item quality" do
  it "doesn't change quality" do
    expect{
      GildedRose.new(items).update_quality()
    }.to_not change(items[0], :quality)
  end
end
