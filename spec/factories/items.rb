FactoryBot.define do
  factory :item do
    send_method { "フリマ" }
    name {"book"}
    description {"コーディングの本です"}
    price { 9999999 }
    status {"2"}
    burden {"販売者負担"}
    region {"東京都"}
    created_at {"2019/12/2"}
    updated_at {"2019/12/3"}
  end
end