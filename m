From: Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
Subject: [PATCH 5/7] drivers: s390: Avoids building drivers if ARCH is not
 s390.
Date: Tue, 25 Sep 2018 22:52:54 -0300
Message-ID: <20180926015254.GA14984@WindFlash>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: lkcamp@lists.libreplanetbr.org
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Finn Thain <fthain@telegraphics.com.au>, Robert Richter <rric@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
Content-Transfer-Encoding: 8bit

Avoids building s390 drivers if 'make drivers/s390/' is called but
ARCH is not s390.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/s390/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/Makefile b/drivers/s390/Makefile
index a863b0462b43..0575f02dba45 100644
--- a/drivers/s390/Makefile
+++ b/drivers/s390/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the S/390 specific device drivers
 #
 
-obj-y += cio/ block/ char/ crypto/ net/ scsi/ virtio/
-
-drivers-y += drivers/s390/built-in.a
-
+ifeq ($(ARCH),s390)
+	obj-y += cio/ block/ char/ crypto/ net/ scsi/ virtio/
+	drivers-y += drivers/s390/built-in.a
+endif
-- 
2.19.0
