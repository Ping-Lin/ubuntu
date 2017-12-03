#!/usr/bin/env python
# markdown: http://daringfireball.net/projects/markdown/
# python markdown module: http://pythonhosted.org/Markdown/reference.html#the-details
#                         http://pythonhosted.org//Markdown/siteindex.html
# code highlight http://softwaremaniacs.org/soft/highlight/en/


try:
    import markdown
    import vim
    import string
    import os
    import re

    html_header = '''
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>''' + vim.current.buffer.name + '''</title>
    <link href="/assets/css/bootstrap.css" rel="stylesheet">
    <link href="/assets/css/docs.min.css" rel="stylesheet">
    <link href="/assets/css/markdown.css" rel="stylesheet">
    <link href="/assets/css/github.css" rel="stylesheet">
  </head>
<body>
  <div class="container bs-docs-container">
    <div class="row">
      <div class="col-md-9" role="main">
'''
    html_tailer = '''
      </div>
    </div>
  </div>
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
  <script type="text/javascript" src="/assets/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="/assets/js/docs.min.js"></script>
  <script src="http://yandex.st/highlightjs/7.3/highlight.min.js"></script>
  <script>
    hljs.initHighlightingOnLoad();
  </script>
</body>
</html>
'''

    text = string.join(vim.current.buffer, "\n").decode('utf8')
    html = markdown.markdown(text, extensions = ['extra', 'toc'], output_format = 'html5').encode('utf8')
    html = re.sub('<table>', '<table class="table">', html);
    html = re.sub('<dl>', '<dl class="dl-horizontal">', html);

    pat = re.compile('<div class="toc">.*</div>', re.S | re.M)
    m = pat.search(html)
    if m:
        toc = m.group(0)
        toc = re.sub('<ul>', '<ul class="nav">', toc)
        toc = re.sub('<ul class="nav">', '<ul class="nav bs-docs-sidenav">', toc)
        toc = re.sub('<div class="toc">', '<div class="bs-docs-sidebar hidden-print affix" role="complementary">', toc)
        out_html = html[:m.start()]
        out_html += '</div><div class="col-md-3">'
        out_html += toc
        out_html += html[m.end():]
        html = out_html;

    out = vim.current.buffer.name + ".html"

    with open(out, 'w') as fp:
        fp.write(html_header)
        fp.write(html)
        fp.write(html_tailer)

    print "HTML output written to " + out 

except ImportError, e:
    print "Markdown package not installed, please run: pip install markdown"
