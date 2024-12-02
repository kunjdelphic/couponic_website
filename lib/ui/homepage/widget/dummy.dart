// Dummy data for cards
String getImageUrl(path) {
  String urls = 'assets/images/${path}.png';

  return urls;
}

String getTitle(int index) {
  const titles = [
    'Amazon',
    'Flipkart',
    'Myntra',
    'Ajio',
    'BigRock',
    'MakeMyTrip',
    'FirstCry',
    'Hostinger',
    'ClearTrip',
    'EaseMyTrip',
    'ShyaWay',
    'Swisse'
  ];
  return titles[index % titles.length];
}

String getRewardText(int index) {
  const rewards = [
    'Up to 5.2% Voucher Rewards',
    'Up to 7%',
    'Up to 6.3%',
    'Up to 10.1%',
    'Up to 40%',
    'Up to ₹150',
    'Up to ₹35',
    'Flat 41.3%',
  ];
  return rewards[index % rewards.length];
}

final List<String> categories = [
  "Fashion",
  "Mobiles & Tablets",
  "Beauty & Health",
  "Travel",
  "Web Hosting & Domains",
  "Food & Dining",
];

final List<Map<String, String>> offers_card = [
  {
    "logo": "https://via.placeholder.com/50", // Replace with actual logo URLs
    "title": "Black Friday Sale",
    "cashback": "Upto 6.3% Cashback",
  },
  {
    "logo": "https://via.placeholder.com/50",
    "title": "Black Friday Sale",
    "cashback": "Flat 7.5% Cashback",
  },
  {
    "logo": "https://via.placeholder.com/50",
    "title": "Upto 80% Off via Coupons",
    "cashback": "",
  },
];

final List<Map<String, String>> stores = [
  {
    "logo": "https://via.placeholder.com/50",
    "offers": "24 offers",
    "cashback": "Upto 5.2% Voucher Rewards",
  },
  {
    "logo": "https://via.placeholder.com/50",
    "offers": "9 offers",
    "cashback": "Upto 7% Rewards",
  },
  {
    "logo": "https://via.placeholder.com/50",
    "offers": "52 offers",
    "cashback": "Upto 6.3% Cashback",
  },
  {
    "logo": "https://via.placeholder.com/50",
    "offers": "46 offers",
    "cashback": "Upto 10.1% Cashback",
  },
];
