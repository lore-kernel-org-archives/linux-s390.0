Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/9] s390: crypto: add SPDX identifiers to the remaining files
Date: Tue, 14 Nov 2017 18:38:01 +0100
Message-Id: <20171114173808.25092-3-gregkh@linuxfoundation.org>
In-Reply-To: <20171114173808.25092-1-gregkh@linuxfoundation.org>
References: <20171114173808.25092-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Harald Freudenberger <freude@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>
List-ID: <linux-s390.vger.kernel.org>

It's good to have SPDX identifiers in all files to make it easier to
audit the kernel tree for correct licenses.

Update the drivers/s390/crypto/ files with the correct SPDX license
identifier based on the license text in the file itself.  The SPDX
identifier is a legally binding shorthand, which can be used instead of
the full boiler plate text.

This work is based on a script and data from Thomas Gleixner, Philippe
Ombredanne, and Kate Stewart.

Cc: Harald Freudenberger <freude@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/crypto/ap_bus.c           | 1 +
 drivers/s390/crypto/ap_bus.h           | 1 +
 drivers/s390/crypto/pkey_api.c         | 1 +
 drivers/s390/crypto/zcrypt_api.c       | 1 +
 drivers/s390/crypto/zcrypt_api.h       | 1 +
 drivers/s390/crypto/zcrypt_card.c      | 1 +
 drivers/s390/crypto/zcrypt_cca_key.h   | 1 +
 drivers/s390/crypto/zcrypt_cex2a.c     | 1 +
 drivers/s390/crypto/zcrypt_cex2a.h     | 1 +
 drivers/s390/crypto/zcrypt_cex4.c      | 1 +
 drivers/s390/crypto/zcrypt_error.h     | 1 +
 drivers/s390/crypto/zcrypt_msgtype50.c | 1 +
 drivers/s390/crypto/zcrypt_msgtype50.h | 1 +
 drivers/s390/crypto/zcrypt_msgtype6.c  | 1 +
 drivers/s390/crypto/zcrypt_msgtype6.h  | 1 +
 drivers/s390/crypto/zcrypt_pcixcc.c    | 1 +
 drivers/s390/crypto/zcrypt_pcixcc.h    | 1 +
 drivers/s390/crypto/zcrypt_queue.c     | 1 +
 18 files changed, 18 insertions(+)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 8b5658b0bec3..8c5fe6d925dd 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright IBM Corp. 2006, 2012
  * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 3a0e19d87e7c..9747d39bd0f4 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright IBM Corp. 2006, 2012
  * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 8dda5bb34a2f..869ace34972d 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  pkey device driver
  *
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index b5f4006198b9..bf35457ebd13 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  zcrypt 2.1.0
  *
diff --git a/drivers/s390/crypto/zcrypt_api.h b/drivers/s390/crypto/zcrypt_api.h
index 73541a798db7..4883d51521fd 100644
--- a/drivers/s390/crypto/zcrypt_api.h
+++ b/drivers/s390/crypto/zcrypt_api.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  zcrypt 2.1.0
  *
diff --git a/drivers/s390/crypto/zcrypt_card.c b/drivers/s390/crypto/zcrypt_card.c
index f85dacf1c284..c0e7072f18a9 100644
--- a/drivers/s390/crypto/zcrypt_card.c
+++ b/drivers/s390/crypto/zcrypt_card.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  zcrypt 2.1.0
  *
diff --git a/drivers/s390/crypto/zcrypt_cca_key.h b/drivers/s390/crypto/zcrypt_cca_key.h
index 12cff6262566..ebb9fbcb9bc0 100644
--- a/drivers/s390/crypto/zcrypt_cca_key.h
+++ b/drivers/s390/crypto/zcrypt_cca_key.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  zcrypt 2.1.0
  *
diff --git a/drivers/s390/crypto/zcrypt_cex2a.c b/drivers/s390/crypto/zcrypt_cex2a.c
index b97c5d5ee5a4..e00ffa44f85c 100644
--- a/drivers/s390/crypto/zcrypt_cex2a.c
+++ b/drivers/s390/crypto/zcrypt_cex2a.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  zcrypt 2.1.0
  *
diff --git a/drivers/s390/crypto/zcrypt_cex2a.h b/drivers/s390/crypto/zcrypt_cex2a.h
index 0dce4b9af184..6f6830e0bab3 100644
--- a/drivers/s390/crypto/zcrypt_cex2a.h
+++ b/drivers/s390/crypto/zcrypt_cex2a.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  zcrypt 2.1.0
  *
diff --git a/drivers/s390/crypto/zcrypt_cex4.c b/drivers/s390/crypto/zcrypt_cex4.c
index e2eebc775a37..f305538334ad 100644
--- a/drivers/s390/crypto/zcrypt_cex4.c
+++ b/drivers/s390/crypto/zcrypt_cex4.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright IBM Corp. 2012
  *  Author(s): Holger Dengler <hd@linux.vnet.ibm.com>
diff --git a/drivers/s390/crypto/zcrypt_error.h b/drivers/s390/crypto/zcrypt_error.h
index 13df60209ed3..8d8892d14bd0 100644
--- a/drivers/s390/crypto/zcrypt_error.h
+++ b/drivers/s390/crypto/zcrypt_error.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  zcrypt 2.1.0
  *
diff --git a/drivers/s390/crypto/zcrypt_msgtype50.c b/drivers/s390/crypto/zcrypt_msgtype50.c
index db5bde47dfb0..8fdf5d65c4d2 100644
--- a/drivers/s390/crypto/zcrypt_msgtype50.c
+++ b/drivers/s390/crypto/zcrypt_msgtype50.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  zcrypt 2.1.0
  *
diff --git a/drivers/s390/crypto/zcrypt_msgtype50.h b/drivers/s390/crypto/zcrypt_msgtype50.h
index 5cc280318ee7..f6ce799c2239 100644
--- a/drivers/s390/crypto/zcrypt_msgtype50.h
+++ b/drivers/s390/crypto/zcrypt_msgtype50.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  zcrypt 2.1.0
  *
diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 785620d30504..3a19b69b846b 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  zcrypt 2.1.0
  *
diff --git a/drivers/s390/crypto/zcrypt_msgtype6.h b/drivers/s390/crypto/zcrypt_msgtype6.h
index 7a0d5b57821f..52d140889377 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.h
+++ b/drivers/s390/crypto/zcrypt_msgtype6.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  zcrypt 2.1.0
  *
diff --git a/drivers/s390/crypto/zcrypt_pcixcc.c b/drivers/s390/crypto/zcrypt_pcixcc.c
index 600604782b65..9963018a6bbc 100644
--- a/drivers/s390/crypto/zcrypt_pcixcc.c
+++ b/drivers/s390/crypto/zcrypt_pcixcc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  zcrypt 2.1.0
  *
diff --git a/drivers/s390/crypto/zcrypt_pcixcc.h b/drivers/s390/crypto/zcrypt_pcixcc.h
index eacafc8962f2..a85778d5763c 100644
--- a/drivers/s390/crypto/zcrypt_pcixcc.h
+++ b/drivers/s390/crypto/zcrypt_pcixcc.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  zcrypt 2.1.0
  *
diff --git a/drivers/s390/crypto/zcrypt_queue.c b/drivers/s390/crypto/zcrypt_queue.c
index 4742be0eec24..5103727b4633 100644
--- a/drivers/s390/crypto/zcrypt_queue.c
+++ b/drivers/s390/crypto/zcrypt_queue.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  zcrypt 2.1.0
  *
-- 
2.15.0
