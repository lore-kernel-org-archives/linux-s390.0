Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 06/12] s390: appldata: add SPDX identifiers to the remaining files
Date: Fri, 24 Nov 2017 15:00:37 +0100
Message-Id: <20171124140043.10062-7-gregkh@linuxfoundation.org>
In-Reply-To: <20171124140043.10062-1-gregkh@linuxfoundation.org>
References: <20171124140043.10062-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>
List-ID: <linux-s390.vger.kernel.org>

It's good to have SPDX identifiers in all files to make it easier to
audit the kernel tree for correct licenses.

Update the arch/s390/appldata/ files with the correct SPDX license
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
 arch/s390/appldata/appldata_base.c    | 1 +
 arch/s390/appldata/appldata_mem.c     | 1 +
 arch/s390/appldata/appldata_net_sum.c | 1 +
 arch/s390/appldata/appldata_os.c      | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index ef3fb1b9201f..cb6e8066b1ad 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Base infrastructure for Linux-z/VM Monitor Stream, Stage 1.
  * Exports appldata_register_ops() and appldata_unregister_ops() for the
diff --git a/arch/s390/appldata/appldata_mem.c b/arch/s390/appldata/appldata_mem.c
index 598df5708501..e68136c3c23a 100644
--- a/arch/s390/appldata/appldata_mem.c
+++ b/arch/s390/appldata/appldata_mem.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Data gathering module for Linux-VM Monitor Stream, Stage 1.
  * Collects data related to memory management.
diff --git a/arch/s390/appldata/appldata_net_sum.c b/arch/s390/appldata/appldata_net_sum.c
index 66037d2622b4..8bc14b0d1def 100644
--- a/arch/s390/appldata/appldata_net_sum.c
+++ b/arch/s390/appldata/appldata_net_sum.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Data gathering module for Linux-VM Monitor Stream, Stage 1.
  * Collects accumulated network statistics (Packets received/transmitted,
diff --git a/arch/s390/appldata/appldata_os.c b/arch/s390/appldata/appldata_os.c
index 45b3178200ab..433a994b1a89 100644
--- a/arch/s390/appldata/appldata_os.c
+++ b/arch/s390/appldata/appldata_os.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Data gathering module for Linux-VM Monitor Stream, Stage 1.
  * Collects misc. OS related data (CPU utilization, running processes).
-- 
2.15.0
