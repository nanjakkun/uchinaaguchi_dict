// 入力値を正規化する

export const normalize_text = (text: string): string => {
  return text.trim().
    replace(/ゐ/g, "ぃい").
    replace(/うぇ/g, "ぇえ").
    replace(/をぅ/g, "ぅう").
    replace(/ー/g, "ー");
};
