From: =?UTF-8?q?Leonardo=20Br=C3=A1s?= <leobras.c@gmail.com>
Subject: [PATCH v3 7/7] drivers: hwtracing: Adds Makefile to enable building from directory.
Date: Thu, 27 Sep 2018 23:08:16 -0300
Message-ID: <20180928020816.11251-8-leobras.c@gmail.com>
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

Adds Makefile to enable building the driver using
'make drivers/hwtracing/'.
Changes drivers/Makefile to call the new Makefile directly.
It enables user building this driver without building the whole drivers/
subtree.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/Makefile           | 4 +---
 drivers/hwtracing/Makefile | 3 +++
 2 files changed, 4 insertions(+), 3 deletions(-)
 create mode 100644 drivers/hwtracing/Makefile

diff --git a/drivers/Makefile b/drivers/Makefile
index 578f469f72fb..a237be6b602f 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -174,9 +174,7 @@ obj-$(CONFIG_MCB)		+= mcb/
 obj-$(CONFIG_PERF_EVENTS)	+= perf/
 obj-$(CONFIG_RAS)		+= ras/
 obj-$(CONFIG_THUNDERBOLT)	+= thunderbolt/
-obj-$(CONFIG_CORESIGHT)		+= hwtracing/coresight/
-obj-y				+= hwtracing/intel_th/
-obj-$(CONFIG_STM)		+= hwtracing/stm/
+obj-y				+= hwtracing/
 obj-$(CONFIG_ANDROID)		+= android/
 obj-$(CONFIG_NVMEM)		+= nvmem/
 obj-$(CONFIG_FPGA)		+= fpga/
diff --git a/drivers/hwtracing/Makefile b/drivers/hwtracing/Makefile
new file mode 100644
index 000000000000..fe5773caec49
--- /dev/null
+++ b/drivers/hwtracing/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_CORESIGHT)		+= coresight/
+obj-y				+= intel_th/
+obj-$(CONFIG_STM)		+= stm/
-- 
2.19.0
