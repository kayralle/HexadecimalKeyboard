"""
VCU Brandcenter Copywriter Portfolio Scraper

Scrapes https://brandcenter.vcu.edu/student-portfolios/?_sfm_role=482
and collects the portfolio URL for each copywriter.

Requirements:
    pip install playwright
    playwright install chromium

Run:
    python3 scrape_copywriters.py
"""

import asyncio
import json
import csv
from playwright.async_api import async_playwright


BASE_URL = "https://brandcenter.vcu.edu/student-portfolios/?_sfm_role=482"


async def get_profile_links(page):
    """Return list of (name, profile_url) for every copywriter card on the listing page."""
    await page.goto(BASE_URL, wait_until="networkidle")

    # SearchAndFilter Pro renders cards — wait for at least one to appear.
    await page.wait_for_selector(".sfp-post-container, .sf-post-thumbnail, article, .student-card", timeout=15000)

    # Grab every anchor inside the result set whose text isn't "Portfolio" —
    # that gives us the name links pointing to individual profile pages.
    # Adjust the selector below if the site's HTML differs.
    cards = await page.query_selector_all(".sfp-post-container, article.student")
    results = []

    if cards:
        for card in cards:
            # Try to find the name link
            name_el = await card.query_selector("h2 a, h3 a, .entry-title a, .student-name a, a.name")
            if not name_el:
                # Fall back: first <a> that is NOT labelled "Portfolio"
                anchors = await card.query_selector_all("a")
                for a in anchors:
                    text = (await a.inner_text()).strip()
                    if text and text.lower() != "portfolio":
                        name_el = a
                        break

            if name_el:
                name = (await name_el.inner_text()).strip()
                href = await name_el.get_attribute("href")
                if href:
                    results.append((name, href))
    else:
        # Fallback: grab all links on the page and filter by context
        anchors = await page.query_selector_all("a")
        seen = set()
        for a in anchors:
            href = await a.get_attribute("href") or ""
            text = (await a.inner_text()).strip()
            if (
                href
                and text
                and text.lower() not in ("portfolio", "")
                and "/student-portfolios/" in href
                and href not in seen
            ):
                seen.add(href)
                results.append((text, href))

    return results


async def get_portfolio_url(page, profile_url: str) -> str | None:
    """Visit a student's profile page and return the URL of their Portfolio link."""
    await page.goto(profile_url, wait_until="networkidle")

    # Look for a link whose visible text is exactly "Portfolio" (case-insensitive)
    anchors = await page.query_selector_all("a")
    for a in anchors:
        text = (await a.inner_text()).strip()
        if text.lower() == "portfolio":
            href = await a.get_attribute("href")
            return href

    # Second pass: look for aria-label or title attributes
    for a in anchors:
        label = (await a.get_attribute("aria-label") or "").strip()
        title = (await a.get_attribute("title") or "").strip()
        if label.lower() == "portfolio" or title.lower() == "portfolio":
            href = await a.get_attribute("href")
            return href

    return None


async def main():
    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=True)
        context = await browser.new_context(
            user_agent=(
                "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) "
                "AppleWebKit/537.36 (KHTML, like Gecko) "
                "Chrome/120.0.0.0 Safari/537.36"
            ),
        )
        page = await context.new_page()

        print(f"Loading copywriter listing: {BASE_URL}\n")
        profile_links = await get_profile_links(page)

        if not profile_links:
            print("No copywriter profiles found — the page selector may need updating.")
            await browser.close()
            return

        print(f"Found {len(profile_links)} copywriter(s). Visiting each profile...\n")

        results = []
        for name, profile_url in profile_links:
            print(f"  {name} — {profile_url}")
            portfolio_url = await get_portfolio_url(page, profile_url)
            if portfolio_url:
                print(f"    Portfolio: {portfolio_url}")
            else:
                print(f"    Portfolio: (not found)")
            results.append({
                "name": name,
                "profile_page": profile_url,
                "portfolio_url": portfolio_url or "",
            })

        await browser.close()

        # Save results
        with open("copywriter_portfolios.json", "w") as f:
            json.dump(results, f, indent=2)

        with open("copywriter_portfolios.csv", "w", newline="") as f:
            writer = csv.DictWriter(f, fieldnames=["name", "profile_page", "portfolio_url"])
            writer.writeheader()
            writer.writerows(results)

        print(f"\nDone! Results saved to copywriter_portfolios.json and copywriter_portfolios.csv")
        print("\n--- Summary ---")
        for r in results:
            print(f"{r['name']}: {r['portfolio_url'] or '(no portfolio link found)'}")


if __name__ == "__main__":
    asyncio.run(main())
