import type { LookupRequestT } from "@/types/LookupRequestT";
import type { LookupResponseT } from "@/types/LookupResponseT";
import { ColumnIndex } from "@/components/dictionary/ColumnIndex";
import { normalize_text } from "@/components/dictionary/normalize_text";

const PAGE_SIZE = 500;

/*
  Lookup words from dictionary
*/
export const look_up = ({
  dict,
  text,
  textMacthMode,
}: LookupRequestT): LookupResponseT => {
  const normalized = normalize_text(text);

  if (normalized.length < 1) {
    return {
      count: 0,
      overflowed: false,
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

    switch (textMacthMode) {
      case "forward":
        for (let i = 0; i < 3; i++) {
          matched =
            matched || row[ColumnIndex.KANA_1 + i].startsWith(normalized);
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
        for (let i = 0; i < 5; i++) {
          matched =
            matched || row[ColumnIndex.MEANING_1].indexOf(normalized) >= 0;
        }
        break;
    }

    if (matched) {
      count += 1;
      rows.push(row);

      if (count >= PAGE_SIZE) {
        return {
          count,
          overflowed: true,
          rows,
        };
      }
    }
  }

  return {
    count,
    overflowed: false,
    rows,
  };
};
