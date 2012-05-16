def xmltemplate()
  '<?xml version=\"1.0\" encoding=\"utf-8\"?>
<product>
  <projectCode />
  <productNumber>#{sku}</productNumber>
  <title>#{title}</title>
  <ingress></ingress>
  <text>
    <main>#{main}</main>
    <tie-in>#{tiein}</tie-in>
  </text>
  <format />
  <visible>false</visible>
  <weight />
  <available />
  <priority />
  <recommendedAge />
  <url>#{url}</url>
  <image1>cover.jpg</image1>
  <image2>#{spread}</image2>
  <thumbnail />
  <created>#{date}</created>
  <removed />
  <published />
  <ageCategories />
</product>'
end

def createxml (sku, title, main, tiein, url, date, spread)
  eval('"' + xmltemplate() + '"')
end
