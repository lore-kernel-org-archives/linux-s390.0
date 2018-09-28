From: =?UTF-8?q?Leonardo=20Br=C3=A1s?= <leobras.c@gmail.com>
Subject: [PATCH v3 2/7] drivers: nubus: Avoids building driver if CONFIG_NUBUS is disabled
Date: Thu, 27 Sep 2018 23:08:11 -0300
Message-ID: <20180928020816.11251-3-leobras.c@gmail.com>
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

Avoids building driver if 'make drivers/nubus/' is called and
CONFIG_NUBUS is disabled.
Avoids building proc.o if CONFIG_PROC_FS is enabled but
CONFIG_NUBUS is disabled.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/nubus/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nubus/Makefile b/drivers/nubus/Makefile
index 6d063cde39d1..1daa51217e95 100644
--- a/drivers/nubus/Makefile
+++ b/drivers/nubus/Makefile
@@ -2,6 +2,7 @@
 # Makefile for the nubus specific drivers.
 #
 
-obj-y := nubus.o bus.o
+obj-$(CONFIG_NUBUS) := nubus_all.o
+nubus_all-y += bus.o nubus.o
 
-obj-$(CONFIG_PROC_FS) += proc.o
+nubus_all-$(CONFIG_PROC_FS) += proc.o
-- 
2.19.0
