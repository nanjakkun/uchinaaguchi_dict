import type { TextMatchMode } from "./TextMatchMode";

export type LookupRequestT = {
  dict: string[][];
  text: string;
  textMacthMode: TextMatchMode;
};
