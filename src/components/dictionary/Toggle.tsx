import type { TextMatchMode } from "@/types/TextMatchMode";
import type { ChangeEvent } from "react";

type Props = {
  onChange: (event: ChangeEvent<HTMLInputElement>) => void;
  selected: TextMatchMode;
};

const options: { value: TextMatchMode; label: string }[] = [
  { value: "forward", label: "から始まる" },
  { value: "backward", label: "で終わる" },
  { value: "body", label: "を本文に含む" },
];

export const Toggle = (props: Props) => {
  return (
    <>
      {options.map((option) => (
        <label key={option.value} className="mr-3">
          <input
            type="radio"
            value={option.value}
            checked={props.selected === option.value}
            onChange={props.onChange}
          />
          {option.label}
        </label>
      ))}
    </>
  );
};
