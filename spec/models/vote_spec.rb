describe Vote do
  describe "validations" do
    before do
      v = Vote.new(value: 1)
      v2 = Vote.new(value: -1)
      v3 = Vote.new(value: 2)
    describe "value validation" do
      it "only allows -1 or 1 as values" do
        expect( v ).to eq(1)
        expect( v2 ).to eq(-1)
        expect( v3 ).to eq(1 || -1)
        # your expectations here
      end
    end
  end
end