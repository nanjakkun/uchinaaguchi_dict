import type { LookupRequest } from "@/types/LookupRequest";
import type { LookupResponse } from "@/types/LookupResponse";

const PAGE_SIZE = 20;
const KANA_1_INDEX = 3;
const MEANING_1_INDEX = 10;

/*
  辞書データを与えられたテキストで絞り込む
*/
export const look_up = ({
  dict,
  text,
  mode,
}: LookupRequest): LookupResponse => {
  const trimmed = text.trim();

  if (trimmed.length < 2) {
    return {
      count: 0,
      rows: [],
    };
  }

  let rows: any[] = [];
  let count = 0;

  for (let row of dict) {
    // ヘッダ行は飛ばす
    if (row[0] == "id") {
      continue;
    }

    if (row.length < MEANING_1_INDEX + 4) {
      continue;
    }

    let matched = false;

    switch (mode) {
      case "forward":
        for (let i = 0; i < 3; i++) {
          matched = matched || row[KANA_1_INDEX + i].startsWith(trimmed);
        }
      case "backward":
        for (let i = 0; i < 3; i++) {
          matched = matched || row[KANA_1_INDEX + i].endsWith(trimmed);
        }
      case "exact":
        for (let i = 0; i < 3; i++) {
          matched = matched || row[KANA_1_INDEX + i] == trimmed;
        }
      case "body":
      // TODO:
    }

    if (matched) {
      count += 1;
      if (row.length <= PAGE_SIZE) {
        rows.push(row);
      }
    }
  }

  return {
    count,
    rows,
  };
};
