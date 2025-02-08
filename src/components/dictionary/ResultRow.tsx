import { ColumnIndex } from "@/components/dictionary/ColumnIndex";
import "../../styles/global.css";

/**
 * Lookup Result Row
 */

type Props = {
  row: string[];
};

export const ResultRow = ({ row }: Props) => {
  const kana_str: string = [
    row[ColumnIndex.KANA_1],
    row[ColumnIndex.KANA_2],
    row[ColumnIndex.KANA_3],
  ]
    .filter((kana) => {
      return kana != "";
    })
    .join("、");

  return (
    <div key={row[0]}>
      <hr />
      <h2 className="font-bold m-2">{kana_str}</h2>
      <p className="pl-4 pb-2">{row[ColumnIndex.MEANING_1]}</p>
      <hr />
    </div>
  );
};
