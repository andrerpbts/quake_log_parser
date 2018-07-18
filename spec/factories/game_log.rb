FactoryBot.define do
  factory :game_log do
    total_kills 45
    players ['Isgalamido', 'Dono da Bola', 'Zeh']

    kills do
      {
        'Zeh': 18,
        'Isgalamido': 10,
        'Dono da Bola': 5
      }
    end
  end
end
