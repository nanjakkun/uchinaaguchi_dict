// 入力値を正規化する

export const normalize_text = (text: string): string => {
  return text
    .trim()
    .replace(/[\u30a1-\u30f6]/g, (match) =>
      String.fromCharCode(match.charCodeAt(0) - 0x60), // カナ から かな
    )
    .replace(/ゐ/g, "ぃい")
    .replace(/うぇ/g, "ぇえ")
    .replace(/をぅ/g, "ぅう")
    .replace(/ー/g, "ー");
};
