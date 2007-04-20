Return-Path: <linux-kernel-owner+w=401wt.eu-S2993082AbXDTLe0@vger.kernel.org>
Date: Fri, 20 Apr 2007 13:34:30 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 6/8] Kconfig: no userspace I/O on s390.
Message-ID: <20070420113430.GG3738@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: akpm@linux-foundation.org, gregkh@suse.de
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Hide the config menu for userspace I/O on s390.
Goes on top of gregkh-driver-uio.patch.

Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/uio/Kconfig |    2 ++
 1 files changed, 2 insertions(+)

diff -urpN linux-2.6/drivers/uio/Kconfig linux-2.6-patched/drivers/uio/Kconfig
--- linux-2.6/drivers/uio/Kconfig	2007-04-19 15:24:40.000000000 +0200
+++ linux-2.6-patched/drivers/uio/Kconfig	2007-04-20 10:51:24.000000000 +0200
@@ -1,4 +1,6 @@
 menu "Userspace I/O"
+	depends on !S390
+
 config UIO
 	tristate "Userspace I/O drivers"
 	default n
