export interface Env {
	DB: D1Database
}

export default {
	async fetch(request: Request, env: Env, ctx: ExecutionContext): Promise<Response> {
	  const { pathname } = new URL(request.url);

	  var matched = pathname.match(/^\/(\d+)/)

	  if (matched) {
			const { results } = await env.DB.prepare(
				"SELECT * FROM Customers WHERE CustomerID = ?"
			)
				.bind(matched[1])
				.all();

			return Response.json(results);
	  }

	  return new Response("Hello, world");
	},
};
