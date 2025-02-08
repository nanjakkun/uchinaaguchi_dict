// https://astro.build/config
import { defineConfig } from 'astro/config';
import react from "@astrojs/react";

import tailwindcss from '@tailwindcss/vite';

// https://astro.build/config
export default defineConfig({
  site: 'https://nanjakkun.github.io',
  base: '/uchinaaguchi_dict',
  integrations: [react(), tailwindcss()],
  vite: {
    ssr: {
      noExternal: [],
    },
  },
});
