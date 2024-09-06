# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# リワードデータを作成
Reward.create([
  # 連続正解に関する実績
  { 
    title: '初勝利の道 🥉', 
    description: '初めての5連続正解を達成。正解への第一歩!', 
    icon: 'rewards/RewardIcon1', 
    condition_type: 'streak', 
    condition_value: 5 
  },
  { 
    title: 'エースの称号 🥈', 
    description: '10問連続正解を達成。すでにエキスパートの領域!', 
    icon: 'rewards/RewardIcon1', 
    condition_type: 'streak', 
    condition_value: 10 
  },
  { 
    title: 'パーフェクトチャンピオン 🥇', 
    description: '20問連続正解を達成。パーフェクトの名にふさわしい実力!', 
    icon: 'rewards/RewardIcon1', 
    condition_type: 'streak', 
    condition_value: 20 
  },
  { 
    title: '連勝の覇者 👑', 
    description: '30問連続正解を達成。挑戦者たちの羨望の的!', 
    icon: 'rewards/RewardIcon1', 
    condition_type: 'streak', 
    condition_value: 30 
  },
  { 
    title: 'アンブレイカブル 🛡️', 
    description: '40問連続正解を達成。あなたの知識はもはや無敵!', 
    icon: 'rewards/RewardIcon1', 
    condition_type: 'streak', 
    condition_value: 40 
  },
  { 
    title: '完璧の証明 🌟', 
    description: '50問連続正解を達成。完全無欠のクイズマスター!', 
    icon: 'rewards/RewardIcon1', 
    condition_type: 'streak', 
    condition_value: 50 
  },
  { 
    title: '神話の領域 ⚡', 
    description: '75問連続正解を達成。伝説と呼ばれるにふさわしい!', 
    icon: 'rewards/RewardIcon1', 
    condition_type: 'streak', 
    condition_value: 75 
  },
  { 
    title: 'クイズの神 👼', 
    description: '100問連続正解を達成。知識の神となる偉業を成し遂げた!', 
    icon: 'rewards/RewardIcon1', 
    condition_type: 'streak', 
    condition_value: 100 
  },

  # 正解数に応じた実績
  { 
    title: '知識の芽吹き 🌱', 
    description: '10問正解して、知識の種が芽吹く瞬間!', 
    icon: 'rewards/RewardIcon2', 
    condition_type: 'total_correct', 
    condition_value: 10 
  },
  { 
    title: '知識のつぼみ 🌷', 
    description: '25問正解して、知識のつぼみが開き始める。', 
    icon: 'rewards/RewardIcon2', 
    condition_type: 'total_correct', 
    condition_value: 25 
  },
  { 
    title: '知識の大樹 🌳', 
    description: '50問正解して、知識がしっかりと根を張る。', 
    icon: 'rewards/RewardIcon2', 
    condition_type: 'total_correct', 
    condition_value: 50 
  },
  { 
    title: '知識の森 🌲', 
    description: '100問正解して、あなたの知識が豊かな森に!', 
    icon: 'rewards/RewardIcon2', 
    condition_type: 'total_correct', 
    condition_value: 100 
  },

  # 連続不正解に関する実績
  { 
    title: '再挑戦の勇者 😅', 
    description: '3連続で不正解。でも、まだ挑戦は続く!', 
    icon: 'rewards/RewardIcon2', 
    condition_type: 'consecutive_incorrect', 
    condition_value: 3 
  },
  { 
    title: 'リトライ戦士 🔁', 
    description: '5連続で不正解。諦めない心があなたの強み!', 
    icon: 'rewards/RewardIcon2', 
    condition_type: 'consecutive_incorrect', 
    condition_value: 5 
  },
  { 
    title: 'リベンジヒーロー 🔄', 
    description: '10連続で不正解。でも、いつか必ず成功する!', 
    icon: 'rewards/RewardIcon2', 
    condition_type: 'consecutive_incorrect', 
    condition_value: 10 
  },

  # プレイ頻度に関する実績
  { 
    title: 'デイリーエキスパート 📆', 
    description: '5日間連続でプレイ。継続は力なり!', 
    icon: 'rewards/RewardIcon3', 
    condition_type: 'daily_play', 
    condition_value: 5 
  },
  { 
    title: '月間コンプリート 🏆', 
    description: '30日間連続でプレイし続けたあなたは、真のチャンピオン!', 
    icon: 'rewards/RewardIcon3', 
    condition_type: 'daily_play', 
    condition_value: 30 
  },

  # 問題数に対する実績
  { 
    title: 'ファン 🔍', 
    description: '100問の問題に答えて、クイズの楽しさを発見!', 
    icon: 'rewards/RewardIcon4', 
    condition_type: 'total_answers', 
    condition_value: 100 
  },
  { 
    title: '達人 🎓', 
    description: '500問の問題に答え、知識が深まる達成感を味わう。', 
    icon: 'rewards/RewardIcon4', 
    condition_type: 'total_answers', 
    condition_value: 500 
  },
  { 
    title: '王者 👑', 
    description: '1000問の問題に答え、クイズ王の称号を獲得!', 
    icon: 'rewards/RewardIcon4', 
    condition_type: 'total_answers', 
    condition_value: 1000 
  },
  { 
    title: '巨匠 🏅', 
    description: '5000問の問題に答え、あなたの知識はもう巨匠の域!', 
    icon: 'rewards/RewardIcon4', 
    condition_type: 'total_answers', 
    condition_value: 5000 
  }
])