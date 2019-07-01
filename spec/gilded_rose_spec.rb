require "./gilded_rose"
require "shared_examples/gilded_rose_shared_examples"

describe GildedRose do
  describe "#update_quality" do
    context "Base item" do
      context "not expired" do
        let(:items) { [Item.new("Base item", 10, 50)] }

        it_behaves_like "item quality", -1
        it_behaves_like "item sell in"
      end

      context "expired" do
        let(:items) { [Item.new("Base item", 0, 50)] }

        it_behaves_like "item quality", -2
        it_behaves_like "item sell in"
      end

      context "with zero quality" do
        let(:items) { [Item.new("Base item", 10, 0)] }

        it_behaves_like "unchangable item quality"
        it_behaves_like "item sell in"
      end
    end

    context "Sulfuras item" do
      let(:items) { [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)] }

      it_behaves_like "unchangable item quality"

      it "doesn't change sell in" do
        expect{
          GildedRose.new(items).update_quality()
        }.to_not change(items[0], :sell_in)
      end
    end

    context "Aged Brie item" do
      context "not expired" do
        let(:items) { [Item.new("Aged Brie", 10, 20)] }

        it_behaves_like "item quality", 1
        it_behaves_like "item sell in"
      end

      context "expired" do
        let(:items) { [Item.new("Aged Brie", -1, 20)] }

        it_behaves_like "item quality", 2
        it_behaves_like "item sell in"
      end

      context "with 50 quality" do
        let(:items) { [Item.new("Aged Brie", 10, 50)] }

        it_behaves_like "unchangable item quality"
        it_behaves_like "item sell in"
      end
    end

    context "Backstage Pass item" do
      context "not expired" do
        context "more than 10 days" do
          let(:items) { [Item.new("Backstage passes to a TAFKAL80ETC concert", 20, 20)] }

          it_behaves_like "item quality", 1
          it_behaves_like "item sell in"
        end

        context "less than 10 days" do
          let(:items) { [Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 20)] }

          it_behaves_like "item quality", 2
          it_behaves_like "item sell in"
        end

        context "less than 5 days" do
          let(:items) { [Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 20)] }

          it_behaves_like "item quality", 3
          it_behaves_like "item sell in"
        end
      end

      context "expired" do
        let(:items) { [Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 20)] }

        it "reset quality to 0" do
          expect{
            GildedRose.new(items).update_quality()
          }.to change(items[0], :quality).from(20).to(0)
        end

        it_behaves_like "item sell in"
      end

      context "with 50 quality" do
        let(:items) { [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 50)] }

        it_behaves_like "unchangable item quality"
        it_behaves_like "item sell in"
      end
    end
  end
end
