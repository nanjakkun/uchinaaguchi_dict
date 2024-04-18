import React from "react";
import { useEffect, useState } from "react";

const base_url = import.meta.env.BASE_URL;

/**
 * 辞書
 *
 * @returns JSX.Element
 */
export const Dictionary = () => {
  const [loading, setLoading] = useState(true);
  const [rows, setRows] = useState<string[]>([])

  useEffect(() => {
    const fetchCSV = async () => {
      const promise = (await fetch(base_url + "/data/okinawa2.csv")).text();
      const rows = (await promise).split("\n")

      // TODO: 列分解
      setRows(rows);
    }
    fetchCSV();
    setLoading(false);
  }, []);

  return (
    <div className="">
      <div className="flex justify-center">
        <input className="border" placeholder="検索したい言葉を入力して下さい" />
      </div>
      <div></div>
    </div>
  );
}
