export type LookupRequestT = {
  dict: string[][];
  text: string;
  mode: "forward" | "backward" | "exact" | "body";
};
