Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:57042 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729351AbfGISde (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Jul 2019 14:33:34 -0400
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 0/5] PDF output fixes
Date: Tue,  9 Jul 2019 15:33:18 -0300
Message-Id: <cover.1562696797.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hannes Reinecke <hare@suse.com>, linux-kbuild@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Dan Williams <dan.j.williams@intel.com>, Michal Marek <michal.lkml@markovi.net>, Masahiro Yamada <yamada.masahiro@socionext.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-doc@vger.kernel.org, Omar Sandoval <osandov@fb.com>

In order to be able to build all PDF books, besides the two patches I
already sent:

    docs: pdf: add all Documentation/*/index.rst to PDF output
    docs: automarkup.py: ignore exceptions when seeking for xrefs

A few others are needed:

- patch 1 removes nested tables for a few files I converted, as 
  Sphinx LaTeX builder doesn't support it;
- Patches 2 to 4 addresses some minor issues on some books,
  usually requiring some blank lines, extra whitespaces or some
  tag replacement;
- Patch 5 is required in order to be able to build the translations
  PDF book, as it adds Asian fonts support to XeLaTeX.

This patch series is at:

	https://git.linuxtv.org/mchehab/experimental.git/log/?h=extra_fixes_v1

And it is on the top of the ReST conversions that IMO should be
sent at the end of this merge window.

Mauro Carvalho Chehab (5):
  docs: don't use nested tables
  docs: arm: fix a breakage with pdf output
  docs: block: fix pdf output
  docs: kbuild: fix build with pdf and fix some minor issues
  docs: conf.py: add CJK package needed by translations

 Documentation/admin-guide/laptops/sonypi.rst  | 26 +++++++++----------
 .../admin-guide/laptops/toshiba_haps.rst      |  8 +++---
 Documentation/arm/spear/overview.rst          |  1 +
 Documentation/block/biodoc.rst                |  9 ++++---
 Documentation/conf.py                         |  4 +++
 Documentation/driver-api/nvdimm/btt.rst       |  2 +-
 Documentation/kbuild/issues.rst               | 20 ++++++++------
 Documentation/kbuild/kbuild.rst               |  3 ++-
 Documentation/kbuild/kconfig-language.rst     | 12 +++++++++
 Documentation/kbuild/kconfig.rst              |  8 ++++--
 Documentation/kbuild/makefiles.rst            |  1 +
 Documentation/s390/debugging390.rst           |  2 +-
 12 files changed, 61 insertions(+), 35 deletions(-)

-- 
2.21.0
