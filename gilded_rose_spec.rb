require File.join(File.dirname(__FILE__), 'gilded_rose')
require File.join(File.dirname(__FILE__), 'item')

describe GildedRose do
  describe "#update_quality" do
    context "Base item" do
      context "not expired" do
        let(:items) { [Item.new("Base item", 10, 50)] }

        it "decrease item quality by 1" do
          expect{
            GildedRose.new(items).update_quality()
          }.to change(items[0], :quality).by(-1)
        end

        it "decrease base item sell in by 1" do
          expect{
            GildedRose.new(items).update_quality()
          }.to change(items[0], :sell_in).by(-1)
        end
      end

      context "expired" do
        let(:items) { [Item.new("Base item", 0, 50)] }

        it "decrease base item quality by 2" do
          expect{
            GildedRose.new(items).update_quality()
          }.to change(items[0], :quality).by(-2)
        end

        it "decrease base item sell in by 1" do
          expect{
            GildedRose.new(items).update_quality()
          }.to change(items[0], :sell_in).by(-1)
        end
      end

      context "with zero quality" do
        let(:items) { [Item.new("Base item", 10, 0)] }

        it "doesn't change item quality" do
          expect{
            GildedRose.new(items).update_quality()
          }.to_not change(items[0], :quality)
        end

        it "decrease base item sell in by 1" do
          expect{
            GildedRose.new(items).update_quality()
          }.to change(items[0], :sell_in).by(-1)
        end
      end
    end

    context "Sulfuras item" do
      let(:items) { [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)] }

      it "doesn't change sell in" do
        expect{
          GildedRose.new(items).update_quality()
        }.to_not change(items[0], :sell_in)
      end

      it "doesn't change quality" do
        expect{
          GildedRose.new(items).update_quality()
        }.to_not change(items[0], :quality)
      end
    end

    context "Aged Brie item" do
      context "not expired" do
        let(:items) { [Item.new("Aged Brie", 10, 20)] }

        it "increase item quality by 1" do
          expect{
            GildedRose.new(items).update_quality()
          }.to change(items[0], :quality).by(1)
        end

        it "decrease item sell in by 1" do
          expect{
            GildedRose.new(items).update_quality()
          }.to change(items[0], :sell_in).by(-1)
        end
      end

      context "expired" do
        let(:items) { [Item.new("Aged Brie", -1, 20)] }

        it "increase item quality by 2" do
          expect{
            GildedRose.new(items).update_quality()
          }.to change(items[0], :quality).by(2)
        end

        it "decrease item sell in by 1" do
          expect{
            GildedRose.new(items).update_quality()
          }.to change(items[0], :sell_in).by(-1)
        end
      end

      context "with 50 quality" do
        let(:items) { [Item.new("Aged Brie", 10, 50)] }

        it "doesn't change quality" do
          expect{
            GildedRose.new(items).update_quality()
          }.to_not change(items[0], :quality)
        end

        it "decrease item sell in by 1" do
          expect{
            GildedRose.new(items).update_quality()
          }.to change(items[0], :sell_in).by(-1)
        end
      end
    end

    context "Backstage Pass item" do
      context "not expired" do
        context "more than 10 days" do
          let(:items) { [Item.new("Backstage passes to a TAFKAL80ETC concert", 20, 20)] }

          it "increase item quality by 1" do
            expect{
              GildedRose.new(items).update_quality()
            }.to change(items[0], :quality).by(1)
          end

          it "decrease item sell in by 1" do
            expect{
              GildedRose.new(items).update_quality()
            }.to change(items[0], :sell_in).by(-1)
          end
        end

        context "less than 10 days" do
          let(:items) { [Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 20)] }

          it "increase item quality by 2" do
            expect{
              GildedRose.new(items).update_quality()
            }.to change(items[0], :quality).by(2)
          end

          it "decrease item sell in by 1" do
            expect{
              GildedRose.new(items).update_quality()
            }.to change(items[0], :sell_in).by(-1)
          end
        end

        context "less than 5 days" do
          let(:items) { [Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 20)] }

          it "increase item quality by 3" do
            expect{
              GildedRose.new(items).update_quality()
            }.to change(items[0], :quality).by(3)
          end

          it "decrease item sell in by 1" do
            expect{
              GildedRose.new(items).update_quality()
            }.to change(items[0], :sell_in).by(-1)
          end
        end
      end

      context "expired" do
        let(:items) { [Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 20)] }

        it "reset quality to 0" do
          expect{
            GildedRose.new(items).update_quality()
          }.to change(items[0], :quality).from(20).to(0)
        end

        it "decrease item sell in by 1" do
          expect{
            GildedRose.new(items).update_quality()
          }.to change(items[0], :sell_in).by(-1)
        end
      end

      context "with 50 quality" do
        let(:items) { [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 50)] }

        it "doesn't change quality" do
          expect{
            GildedRose.new(items).update_quality()
          }.to_not change(items[0], :quality)
        end

        it "decrease item sell in by 1" do
          expect{
            GildedRose.new(items).update_quality()
          }.to change(items[0], :sell_in).by(-1)
        end
      end
    end
  end
end
