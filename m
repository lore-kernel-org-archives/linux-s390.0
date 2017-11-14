Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/9] s390: block: add SPDX identifiers to the remaining files
Date: Tue, 14 Nov 2017 18:38:00 +0100
Message-Id: <20171114173808.25092-2-gregkh@linuxfoundation.org>
In-Reply-To: <20171114173808.25092-1-gregkh@linuxfoundation.org>
References: <20171114173808.25092-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stefan Haberland <sth@linux.vnet.ibm.com>, Jan Hoeppner <hoeppner@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>
List-ID: <linux-s390.vger.kernel.org>

It's good to have SPDX identifiers in all files to make it easier to
audit the kernel tree for correct licenses.

Update the drivers/s390/block/ files with the correct SPDX license
identifier based on the license text in the file itself.  The SPDX
identifier is a legally binding shorthand, which can be used instead of
the full boiler plate text.

This work is based on a script and data from Thomas Gleixner, Philippe
Ombredanne, and Kate Stewart.

Cc: Stefan Haberland <sth@linux.vnet.ibm.com>
Cc: Jan Hoeppner <hoeppner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/block/dasd.c        | 1 +
 drivers/s390/block/dasd_devmap.c | 1 +
 drivers/s390/block/dasd_diag.c   | 1 +
 drivers/s390/block/dasd_eckd.c   | 1 +
 drivers/s390/block/dasd_fba.c    | 1 +
 drivers/s390/block/dcssblk.c     | 1 +
 drivers/s390/block/scm_blk.c     | 1 +
 drivers/s390/block/xpram.c       | 1 +
 8 files changed, 8 insertions(+)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 29f35e29d480..fdb3b133e5e0 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
  *		    Horst Hummel <Horst.Hummel@de.ibm.com>
diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index c95a4784c191..e7cd28ff1984 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
  *		    Horst Hummel <Horst.Hummel@de.ibm.com>
diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index 98fb28e49d2c..f035c2f25d35 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
  * Based on.......: linux/drivers/s390/block/mdisk.c
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 8eafcd5fa004..1a41ef496338 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
  *		    Horst Hummel <Horst.Hummel@de.ibm.com>
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 6168ccdb389c..a6b132f7e869 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
  * Bugreports.to..: <Linux390@de.ibm.com>
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 7abb240847c0..6aaefb780436 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * dcssblk.c -- the S/390 block driver for dcss memory
  *
diff --git a/drivers/s390/block/scm_blk.c b/drivers/s390/block/scm_blk.c
index eb51893c74a4..b4130c7880d8 100644
--- a/drivers/s390/block/scm_blk.c
+++ b/drivers/s390/block/scm_blk.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Block driver for s390 storage class memory.
  *
diff --git a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
index 571a0709e1e5..2a6334ca750e 100644
--- a/drivers/s390/block/xpram.c
+++ b/drivers/s390/block/xpram.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Xpram.c -- the S/390 expanded memory RAM-disk
  *           
-- 
2.15.0
