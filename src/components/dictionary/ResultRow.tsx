/**
 * Lookup Result Row
 */

type Props = {
  row: string[];
};

export const ResultRow = ({ row }: Props) => {
  return <div key={row[0]}>
    <hr />
      <h2 className="font-bold m-2">{row[3]}</h2>
      <p className="pl-2">{row[10]}</p>
    <hr />
  </div>;
};
