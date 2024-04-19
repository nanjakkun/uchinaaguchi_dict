import type { LookupRequestT } from "@/types/LookupRequestT";
import type { LookupResponseT } from "@/types/LookupResponseT";

const PAGE_SIZE = 20;
const KANA_1_INDEX = 3;
const MEANING_1_INDEX = 10;

/*
  Lookup words from dictionary
*/
export const look_up = ({
  dict,
  text,
  mode,
}: LookupRequestT): LookupResponseT => {
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
    // skip header
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
        break;
      case "backward":
        for (let i = 0; i < 3; i++) {
          matched = matched || row[KANA_1_INDEX + i].endsWith(trimmed);
        }
        break;
      case "exact":
        for (let i = 0; i < 3; i++) {
          matched = matched || row[KANA_1_INDEX + i] == trimmed;
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
