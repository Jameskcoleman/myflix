require 'spec_helper'

describe "deactivate user on failed charge" do
  let(:event_data) do
    {
      "id" => "evt_14QhfB4YbhcI9p1LhUv7jwcx",
      "created" => 1407859097,
      "livemode" => false,
      "type" => "charge.failed",
      "data" => {
        "object" => {
          "id" => "ch_14QhfB4YbhcI9p1LTvEmu4XX",
          "object" => "charge",
          "created" => 1407859097,
          "livemode" => false,
          "paid" => false,
          "amount" => 999,
          "currency" => "usd",
          "refunded" => false,
          "card" => {
            "id" => "card_14Qhdp4YbhcI9p1LNiJcnrG0",
            "object" => "card",
            "last4" => "0341",
            "brand" => "Visa",
            "funding" => "credit",
            "exp_month" => 11,
            "exp_year" => 2017,
            "fingerprint" => "9r1dOPavk4bkDUHT",
            "country" => "US",
            "name" => nil,
            "address_line1" => nil,
            "address_line2" => nil,
            "address_city" => nil,
            "address_state" => nil,
            "address_zip" => nil,
            "address_country" => nil,
            "cvc_check" => "pass",
            "address_line1_check" => nil,
            "address_zip_check" => nil,
            "customer" => "cus_4ZqIPGAB5AmB32"
          },
          "captured" => false,
          "refunds" => {
            "object" => "list",
            "total_count" => 0,
            "has_more" => false,
            "url" => "/v1/charges/ch_14QhfB4YbhcI9p1LTvEmu4XX/refunds",
            "data" => []
          },
          "balance_transaction" => nil,
          "failure_message" => "Your card was declined.",
          "failure_code" => "card_declined",
          "amount_refunded" => 0,
          "customer" => "cus_4ZqIPGAB5AmB32",
          "invoice" => nil,
          "description" => "payment to fail",
          "dispute" => nil,
          "metadata" => {},
          "statement_description" => "payment to fail",
          "receipt_email" => nil
        }
      },
      "object" => "event",
      "pending_webhooks" => 1,
      "request" => "iar_4ZrNJzaoS5Pug4"
    }
  end

  it "deactivates a user with the webhook data from stripe for charge failed", :vcr do
    alice = Fabricate(:user, customer_token: "cus_4ZqIPGAB5AmB32")
    post "/stripe_events", event_data
    expect(alice.reload).not_to be_active
  end
end