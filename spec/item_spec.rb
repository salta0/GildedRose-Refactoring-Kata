require "./item"

describe Item do
  let(:name) { "Item" }
  let(:sell_in) { 10 }
  let(:quality) { 20 }

  describe ".new" do
    it "create new item object with properties" do
      item = Item.new name, sell_in, quality

      expect(item).to be_an_instance_of(Item)
      expect(item.name).to eq name
      expect(item.sell_in).to eq sell_in
      expect(item.quality).to eq quality
    end
  end

  describe "#to_s" do
    it "return string with item properties" do
      item = Item.new name, sell_in, quality

      expect(item.to_s).to eq "#{name}, #{sell_in}, #{quality}"
    end
  end
end
