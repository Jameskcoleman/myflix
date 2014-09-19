require 'spec_helper'

describe "Create payment on successful charge" do
  let (:event_data) do
    {
      "id" => "evt_14Q1hT4YbhcI9p1Ln2KGS7f1",
      "created" => 1407697791,
      "livemode" => false,
      "type" => "invoice.payment_succeeded",
      "data" => {
        "object" => {
          "date" => 1407697790,
          "id" => "in_14Q1hS4YbhcI9p1L1KB4LC1x",
          "period_start" => 1407697790,
          "period_end" => 1407697790,
          "lines" => {
            "object" => "list",
            "total_count" => 1,
            "has_more" => false,
            "url" => "/v1/invoices/in_14Q1hS4YbhcI9p1L1KB4LC1x/lines",
            "data" => [
              {
                "id" => "sub_4ZA1XCfcy5TQnp",
                "object" => "line_item",
                "type" => "subscription",
                "livemode" => false,
                "amount" => 999,
                "currency" => "usd",
                "proration" => false,
                "period" => {
                  "start" => 1407697790,
                  "end" => 1410376190
                },
                "quantity" => 1,
                "plan" => {
                  "interval" => "month",
                  "name" => "The base plan",
                  "created" => 1407678218,
                  "amount" => 999,
                  "currency" => "usd",
                  "id" => "base",
                  "object" => "plan",
                  "livemode" => false,
                  "interval_count" => 1,
                  "trial_period_days" => nil,
                  "metadata" => {},
                  "statement_description" => nil
                },
                "description" => nil,
                "metadata" => {}
              }
            ]
          },
          "subtotal" => 999,
          "total" => 999,
          "customer" => "cus_4ZA1MedO4xuaAR",
          "object" => "invoice",
          "attempted" => true,
          "closed" => true,
          "forgiven" => false,
          "paid" => true,
          "livemode" => false,
          "attempt_count" => 1,
          "amount_due" => 999,
          "currency" => "usd",
          "starting_balance" => 0,
          "ending_balance" => 0,
          "next_payment_attempt" => nil,
          "webhooks_delivered_at" => nil,
          "charge" => "ch_14Q1hS4YbhcI9p1LrHOFOVUA",
          "discount" => nil,
          "application_fee" => nil,
          "subscription" => "sub_4ZA1XCfcy5TQnp",
          "metadata" => {},
          "statement_description" => nil,
          "description" => nil
        }
      },
      "object" => "event",
      "pending_webhooks" => 1,
      "request" => "iar_4ZA1TSmkvasBPo"
    }
  end

  it "creates a payment with the webhook from stripe for charge succeeded", :vcr do
    post "/stripe_events", event_data
    expect(Payment.count).to eq(1)
  end

  it "creates the payment associated with user", :vcr do
    alice = Fabricate(:user, customer_token: "cus_4ZA1MedO4xuaAR")
    post "/stripe_events", event_data
    expect(Payment.first.user).to eq(alice)
  end

  it "creates the payment with the amount", :vcr do
    alice = Fabricate(:user, customer_token: "cus_4ZA1MedO4xuaAR")
    post "/stripe_events", event_data
    expect(Payment.first.amount).to eq(999)
  end

  it "creates the payment with reference id", :vcr do
    alice = Fabricate(:user, customer_token: "cus_4ZA1MedO4xuaAR")
    post "/stripe_events", event_data
    expect(Payment.first.reference_id).to eq("in_14Q1hS4YbhcI9p1L1KB4LC1x")
  end
end