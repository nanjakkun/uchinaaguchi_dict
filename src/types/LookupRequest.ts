export type LookupRequest = {
  dict: string[][];
  text: string;
  mode: "forward" | "backward" | "exact" | "body";
};
