// Approximate visitor location from the IP, as Netlify's edge already knows it.
// Used only to show nearby addresses first in the booking form; nothing is stored.
export default async (request, context) => {
  const g = (context && context.geo) || {};
  const body = {
    lat: typeof g.latitude === "number" ? g.latitude : null,
    lon: typeof g.longitude === "number" ? g.longitude : null,
    cc: g.country && g.country.code ? String(g.country.code).toLowerCase() : null,
    city: g.city || null,
  };
  return new Response(JSON.stringify(body), {
    headers: { "content-type": "application/json; charset=utf-8", "cache-control": "private, no-store" },
  });
};

export const config = { path: "/api/geo" };
