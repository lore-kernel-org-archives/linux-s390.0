Return-Path: <linux-kernel-owner+w=401wt.eu-S1758577AbYFYOhM@vger.kernel.org>
Message-Id: <20080625143612.881444682@de.ibm.com>
References: <20080625143459.100139455@de.ibm.com>
Date: Wed, 25 Jun 2008 16:35:05 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 06/21] Cleanup zcrypt printk messages.
Content-Disposition: inline; filename=805-printk-zcrypt.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Felix Beck <felix.beck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Felix Beck <felix.beck@de.ibm.com>

Signed-off-by: Felix Beck <felix.beck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/zcrypt_api.c    |   24 ++----------
 drivers/s390/crypto/zcrypt_api.h    |   28 --------------
 drivers/s390/crypto/zcrypt_cex2a.c  |    3 -
 drivers/s390/crypto/zcrypt_error.h  |    6 ---
 drivers/s390/crypto/zcrypt_pcica.c  |    3 -
 drivers/s390/crypto/zcrypt_pcicc.c  |   15 +------
 drivers/s390/crypto/zcrypt_pcixcc.c |   68 +++++-------------------------------
 7 files changed, 17 insertions(+), 130 deletions(-)

Index: quilt-2.6/drivers/s390/crypto/zcrypt_api.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_api.c
+++ quilt-2.6/drivers/s390/crypto/zcrypt_api.c
@@ -1068,10 +1068,8 @@ static int zcrypt_status_write(struct fi
 
 #define LBUFSIZE 1200UL
 	lbuf = kmalloc(LBUFSIZE, GFP_KERNEL);
-	if (!lbuf) {
-		PRINTK("kmalloc failed!\n");
+	if (!lbuf)
 		return 0;
-	}
 
 	local_count = min(LBUFSIZE - 1, count);
 	if (copy_from_user(lbuf, buffer, local_count) != 0) {
@@ -1081,23 +1079,15 @@ static int zcrypt_status_write(struct fi
 	lbuf[local_count] = '\0';
 
 	ptr = strstr(lbuf, "Online devices");
-	if (!ptr) {
-		PRINTK("Unable to parse data (missing \"Online devices\")\n");
+	if (!ptr)
 		goto out;
-	}
 	ptr = strstr(ptr, "\n");
-	if (!ptr) {
-		PRINTK("Unable to parse data (missing newline "
-		       "after \"Online devices\")\n");
+	if (!ptr)
 		goto out;
-	}
 	ptr++;
 
-	if (strstr(ptr, "Waiting work element counts") == NULL) {
-		PRINTK("Unable to parse data (missing "
-		       "\"Waiting work element counts\")\n");
+	if (strstr(ptr, "Waiting work element counts") == NULL)
 		goto out;
-	}
 
 	for (j = 0; j < 64 && *ptr; ptr++) {
 		/*
@@ -1197,16 +1187,12 @@ int __init zcrypt_api_init(void)
 
 	/* Register the request sprayer. */
 	rc = misc_register(&zcrypt_misc_device);
-	if (rc < 0) {
-		PRINTKW(KERN_ERR "misc_register (minor %d) failed with %d\n",
-			zcrypt_misc_device.minor, rc);
+	if (rc < 0)
 		goto out;
-	}
 
 	/* Set up the proc file system */
 	zcrypt_entry = create_proc_entry("driver/z90crypt", 0644, NULL);
 	if (!zcrypt_entry) {
-		PRINTK("Couldn't create z90crypt proc entry\n");
 		rc = -ENOMEM;
 		goto out_misc;
 	}
Index: quilt-2.6/drivers/s390/crypto/zcrypt_api.h
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_api.h
+++ quilt-2.6/drivers/s390/crypto/zcrypt_api.h
@@ -30,34 +30,6 @@
 #ifndef _ZCRYPT_API_H_
 #define _ZCRYPT_API_H_
 
-/**
- * Macro definitions
- *
- * PDEBUG debugs in the form "zcrypt: function_name -> message"
- *
- * PRINTK is like PDEBUG, except that it is always enabled
- * PRINTKN is like PRINTK, except that it does not include the function name
- * PRINTKW is like PRINTK, except that it uses KERN_WARNING
- * PRINTKC is like PRINTK, except that it uses KERN_CRIT
- */
-#define DEV_NAME	"zcrypt"
-
-#define PRINTK(fmt, args...) \
-	printk(KERN_DEBUG DEV_NAME ": %s -> " fmt, __func__ , ## args)
-#define PRINTKN(fmt, args...) \
-	printk(KERN_DEBUG DEV_NAME ": " fmt, ## args)
-#define PRINTKW(fmt, args...) \
-	printk(KERN_WARNING DEV_NAME ": %s -> " fmt, __func__ , ## args)
-#define PRINTKC(fmt, args...) \
-	printk(KERN_CRIT DEV_NAME ": %s -> " fmt, __func__ , ## args)
-
-#ifdef ZCRYPT_DEBUG
-#define PDEBUG(fmt, args...) \
-	printk(KERN_DEBUG DEV_NAME ": %s -> " fmt, __func__ , ## args)
-#else
-#define PDEBUG(fmt, args...) do {} while (0)
-#endif
-
 #include "ap_bus.h"
 #include <asm/zcrypt.h>
 
Index: quilt-2.6/drivers/s390/crypto/zcrypt_cex2a.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_cex2a.c
+++ quilt-2.6/drivers/s390/crypto/zcrypt_cex2a.c
@@ -242,9 +242,6 @@ static int convert_response(struct zcryp
 		return convert_type80(zdev, reply,
 				      outputdata, outputdatalength);
 	default: /* Unknown response type, this should NEVER EVER happen */
-		PRINTK("Unrecognized Message Header: %08x%08x\n",
-		       *(unsigned int *) reply->message,
-		       *(unsigned int *) (reply->message+4));
 		zdev->online = 0;
 		return -EAGAIN;	/* repeat the request on a different device. */
 	}
Index: quilt-2.6/drivers/s390/crypto/zcrypt_error.h
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_error.h
+++ quilt-2.6/drivers/s390/crypto/zcrypt_error.h
@@ -92,10 +92,6 @@ static inline int convert_error(struct z
 {
 	struct error_hdr *ehdr = reply->message;
 
-	PRINTK("Hardware error : Type %02x Message Header: %08x%08x\n",
-	       ehdr->type, *(unsigned int *) reply->message,
-	       *(unsigned int *) (reply->message + 4));
-
 	switch (ehdr->reply_code) {
 	case REP82_ERROR_OPERAND_INVALID:
 	case REP82_ERROR_OPERAND_SIZE:
@@ -123,8 +119,6 @@ static inline int convert_error(struct z
 		zdev->online = 0;
 		return -EAGAIN;
 	default:
-		PRINTKW("unknown type %02x reply code = %d\n",
-			ehdr->type, ehdr->reply_code);
 		zdev->online = 0;
 		return -EAGAIN;	/* repeat the request on a different device. */
 	}
Index: quilt-2.6/drivers/s390/crypto/zcrypt_pcica.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_pcica.c
+++ quilt-2.6/drivers/s390/crypto/zcrypt_pcica.c
@@ -226,9 +226,6 @@ static int convert_response(struct zcryp
 		return convert_type84(zdev, reply,
 				      outputdata, outputdatalength);
 	default: /* Unknown response type, this should NEVER EVER happen */
-		PRINTK("Unrecognized Message Header: %08x%08x\n",
-		       *(unsigned int *) reply->message,
-		       *(unsigned int *) (reply->message+4));
 		zdev->online = 0;
 		return -EAGAIN;	/* repeat the request on a different device. */
 	}
Index: quilt-2.6/drivers/s390/crypto/zcrypt_pcicc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_pcicc.c
+++ quilt-2.6/drivers/s390/crypto/zcrypt_pcicc.c
@@ -361,26 +361,18 @@ static int convert_type86(struct zcrypt_
 	service_rc = le16_to_cpu(msg->cprb.ccp_rtcode);
 	if (unlikely(service_rc != 0)) {
 		service_rs = le16_to_cpu(msg->cprb.ccp_rscode);
-		if (service_rc == 8 && service_rs == 66) {
-			PDEBUG("Bad block format on PCICC\n");
+		if (service_rc == 8 && service_rs == 66)
 			return -EINVAL;
-		}
-		if (service_rc == 8 && service_rs == 65) {
-			PDEBUG("Probably an even modulus on PCICC\n");
+		if (service_rc == 8 && service_rs == 65)
 			return -EINVAL;
-		}
 		if (service_rc == 8 && service_rs == 770) {
-			PDEBUG("Invalid key length on PCICC\n");
 			zdev->max_mod_size = PCICC_MAX_MOD_SIZE_OLD;
 			return -EAGAIN;
 		}
 		if (service_rc == 8 && service_rs == 783) {
-			PDEBUG("Extended bitlengths not enabled on PCICC\n");
 			zdev->max_mod_size = PCICC_MAX_MOD_SIZE_OLD;
 			return -EAGAIN;
 		}
-		PRINTK("Unknown service rc/rs (PCICC): %d/%d\n",
-		       service_rc, service_rs);
 		zdev->online = 0;
 		return -EAGAIN;	/* repeat the request on a different device. */
 	}
@@ -434,9 +426,6 @@ static int convert_response(struct zcryp
 					      outputdata, outputdatalength);
 		/* no break, incorrect cprb version is an unknown response */
 	default: /* Unknown response type, this should NEVER EVER happen */
-		PRINTK("Unrecognized Message Header: %08x%08x\n",
-		       *(unsigned int *) reply->message,
-		       *(unsigned int *) (reply->message+4));
 		zdev->online = 0;
 		return -EAGAIN;	/* repeat the request on a different device. */
 	}
Index: quilt-2.6/drivers/s390/crypto/zcrypt_pcixcc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_pcixcc.c
+++ quilt-2.6/drivers/s390/crypto/zcrypt_pcixcc.c
@@ -289,38 +289,19 @@ static int XCRB_msg_to_type6CPRB_msgX(st
 	ap_msg->length = sizeof(struct type6_hdr) +
 		CEIL4(xcRB->request_control_blk_length) +
 		xcRB->request_data_length;
-	if (ap_msg->length > PCIXCC_MAX_XCRB_MESSAGE_SIZE) {
-		PRINTK("Combined message is too large (%ld/%d/%d).\n",
-		    sizeof(struct type6_hdr),
-		    xcRB->request_control_blk_length,
-		    xcRB->request_data_length);
+	if (ap_msg->length > PCIXCC_MAX_XCRB_MESSAGE_SIZE)
 		return -EFAULT;
-	}
-	if (CEIL4(xcRB->reply_control_blk_length) >
-	    PCIXCC_MAX_XCRB_REPLY_SIZE) {
-		PDEBUG("Reply CPRB length is too large (%d).\n",
-		    xcRB->request_control_blk_length);
+	if (CEIL4(xcRB->reply_control_blk_length) > PCIXCC_MAX_XCRB_REPLY_SIZE)
 		return -EFAULT;
-	}
-	if (CEIL4(xcRB->reply_data_length) > PCIXCC_MAX_XCRB_DATA_SIZE) {
-		PDEBUG("Reply data block length is too large (%d).\n",
-		    xcRB->reply_data_length);
+	if (CEIL4(xcRB->reply_data_length) > PCIXCC_MAX_XCRB_DATA_SIZE)
 		return -EFAULT;
-	}
 	replylen = CEIL4(xcRB->reply_control_blk_length) +
 		CEIL4(xcRB->reply_data_length) +
 		sizeof(struct type86_fmt2_msg);
 	if (replylen > PCIXCC_MAX_XCRB_RESPONSE_SIZE) {
-		PDEBUG("Reply CPRB + data block > PCIXCC_MAX_XCRB_RESPONSE_SIZE"
-		       " (%d/%d/%d).\n",
-		       sizeof(struct type86_fmt2_msg),
-		       xcRB->reply_control_blk_length,
-		       xcRB->reply_data_length);
 		xcRB->reply_control_blk_length = PCIXCC_MAX_XCRB_RESPONSE_SIZE -
 			(sizeof(struct type86_fmt2_msg) +
 			    CEIL4(xcRB->reply_data_length));
-		PDEBUG("Capping Reply CPRB length at %d\n",
-		       xcRB->reply_control_blk_length);
 	}
 
 	/* prepare type6 header */
@@ -339,11 +320,8 @@ static int XCRB_msg_to_type6CPRB_msgX(st
 		    xcRB->request_control_blk_length))
 		return -EFAULT;
 	if (msg->cprbx.cprb_len + sizeof(msg->hdr.function_code) >
-	    xcRB->request_control_blk_length) {
-		PDEBUG("cprb_len too large (%d/%d)\n", msg->cprbx.cprb_len,
-		    xcRB->request_control_blk_length);
+	    xcRB->request_control_blk_length)
 		return -EFAULT;
-	}
 	function_code = ((unsigned char *)&msg->cprbx) + msg->cprbx.cprb_len;
 	memcpy(msg->hdr.function_code, function_code, sizeof(msg->hdr.function_code));
 
@@ -471,29 +449,18 @@ static int convert_type86_ica(struct zcr
 	service_rc = msg->cprbx.ccp_rtcode;
 	if (unlikely(service_rc != 0)) {
 		service_rs = msg->cprbx.ccp_rscode;
-		if (service_rc == 8 && service_rs == 66) {
-			PDEBUG("Bad block format on PCIXCC/CEX2C\n");
+		if (service_rc == 8 && service_rs == 66)
 			return -EINVAL;
-		}
-		if (service_rc == 8 && service_rs == 65) {
-			PDEBUG("Probably an even modulus on PCIXCC/CEX2C\n");
+		if (service_rc == 8 && service_rs == 65)
 			return -EINVAL;
-		}
-		if (service_rc == 8 && service_rs == 770) {
-			PDEBUG("Invalid key length on PCIXCC/CEX2C\n");
+		if (service_rc == 8 && service_rs == 770)
 			return -EINVAL;
-		}
 		if (service_rc == 8 && service_rs == 783) {
-			PDEBUG("Extended bitlengths not enabled on PCIXCC/CEX2C\n");
 			zdev->min_mod_size = PCIXCC_MIN_MOD_SIZE_OLD;
 			return -EAGAIN;
 		}
-		if (service_rc == 12 && service_rs == 769) {
-			PDEBUG("Invalid key on PCIXCC/CEX2C\n");
+		if (service_rc == 12 && service_rs == 769)
 			return -EINVAL;
-		}
-		PRINTK("Unknown service rc/rs (PCIXCC/CEX2C): %d/%d\n",
-		       service_rc, service_rs);
 		zdev->online = 0;
 		return -EAGAIN;	/* repeat the request on a different device. */
 	}
@@ -569,11 +536,8 @@ static int convert_type86_rng(struct zcr
 	} __attribute__((packed)) *msg = reply->message;
 	char *data = reply->message;
 
-	if (msg->cprbx.ccp_rtcode != 0 || msg->cprbx.ccp_rscode != 0) {
-		PDEBUG("RNG response error on PCIXCC/CEX2C rc=%hu/rs=%hu\n",
-		       rc, rs);
+	if (msg->cprbx.ccp_rtcode != 0 || msg->cprbx.ccp_rscode != 0)
 		return -EINVAL;
-	}
 	memcpy(buffer, data + msg->fmt2.offset2, msg->fmt2.count2);
 	return msg->fmt2.count2;
 }
@@ -598,9 +562,6 @@ static int convert_response_ica(struct z
 						  outputdata, outputdatalength);
 		/* no break, incorrect cprb version is an unknown response */
 	default: /* Unknown response type, this should NEVER EVER happen */
-		PRINTK("Unrecognized Message Header: %08x%08x\n",
-		       *(unsigned int *) reply->message,
-		       *(unsigned int *) (reply->message+4));
 		zdev->online = 0;
 		return -EAGAIN;	/* repeat the request on a different device. */
 	}
@@ -627,9 +588,6 @@ static int convert_response_xcrb(struct 
 			return convert_type86_xcrb(zdev, reply, xcRB);
 		/* no break, incorrect cprb version is an unknown response */
 	default: /* Unknown response type, this should NEVER EVER happen */
-		PRINTK("Unrecognized Message Header: %08x%08x\n",
-		       *(unsigned int *) reply->message,
-		       *(unsigned int *) (reply->message+4));
 		xcRB->status = 0x0008044DL; /* HDD_InvalidParm */
 		zdev->online = 0;
 		return -EAGAIN;	/* repeat the request on a different device. */
@@ -653,9 +611,6 @@ static int convert_response_rng(struct z
 			return convert_type86_rng(zdev, reply, data);
 		/* no break, incorrect cprb version is an unknown response */
 	default: /* Unknown response type, this should NEVER EVER happen */
-		PRINTK("Unrecognized Message Header: %08x%08x\n",
-		       *(unsigned int *) reply->message,
-		       *(unsigned int *) (reply->message+4));
 		zdev->online = 0;
 		return -EAGAIN;	/* repeat the request on a different device. */
 	}
@@ -700,10 +655,7 @@ static void zcrypt_pcixcc_receive(struct
 			memcpy(msg->message, reply->message, length);
 			break;
 		default:
-			PRINTK("Invalid internal response type: %i\n",
-			    resp_type->type);
-			memcpy(msg->message, &error_reply,
-			    sizeof error_reply);
+			memcpy(msg->message, &error_reply, sizeof error_reply);
 		}
 	} else
 		memcpy(msg->message, reply->message, sizeof error_reply);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
