import React from "react";
import { useEffect, useState } from "react";

import { look_up } from "@/components/dictionary/look_up";
import { ResultRow } from "@/components/dictionary/ResultRow";
import type { LookupResponse } from "@/types/LookupResponse";

const base_url = import.meta.env.BASE_URL;

/**
 * 辞書
 *
 * @returns JSX.Element
 */
export const Dictionary = () => {
  const [loading, setLoading] = useState(true);
  const [dict, setDict] = useState<string[][]>([]);
  const [text, setText] = useState("");

  const [lookupRes, setLookupRes] = useState<LookupResponse>({
    count: 0,
    rows: [],
  });

  // TODO: URLパラメータを受け取ってあらかじめinputに値をセットする
  useEffect(() => {
    const fetchCSV = async () => {
      const promise = (await fetch(base_url + "/data/okinawa2.csv")).text();
      const rows = (await promise).split("\n");

      setDict(rows.map((r) => r.split(",")));
    };
    fetchCSV();
    setLoading(false);
  }, []);

  useEffect(() => {
    const res = look_up({
      dict,
      text,
      mode: "forward",
    });

    // TODO: URLを操作

    // TODO: debounceで動作が軽くなるか検証

    setLookupRes(res);
  }, [text]);

  // TODO: loading中は操作できなくする

  return (
    <div className="">
      <div className="flex justify-center">
        <input
          type="text"
          className="border border-black outline outline-cyan-500"
          placeholder="検索したい言葉を入力"
          value={text}
          onChange={(e) => {
            setText(e.target.value);
          }}
        />
      </div>
      <div>
        <p>{lookupRes.count} 件の検索結果</p>
        <div>
          {lookupRes.rows.map((row) => {
            return <ResultRow row={row} />;
          })}
        </div>
      </div>
    </div>
  );
};
