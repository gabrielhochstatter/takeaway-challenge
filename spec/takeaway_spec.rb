require 'takeaway'

describe Takeaway do
  subject(:takeaway) { described_class.new(menu) }
  let(:menu_display) { 'burger: $5.0, hot dog: $3.75, fries: $2.5, soda: $1.5' }
  let(:menu) { double(:menu, print_menu: menu_display, dishes: {
    'burger' => 5.00,
    'hot dog' => 3.75,
    'fries' => 2.50,
    'soda' => 1.50, },
    contains?: true )
  }
  let(:example_summary) { "Your order: burger x2 = $10.0, total: $10.0"}
  let(:order) { double(:order, summary: example_summary, total: 10.0)}

  describe '#show_menu' do
    it "shows menu when prompted" do
      expect(takeaway.show_menu).to eq menu_display
    end
  end

  describe '#order' do
    it "adds items to the current order" do
      takeaway.order('burger', 2)
      expect(takeaway.current_order.summary).to eq example_summary
    end

    it "repeats the addition to the order to the user" do
      message = "2x burger(s) added to your order."
      expect(takeaway.order('burger', 2)).to eq message
    end
  end

  describe '#order_summary' do
    it "prints the summary of the users order back to them" do
      takeaway.order('burger', 2)
      expect(takeaway.order_summary).to eq example_summary
    end
  end

  describe '#total' do
    it "shows the user their total" do
      message = "Your total is: $13.0"
      takeaway.order('burger', 2)
      takeaway.order('soda', 2)
      expect(takeaway.total).to eq message
    end
  end
end
