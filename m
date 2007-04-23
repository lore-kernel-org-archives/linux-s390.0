Return-Path: <linux-kernel-owner+w=401wt.eu-S932659AbXDWONb@vger.kernel.org>
Date: Mon, 23 Apr 2007 16:13:42 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 6/9] Kconfig: no wireless on s390.
Message-ID: <20070423141342.GG21174@skybase>
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

Hide the config menues for wireless on s390.
Goes on top of git-wireless.patch.

Cc: John W. Linville <linville@tuxdriver.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/net/wireless/Kconfig |    1 +
 net/Kconfig                  |    1 +
 2 files changed, 2 insertions(+)

diff -urpN linux-2.6/drivers/net/wireless/Kconfig linux-2.6-patched/drivers/net/wireless/Kconfig
--- linux-2.6/drivers/net/wireless/Kconfig	2007-04-23 15:51:50.000000000 +0200
+++ linux-2.6-patched/drivers/net/wireless/Kconfig	2007-04-23 15:53:12.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Wireless LAN"
+	depends on !S390
 
 config WLAN_PRE80211
 	bool "Wireless LAN (pre-802.11)"
diff -urpN linux-2.6/net/Kconfig linux-2.6-patched/net/Kconfig
--- linux-2.6/net/Kconfig	2007-04-23 15:52:26.000000000 +0200
+++ linux-2.6-patched/net/Kconfig	2007-04-23 15:53:12.000000000 +0200
@@ -217,6 +217,7 @@ config FIB_RULES
 	bool
 
 menu "Wireless"
+	depends on !S390
 
 source "net/wireless/Kconfig"
 source "net/mac80211/Kconfig"
