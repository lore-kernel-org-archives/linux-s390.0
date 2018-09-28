From: =?UTF-8?q?Leonardo=20Br=C3=A1s?= <leobras.c@gmail.com>
Subject: [PATCH v3 6/7] drivers: oprofile: Avoids building driver from direct make command
Date: Thu, 27 Sep 2018 23:08:15 -0300
Message-ID: <20180928020816.11251-7-leobras.c@gmail.com>
References: <20180928020816.11251-1-leobras.c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180928020816.11251-1-leobras.c@gmail.com>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: lkcamp@lists.libreplanetbr.org
Cc: =?UTF-8?q?Leonardo=20Br=C3=A1s?= <leobras.c@gmail.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Finn Thain <fthain@telegraphics.com.au>, Robert Richter <rric@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
Content-Transfer-Encoding: 8bit

Creates new Makefile to avoid building driver if
'make drivers/oprofile/' is called directly.

This driver is usually built from arch/$ARCH and seems to have
no meaning building alone.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/oprofile/Makefile | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 drivers/oprofile/Makefile

diff --git a/drivers/oprofile/Makefile b/drivers/oprofile/Makefile
new file mode 100644
index 000000000000..361867ec2338
--- /dev/null
+++ b/drivers/oprofile/Makefile
@@ -0,0 +1 @@
+#Does nothing, since the source is called from arch/$ARCH/ tree.
-- 
2.19.0
