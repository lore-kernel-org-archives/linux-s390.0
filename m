Return-Path: <linux-kernel-owner+w=401wt.eu-S2993096AbXDTLex@vger.kernel.org>
Date: Fri, 20 Apr 2007 13:35:05 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 7/8] Kconfig: silicon backplane dependency.
Message-ID: <20070420113505.GH3738@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: akpm@linux-foundation.org, mb@bu3sch.de, linville@tuxdriver.com
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Make the "Sonics Silicon Backplane" menu dependent on the two buses
it can be found on.
Goes on top of git-wireless.patch.

Cc: Michael Buesch <mb@bu3sch.de>
Cc: John W. Linville <linville@tuxdriver.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/ssb/Kconfig |    1 +
 1 files changed, 1 insertion(+)

diff -urpN linux-2.6/drivers/ssb/Kconfig linux-2.6-patched/drivers/ssb/Kconfig
--- linux-2.6/drivers/ssb/Kconfig	2007-04-19 15:24:40.000000000 +0200
+++ linux-2.6-patched/drivers/ssb/Kconfig	2007-04-19 15:55:44.000000000 +0200
@@ -1,4 +1,5 @@
 menu "Sonics Silicon Backplane"
+	depends on PCI || PCMCIA
 
 config SSB
 	tristate "Sonics Silicon Backplane support"
