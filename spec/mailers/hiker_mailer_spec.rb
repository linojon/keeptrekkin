require "rails_helper"

RSpec.describe HikerMailer, :type => :mailer do

  describe "add_hiker" do
    let(:trip)  { create :trip, :with_hiker, :with_mountain }
    let(:hiker) { trip.hikers.first }
    let(:mail)  { HikerMailer.added_email(hiker, trip) }

    it "renders the subject" do
      expect(mail.subject).to eql("Hello Hiker! You've been added to a trip")
    end
    it 'renders recipient and sender' do
      expect(mail.to).to eql([hiker.email])
      expect(mail.from).to eql(['noreply@keeptrekkin.com'])
    end
    it 'assigns hiker and trip' do
      expect(mail.body.encoded).to match(hiker.name)
      expect(mail.body.encoded).to match(trip.mountains.first.name)
    end

  end

end
