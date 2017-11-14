Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4/9] s390: char: add SPDX identifiers to the remaining files
Date: Tue, 14 Nov 2017 18:38:03 +0100
Message-Id: <20171114173808.25092-5-gregkh@linuxfoundation.org>
In-Reply-To: <20171114173808.25092-1-gregkh@linuxfoundation.org>
References: <20171114173808.25092-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>
List-ID: <linux-s390.vger.kernel.org>

It's good to have SPDX identifiers in all files to make it easier to
audit the kernel tree for correct licenses.

Update the drivers/s390/char/ files with the correct SPDX license
identifier based on the license text in the file itself.  The SPDX
identifier is a legally binding shorthand, which can be used instead of
the full boiler plate text.

This work is based on a script and data from Thomas Gleixner, Philippe
Ombredanne, and Kate Stewart.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/char/fs3270.c     | 1 +
 drivers/s390/char/hmcdrv_mod.c | 1 +
 drivers/s390/char/monreader.c  | 1 +
 drivers/s390/char/monwriter.c  | 1 +
 drivers/s390/char/raw3270.c    | 1 +
 drivers/s390/char/sclp_async.c | 1 +
 drivers/s390/char/tape_34xx.c  | 1 +
 drivers/s390/char/tape_3590.c  | 1 +
 drivers/s390/char/tape_class.c | 1 +
 drivers/s390/char/tape_core.c  | 1 +
 drivers/s390/char/tty3270.c    | 1 +
 drivers/s390/char/vmlogrdr.c   | 1 +
 drivers/s390/char/vmur.c       | 1 +
 drivers/s390/char/zcore.c      | 1 +
 14 files changed, 14 insertions(+)

diff --git a/drivers/s390/char/fs3270.c b/drivers/s390/char/fs3270.c
index c4518168fd02..61822480a2a0 100644
--- a/drivers/s390/char/fs3270.c
+++ b/drivers/s390/char/fs3270.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * IBM/3270 Driver - fullscreen driver.
  *
diff --git a/drivers/s390/char/hmcdrv_mod.c b/drivers/s390/char/hmcdrv_mod.c
index 251a318a9b75..1447d0887225 100644
--- a/drivers/s390/char/hmcdrv_mod.c
+++ b/drivers/s390/char/hmcdrv_mod.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *    HMC Drive DVD Module
  *
diff --git a/drivers/s390/char/monreader.c b/drivers/s390/char/monreader.c
index 027ac6ae5eea..bf4ab4efed73 100644
--- a/drivers/s390/char/monreader.c
+++ b/drivers/s390/char/monreader.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Character device driver for reading z/VM *MONITOR service records.
  *
diff --git a/drivers/s390/char/monwriter.c b/drivers/s390/char/monwriter.c
index 571a7e352755..76c158c41510 100644
--- a/drivers/s390/char/monwriter.c
+++ b/drivers/s390/char/monwriter.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Character device driver for writing z/VM *MONITOR service records.
  *
diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index 5d4f053d7c38..f8cd2935fbfd 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * IBM/3270 Driver - core functions.
  *
diff --git a/drivers/s390/char/sclp_async.c b/drivers/s390/char/sclp_async.c
index 19c25427f27f..ee6f3b563728 100644
--- a/drivers/s390/char/sclp_async.c
+++ b/drivers/s390/char/sclp_async.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Enable Asynchronous Notification via SCLP.
  *
diff --git a/drivers/s390/char/tape_34xx.c b/drivers/s390/char/tape_34xx.c
index de69f0ddc321..6d73ee3f827a 100644
--- a/drivers/s390/char/tape_34xx.c
+++ b/drivers/s390/char/tape_34xx.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *    tape device discipline for 3480/3490 tapes.
  *
diff --git a/drivers/s390/char/tape_3590.c b/drivers/s390/char/tape_3590.c
index e352047ed9f7..37e65a05517f 100644
--- a/drivers/s390/char/tape_3590.c
+++ b/drivers/s390/char/tape_3590.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *    tape device discipline for 3590 tapes.
  *
diff --git a/drivers/s390/char/tape_class.c b/drivers/s390/char/tape_class.c
index e7d23048d3f0..a07102472ce9 100644
--- a/drivers/s390/char/tape_class.c
+++ b/drivers/s390/char/tape_class.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright IBM Corp. 2004
  *
diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
index 9dd4534823b3..07d7448b94e0 100644
--- a/drivers/s390/char/tape_core.c
+++ b/drivers/s390/char/tape_core.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *    basic function of the tape device driver
  *
diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index e5ebe2fbee23..527475528bf4 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *    IBM/3270 Driver - tty functions.
  *
diff --git a/drivers/s390/char/vmlogrdr.c b/drivers/s390/char/vmlogrdr.c
index 62559dc0169f..069b9ef08206 100644
--- a/drivers/s390/char/vmlogrdr.c
+++ b/drivers/s390/char/vmlogrdr.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *	character device driver for reading z/VM system service records
  *
diff --git a/drivers/s390/char/vmur.c b/drivers/s390/char/vmur.c
index fa90ef05afc0..52aa89424318 100644
--- a/drivers/s390/char/vmur.c
+++ b/drivers/s390/char/vmur.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Linux driver for System z and s390 unit record devices
  * (z/VM virtual punch, reader, printer)
diff --git a/drivers/s390/char/zcore.c b/drivers/s390/char/zcore.c
index aaed778f67c4..dd86559ce7fb 100644
--- a/drivers/s390/char/zcore.c
+++ b/drivers/s390/char/zcore.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-1.0+
 /*
  * zcore module to export memory content and register sets for creating system
  * dumps on SCSI disks (zfcpdump). The "zcore/mem" debugfs file shows the same
-- 
2.15.0
