-- ============================================
-- 课堂互动 Demo - Supabase 数据库初始化脚本
-- 在 Supabase Dashboard > SQL Editor 中执行
-- ============================================

-- 1. 创建留言表
CREATE TABLE messages (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  nickname TEXT NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. 创建投票表
CREATE TABLE poll_votes (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  nickname TEXT NOT NULL,
  option_text TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. 开启行级安全策略 (RLS)
ALTER TABLE messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE poll_votes ENABLE ROW LEVEL SECURITY;

-- 4. 允许所有人读取和写入留言
CREATE POLICY "allow_public_read_messages" ON messages
  FOR SELECT USING (true);
CREATE POLICY "allow_public_insert_messages" ON messages
  FOR INSERT WITH CHECK (true);

-- 5. 允许所有人读取和写入投票
CREATE POLICY "allow_public_read_votes" ON poll_votes
  FOR SELECT USING (true);
CREATE POLICY "allow_public_insert_votes" ON poll_votes
  FOR INSERT WITH CHECK (true);

-- 6. 开启实时订阅（可选，用于实时更新）
ALTER PUBLICATION supabase_realtime ADD TABLE messages;
ALTER PUBLICATION supabase_realtime ADD TABLE poll_votes;
