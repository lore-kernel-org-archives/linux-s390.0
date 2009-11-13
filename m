Return-Path: <linux-kernel-owner+w=401wt.eu-S932155AbZKMPQd@vger.kernel.org>
Message-Id: <20091113150911.952456594@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:39 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 15/52] [PATCH] zcrypt: initialize ap_messages for cex3 exploitation
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=114-cex3-init-msg.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Felix Beck <felix.beck@de.ibm.com>, Ralph Wuerthner <ralph.wuerthner@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Felix Beck <felix.beck@de.ibm.com>

AP messages need to be initialized, before they will be used. Values
will be zeroized. This will be needed later when introducing support
for the special commands.

Signed-off-by: Felix Beck <felix.beck@de.ibm.com>
Signed-off-by: Ralph Wuerthner <ralph.wuerthner@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/ap_bus.h        |   11 +++++++++++
 drivers/s390/crypto/zcrypt_cex2a.c  |    2 ++
 drivers/s390/crypto/zcrypt_pcica.c  |    2 ++
 drivers/s390/crypto/zcrypt_pcicc.c  |    2 ++
 drivers/s390/crypto/zcrypt_pcixcc.c |    5 +++++
 5 files changed, 22 insertions(+)

Index: quilt-2.6/drivers/s390/crypto/ap_bus.h
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/ap_bus.h	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/crypto/ap_bus.h	2009-11-13 16:08:15.000000000 +0100
@@ -167,6 +167,17 @@
 	.dev_type=(dt),					\
 	.match_flags=AP_DEVICE_ID_MATCH_DEVICE_TYPE,
 
+/**
+ * ap_init_message() - Initialize ap_message.
+ * Initialize a message before using. Otherwise this might result in
+ * unexpected behaviour.
+ */
+extern inline void ap_init_message(struct ap_message *ap_msg)
+{
+	ap_msg->psmid = 0;
+	ap_msg->length = 0;
+}
+
 /*
  * Note: don't use ap_send/ap_recv after using ap_queue_message
  * for the first time. Otherwise the ap message queue will get
Index: quilt-2.6/drivers/s390/crypto/zcrypt_cex2a.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_cex2a.c	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/crypto/zcrypt_cex2a.c	2009-11-13 16:08:15.000000000 +0100
@@ -298,6 +298,7 @@
 	struct completion work;
 	int rc;
 
+	ap_init_message(&ap_msg);
 	ap_msg.message = kmalloc(CEX2A_MAX_MESSAGE_SIZE, GFP_KERNEL);
 	if (!ap_msg.message)
 		return -ENOMEM;
@@ -335,6 +336,7 @@
 	struct completion work;
 	int rc;
 
+	ap_init_message(&ap_msg);
 	ap_msg.message = kmalloc(CEX2A_MAX_MESSAGE_SIZE, GFP_KERNEL);
 	if (!ap_msg.message)
 		return -ENOMEM;
Index: quilt-2.6/drivers/s390/crypto/zcrypt_pcica.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_pcica.c	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/crypto/zcrypt_pcica.c	2009-11-13 16:08:15.000000000 +0100
@@ -281,6 +281,7 @@
 	struct completion work;
 	int rc;
 
+	ap_init_message(&ap_msg);
 	ap_msg.message = kmalloc(PCICA_MAX_MESSAGE_SIZE, GFP_KERNEL);
 	if (!ap_msg.message)
 		return -ENOMEM;
@@ -318,6 +319,7 @@
 	struct completion work;
 	int rc;
 
+	ap_init_message(&ap_msg);
 	ap_msg.message = kmalloc(PCICA_MAX_MESSAGE_SIZE, GFP_KERNEL);
 	if (!ap_msg.message)
 		return -ENOMEM;
Index: quilt-2.6/drivers/s390/crypto/zcrypt_pcicc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_pcicc.c	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/crypto/zcrypt_pcicc.c	2009-11-13 16:08:15.000000000 +0100
@@ -483,6 +483,7 @@
 	struct completion work;
 	int rc;
 
+	ap_init_message(&ap_msg);
 	ap_msg.message = (void *) get_zeroed_page(GFP_KERNEL);
 	if (!ap_msg.message)
 		return -ENOMEM;
@@ -521,6 +522,7 @@
 	struct completion work;
 	int rc;
 
+	ap_init_message(&ap_msg);
 	ap_msg.message = (void *) get_zeroed_page(GFP_KERNEL);
 	if (!ap_msg.message)
 		return -ENOMEM;
Index: quilt-2.6/drivers/s390/crypto/zcrypt_pcixcc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_pcixcc.c	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/crypto/zcrypt_pcixcc.c	2009-11-13 16:08:15.000000000 +0100
@@ -688,6 +688,7 @@
 	};
 	int rc;
 
+	ap_init_message(&ap_msg);
 	ap_msg.message = (void *) get_zeroed_page(GFP_KERNEL);
 	if (!ap_msg.message)
 		return -ENOMEM;
@@ -727,6 +728,7 @@
 	};
 	int rc;
 
+	ap_init_message(&ap_msg);
 	ap_msg.message = (void *) get_zeroed_page(GFP_KERNEL);
 	if (!ap_msg.message)
 		return -ENOMEM;
@@ -766,6 +768,7 @@
 	};
 	int rc;
 
+	ap_init_message(&ap_msg);
 	ap_msg.message = kmalloc(PCIXCC_MAX_XCRB_MESSAGE_SIZE, GFP_KERNEL);
 	if (!ap_msg.message)
 		return -ENOMEM;
@@ -805,6 +808,7 @@
 	};
 	int rc;
 
+	ap_init_message(&ap_msg);
 	ap_msg.message = kmalloc(PCIXCC_MAX_XCRB_MESSAGE_SIZE, GFP_KERNEL);
 	if (!ap_msg.message)
 		return -ENOMEM;
@@ -972,6 +976,7 @@
 	} __attribute__((packed)) *reply;
 	int rc, i;
 
+	ap_init_message(&ap_msg);
 	ap_msg.message = (void *) get_zeroed_page(GFP_KERNEL);
 	if (!ap_msg.message)
 		return -ENOMEM;
