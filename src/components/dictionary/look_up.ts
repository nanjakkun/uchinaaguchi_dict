import type { LookupRequestT } from "@/types/LookupRequestT";
import type { LookupResponseT } from "@/types/LookupResponseT";
import { ColumnIndex } from "@/components/dictionary/ColumnIndex";
import { normalize_text } from "@/components/dictionary/normalize_text";

const PAGE_SIZE = 20;

/*
  Lookup words from dictionary
*/
export const look_up = ({
  dict,
  text,
  mode,
}: LookupRequestT): LookupResponseT => {
  const normalized = normalize_text(text);

  // TODO: 全角で文字数数える
  if (normalized.length < 2) {
    return {
      count: 0,
      rows: [],
    };
  }

  let rows: any[] = [];
  let count = 0;

  for (let row of dict) {
    // skip header
    if (row[ColumnIndex.ID] == "id") {
      continue;
    }

    if (row.length < ColumnIndex.MEANING_1 + 4) {
      continue;
    }

    let matched = false;

    switch (mode) {
      case "forward":
        for (let i = 0; i < 3; i++) {
          matched = matched || row[ColumnIndex.KANA_1 + i].startsWith(normalized);
        }
        break;
      case "backward":
        for (let i = 0; i < 3; i++) {
          matched = matched || row[ColumnIndex.KANA_1 + i].endsWith(normalized);
        }
        break;
      case "exact":
        for (let i = 0; i < 3; i++) {
          matched = matched || row[ColumnIndex.KANA_1 + i] == normalized;
        }
        break;
      case "body":
        // TODO:
        break;
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
