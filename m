Return-Path: <linux-kernel-owner+w=401wt.eu-S932785AbXDWOOF@vger.kernel.org>
Date: Mon, 23 Apr 2007 16:14:12 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 8/9] Kconfig: silicon backplane dependency.
Message-ID: <20070423141412.GI21174@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: akpm@linux-foundation.org, mb@bu3sch.de, linville@tuxdriver.com, arnd@arndb.de, maxextreme@gmail.com, gregkh@suse.de
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Add HAS_IOMEM dependency to the "Sonics Silicon Backplane" menu.
This hides the menu for s390.
Goes on top of git-wireless.patch.

Cc: Michael Buesch <mb@bu3sch.de>
Cc: John W. Linville <linville@tuxdriver.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/ssb/Kconfig |    1 +
 1 files changed, 1 insertion(+)

diff -urpN linux-2.6/drivers/ssb/Kconfig linux-2.6-patched/drivers/ssb/Kconfig
--- linux-2.6/drivers/ssb/Kconfig	2007-04-23 15:51:57.000000000 +0200
+++ linux-2.6-patched/drivers/ssb/Kconfig	2007-04-23 15:53:15.000000000 +0200
@@ -1,4 +1,5 @@
 menu "Sonics Silicon Backplane"
+	depends on HAS_IOMEM
 
 config SSB
 	tristate "Sonics Silicon Backplane support"
