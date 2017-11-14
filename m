Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5/9] s390: net: add SPDX identifiers to the remaining files
Date: Tue, 14 Nov 2017 18:38:04 +0100
Message-Id: <20171114173808.25092-6-gregkh@linuxfoundation.org>
In-Reply-To: <20171114173808.25092-1-gregkh@linuxfoundation.org>
References: <20171114173808.25092-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Julian Wiedmann <jwi@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>
List-ID: <linux-s390.vger.kernel.org>

It's good to have SPDX identifiers in all files to make it easier to
audit the kernel tree for correct licenses.

Update the drivers/s390/net/ files with the correct SPDX license
identifier based on the license text in the file itself.  The SPDX
identifier is a legally binding shorthand, which can be used instead of
the full boiler plate text.

This work is based on a script and data from Thomas Gleixner, Philippe
Ombredanne, and Kate Stewart.

Cc: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Cc: Ursula Braun <ubraun@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/ctcm_main.c      | 1 +
 drivers/s390/net/fsm.c            | 1 +
 drivers/s390/net/lcs.c            | 1 +
 drivers/s390/net/netiucv.c        | 1 +
 drivers/s390/net/qeth_core_main.c | 1 +
 drivers/s390/net/qeth_core_sys.c  | 1 +
 drivers/s390/net/qeth_l2_main.c   | 1 +
 drivers/s390/net/qeth_l3_main.c   | 1 +
 drivers/s390/net/smsgiucv.c       | 1 +
 drivers/s390/net/smsgiucv_app.c   | 1 +
 10 files changed, 10 insertions(+)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index be9f17218531..7ce98b70cad3 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright IBM Corp. 2001, 2009
  * Author(s):
diff --git a/drivers/s390/net/fsm.c b/drivers/s390/net/fsm.c
index 8c14c6c3ad3d..f0c7c182b077 100644
--- a/drivers/s390/net/fsm.c
+++ b/drivers/s390/net/fsm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /**
  * A generic FSM based on fsm used in isdn4linux
  *
diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index e131a03262ad..36899e94d268 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  Linux for S/390 Lan Channel Station Network Driver
  *
diff --git a/drivers/s390/net/netiucv.c b/drivers/s390/net/netiucv.c
index b9c7c1e61da2..150053131baf 100644
--- a/drivers/s390/net/netiucv.c
+++ b/drivers/s390/net/netiucv.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * IUCV network driver
  *
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 49b9efeba1bd..98a7f84540ab 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *    Copyright IBM Corp. 2007, 2009
  *    Author(s): Utz Bacher <utz.bacher@de.ibm.com>,
diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_sys.c
index b22ed2a57acd..ae81534de912 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *    Copyright IBM Corp. 2007
  *    Author(s): Utz Bacher <utz.bacher@de.ibm.com>,
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index d2537c09126d..93d7e345d180 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *    Copyright IBM Corp. 2007, 2009
  *    Author(s): Utz Bacher <utz.bacher@de.ibm.com>,
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index aadd384316a3..0f8c12738b06 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *    Copyright IBM Corp. 2007, 2009
  *    Author(s): Utz Bacher <utz.bacher@de.ibm.com>,
diff --git a/drivers/s390/net/smsgiucv.c b/drivers/s390/net/smsgiucv.c
index a851d34c642b..93405e0bad3c 100644
--- a/drivers/s390/net/smsgiucv.c
+++ b/drivers/s390/net/smsgiucv.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * IUCV special message driver
  *
diff --git a/drivers/s390/net/smsgiucv_app.c b/drivers/s390/net/smsgiucv_app.c
index 32515a201bbc..0a263999f7ae 100644
--- a/drivers/s390/net/smsgiucv_app.c
+++ b/drivers/s390/net/smsgiucv_app.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Deliver z/VM CP special messages (SMSG) as uevents.
  *
-- 
2.15.0
