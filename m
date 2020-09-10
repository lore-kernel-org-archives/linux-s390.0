Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42186 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730181AbgIJK3K (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Sep 2020 06:29:10 -0400
From: Harald Freudenberger <freude@linux.ibm.com>
Subject: [PATCH] s390/zcrypt: remove set_fs() invocation in zcrypt device driver
Date: Thu, 10 Sep 2020 12:28:38 +0200
Message-Id: <20200910102838.28887-1-freude@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux390-list@tuxmaker.boeblingen.de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, hch@lst.de, borntraeger@de.ibm.com, Harald Freudenberger <freude@linux.ibm.com>

This patch reworks the zcrypt device driver so that the set_fs()
invocation is not needed any more. Instead there is a new flag bool
userspace passed through all the functions which tells if the pointer
arguments are userspace or kernelspace. Together with the two new
inline functions z_copy_from_user() and z_copy_to_user() which either
invoke copy_from_user (userspace is true) or memcpy (userspace is
false) the zcrypt dd and the AP bus now has no requirement for
the set_fs() functionality any more.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_api.c      | 30 +++++------
 drivers/s390/crypto/zcrypt_api.h      | 22 +++++++-
 drivers/s390/crypto/zcrypt_ccamisc.c  | 32 +++--------
 drivers/s390/crypto/zcrypt_ep11misc.c | 28 ++--------
 drivers/s390/crypto/zcrypt_msgtype6.c | 78 +++++++++++++--------------
 drivers/s390/crypto/zcrypt_msgtype6.h |  4 +-
 6 files changed, 88 insertions(+), 106 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 4dbbfd88262c..a711728c3857 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -797,7 +797,7 @@ static long zcrypt_rsa_crt(struct ap_perms *perms,
 	return rc;
 }
 
-static long _zcrypt_send_cprb(struct ap_perms *perms,
+static long _zcrypt_send_cprb(bool userspace, struct ap_perms *perms,
 			      struct ica_xcRB *xcRB)
 {
 	struct zcrypt_card *zc, *pref_zc;
@@ -813,7 +813,7 @@ static long _zcrypt_send_cprb(struct ap_perms *perms,
 
 	xcRB->status = 0;
 	ap_init_message(&ap_msg);
-	rc = get_cprb_fc(xcRB, &ap_msg, &func_code, &domain);
+	rc = get_cprb_fc(userspace, xcRB, &ap_msg, &func_code, &domain);
 	if (rc)
 		goto out;
 
@@ -878,7 +878,7 @@ static long _zcrypt_send_cprb(struct ap_perms *perms,
 	if (*domain == AUTOSEL_DOM)
 		*domain = AP_QID_QUEUE(qid);
 
-	rc = pref_zq->ops->send_cprb(pref_zq, xcRB, &ap_msg);
+	rc = pref_zq->ops->send_cprb(userspace, pref_zq, xcRB, &ap_msg);
 
 	spin_lock(&zcrypt_list_lock);
 	zcrypt_drop_queue(pref_zc, pref_zq, mod, weight);
@@ -893,7 +893,7 @@ static long _zcrypt_send_cprb(struct ap_perms *perms,
 
 long zcrypt_send_cprb(struct ica_xcRB *xcRB)
 {
-	return _zcrypt_send_cprb(&ap_perms, xcRB);
+	return _zcrypt_send_cprb(false, &ap_perms, xcRB);
 }
 EXPORT_SYMBOL(zcrypt_send_cprb);
 
@@ -924,7 +924,7 @@ static bool is_desired_ep11_queue(unsigned int dev_qid,
 	return false;
 }
 
-static long _zcrypt_send_ep11_cprb(struct ap_perms *perms,
+static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 				   struct ep11_urb *xcrb)
 {
 	struct zcrypt_card *zc, *pref_zc;
@@ -956,7 +956,7 @@ static long _zcrypt_send_ep11_cprb(struct ap_perms *perms,
 		}
 
 		uptr = (struct ep11_target_dev __force __user *) xcrb->targets;
-		if (copy_from_user(targets, uptr,
+		if (z_copy_from_user(userspace, targets, uptr,
 				   target_num * sizeof(*targets))) {
 			func_code = 0;
 			rc = -EFAULT;
@@ -964,7 +964,7 @@ static long _zcrypt_send_ep11_cprb(struct ap_perms *perms,
 		}
 	}
 
-	rc = get_ep11cprb_fc(xcrb, &ap_msg, &func_code);
+	rc = get_ep11cprb_fc(userspace, xcrb, &ap_msg, &func_code);
 	if (rc)
 		goto out_free;
 
@@ -1015,7 +1015,7 @@ static long _zcrypt_send_ep11_cprb(struct ap_perms *perms,
 	}
 
 	qid = pref_zq->queue->qid;
-	rc = pref_zq->ops->send_ep11_cprb(pref_zq, xcrb, &ap_msg);
+	rc = pref_zq->ops->send_ep11_cprb(userspace, pref_zq, xcrb, &ap_msg);
 
 	spin_lock(&zcrypt_list_lock);
 	zcrypt_drop_queue(pref_zc, pref_zq, mod, weight);
@@ -1032,7 +1032,7 @@ static long _zcrypt_send_ep11_cprb(struct ap_perms *perms,
 
 long zcrypt_send_ep11_cprb(struct ep11_urb *xcrb)
 {
-	return _zcrypt_send_ep11_cprb(&ap_perms, xcrb);
+	return _zcrypt_send_ep11_cprb(false, &ap_perms, xcrb);
 }
 EXPORT_SYMBOL(zcrypt_send_ep11_cprb);
 
@@ -1353,12 +1353,12 @@ static int zsecsendcprb_ioctl(struct ap_perms *perms, unsigned long arg)
 	if (copy_from_user(&xcRB, uxcRB, sizeof(xcRB)))
 		return -EFAULT;
 	do {
-		rc = _zcrypt_send_cprb(perms, &xcRB);
+		rc = _zcrypt_send_cprb(true, perms, &xcRB);
 	} while (rc == -EAGAIN);
 	/* on failure: retry once again after a requested rescan */
 	if ((rc == -ENODEV) && (zcrypt_process_rescan()))
 		do {
-			rc = _zcrypt_send_cprb(perms, &xcRB);
+			rc = _zcrypt_send_cprb(true, perms, &xcRB);
 		} while (rc == -EAGAIN);
 	if (rc)
 		ZCRYPT_DBF(DBF_DEBUG, "ioctl ZSENDCPRB rc=%d status=0x%x\n",
@@ -1377,12 +1377,12 @@ static int zsendep11cprb_ioctl(struct ap_perms *perms, unsigned long arg)
 	if (copy_from_user(&xcrb, uxcrb, sizeof(xcrb)))
 		return -EFAULT;
 	do {
-		rc = _zcrypt_send_ep11_cprb(perms, &xcrb);
+		rc = _zcrypt_send_ep11_cprb(true, perms, &xcrb);
 	} while (rc == -EAGAIN);
 	/* on failure: retry once again after a requested rescan */
 	if ((rc == -ENODEV) && (zcrypt_process_rescan()))
 		do {
-			rc = _zcrypt_send_ep11_cprb(perms, &xcrb);
+			rc = _zcrypt_send_ep11_cprb(true, perms, &xcrb);
 		} while (rc == -EAGAIN);
 	if (rc)
 		ZCRYPT_DBF(DBF_DEBUG, "ioctl ZSENDEP11CPRB rc=%d\n", rc);
@@ -1655,12 +1655,12 @@ static long trans_xcRB32(struct ap_perms *perms, struct file *filp,
 	xcRB64.priority_window = xcRB32.priority_window;
 	xcRB64.status = xcRB32.status;
 	do {
-		rc = _zcrypt_send_cprb(perms, &xcRB64);
+		rc = _zcrypt_send_cprb(true, perms, &xcRB64);
 	} while (rc == -EAGAIN);
 	/* on failure: retry once again after a requested rescan */
 	if ((rc == -ENODEV) && (zcrypt_process_rescan()))
 		do {
-			rc = _zcrypt_send_cprb(perms, &xcRB64);
+			rc = _zcrypt_send_cprb(true, perms, &xcRB64);
 		} while (rc == -EAGAIN);
 	xcRB32.reply_control_blk_length = xcRB64.reply_control_blk_length;
 	xcRB32.reply_data_length = xcRB64.reply_data_length;
diff --git a/drivers/s390/crypto/zcrypt_api.h b/drivers/s390/crypto/zcrypt_api.h
index 599e68bf53f7..b9085a3e6958 100644
--- a/drivers/s390/crypto/zcrypt_api.h
+++ b/drivers/s390/crypto/zcrypt_api.h
@@ -59,9 +59,9 @@ struct zcrypt_ops {
 	long (*rsa_modexpo)(struct zcrypt_queue *, struct ica_rsa_modexpo *);
 	long (*rsa_modexpo_crt)(struct zcrypt_queue *,
 				struct ica_rsa_modexpo_crt *);
-	long (*send_cprb)(struct zcrypt_queue *, struct ica_xcRB *,
+	long (*send_cprb)(bool userspace, struct zcrypt_queue *, struct ica_xcRB *,
 			  struct ap_message *);
-	long (*send_ep11_cprb)(struct zcrypt_queue *, struct ep11_urb *,
+	long (*send_ep11_cprb)(bool userspace, struct zcrypt_queue *, struct ep11_urb *,
 			       struct ap_message *);
 	long (*rng)(struct zcrypt_queue *, char *, struct ap_message *);
 	struct list_head list;		/* zcrypt ops list. */
@@ -145,4 +145,22 @@ void zcrypt_device_status_mask_ext(struct zcrypt_device_status_ext *devstatus);
 int zcrypt_device_status_ext(int card, int queue,
 			     struct zcrypt_device_status_ext *devstatus);
 
+static inline unsigned long z_copy_from_user(bool userspace,
+					     void *to, const void __user *from, unsigned long n)
+{
+	if (likely(userspace))
+		return copy_from_user(to, from, n);
+	memcpy(to, (void __force *) from, n);
+	return 0;
+}
+
+static inline unsigned long z_copy_to_user(bool userspace,
+					   void __user *to, const void *from, unsigned long n)
+{
+	if (likely(userspace))
+		return copy_to_user(to, from, n);
+	memcpy((void __force *) to, from, n);
+	return 0;
+}
+
 #endif /* _ZCRYPT_API_H_ */
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 3f5b61351cde..7d39b43ed3c0 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -248,24 +248,6 @@ static inline void prep_xcrb(struct ica_xcRB *pxcrb,
 	pxcrb->reply_control_blk_addr = (void __user *) prepcblk;
 }
 
-/*
- * Helper function which calls zcrypt_send_cprb with
- * memory management segment adjusted to kernel space
- * so that the copy_from_user called within this
- * function do in fact copy from kernel space.
- */
-static inline int _zcrypt_send_cprb(struct ica_xcRB *xcrb)
-{
-	int rc;
-	mm_segment_t old_fs = get_fs();
-
-	set_fs(KERNEL_DS);
-	rc = zcrypt_send_cprb(xcrb);
-	set_fs(old_fs);
-
-	return rc;
-}
-
 /*
  * Generate (random) CCA AES DATA secure key.
  */
@@ -359,7 +341,7 @@ int cca_genseckey(u16 cardnr, u16 domain,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = _zcrypt_send_cprb(&xcrb);
+	rc = zcrypt_send_cprb(&xcrb);
 	if (rc) {
 		DEBUG_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, errno %d\n",
 			  __func__, (int) cardnr, (int) domain, rc);
@@ -497,7 +479,7 @@ int cca_clr2seckey(u16 cardnr, u16 domain, u32 keybitsize,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = _zcrypt_send_cprb(&xcrb);
+	rc = zcrypt_send_cprb(&xcrb);
 	if (rc) {
 		DEBUG_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			  __func__, (int) cardnr, (int) domain, rc);
@@ -624,7 +606,7 @@ int cca_sec2protkey(u16 cardnr, u16 domain,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = _zcrypt_send_cprb(&xcrb);
+	rc = zcrypt_send_cprb(&xcrb);
 	if (rc) {
 		DEBUG_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			  __func__, (int) cardnr, (int) domain, rc);
@@ -850,7 +832,7 @@ int cca_gencipherkey(u16 cardnr, u16 domain, u32 keybitsize, u32 keygenflags,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = _zcrypt_send_cprb(&xcrb);
+	rc = zcrypt_send_cprb(&xcrb);
 	if (rc) {
 		DEBUG_ERR(
 			"%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
@@ -1018,7 +1000,7 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = _zcrypt_send_cprb(&xcrb);
+	rc = zcrypt_send_cprb(&xcrb);
 	if (rc) {
 		DEBUG_ERR(
 			"%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
@@ -1235,7 +1217,7 @@ int cca_cipher2protkey(u16 cardnr, u16 domain, const u8 *ckey,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = _zcrypt_send_cprb(&xcrb);
+	rc = zcrypt_send_cprb(&xcrb);
 	if (rc) {
 		DEBUG_ERR(
 			"%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
@@ -1366,7 +1348,7 @@ int cca_query_crypto_facility(u16 cardnr, u16 domain,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = _zcrypt_send_cprb(&xcrb);
+	rc = zcrypt_send_cprb(&xcrb);
 	if (rc) {
 		DEBUG_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			  __func__, (int) cardnr, (int) domain, rc);
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index 3c3d403abe92..60b6bec21c32 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -169,24 +169,6 @@ int ep11_check_aeskeyblob(debug_info_t *dbg, int dbflvl,
 }
 EXPORT_SYMBOL(ep11_check_aeskeyblob);
 
-/*
- * Helper function which calls zcrypt_send_ep11_cprb with
- * memory management segment adjusted to kernel space
- * so that the copy_from_user called within this
- * function do in fact copy from kernel space.
- */
-static inline int _zcrypt_send_ep11_cprb(struct ep11_urb *urb)
-{
-	int rc;
-	mm_segment_t old_fs = get_fs();
-
-	set_fs(KERNEL_DS);
-	rc = zcrypt_send_ep11_cprb(urb);
-	set_fs(old_fs);
-
-	return rc;
-}
-
 /*
  * Allocate and prepare ep11 cprb plus additional payload.
  */
@@ -399,7 +381,7 @@ static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
 		 req, sizeof(*req) + sizeof(*req_pl),
 		 rep, sizeof(*rep) + sizeof(*rep_pl) + buflen);
 
-	rc = _zcrypt_send_ep11_cprb(urb);
+	rc = zcrypt_send_ep11_cprb(urb);
 	if (rc) {
 		DEBUG_ERR(
 			"%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
@@ -637,7 +619,7 @@ int ep11_genaeskey(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 		 req, sizeof(*req) + sizeof(*req_pl),
 		 rep, sizeof(*rep) + sizeof(*rep_pl));
 
-	rc = _zcrypt_send_ep11_cprb(urb);
+	rc = zcrypt_send_ep11_cprb(urb);
 	if (rc) {
 		DEBUG_ERR(
 			"%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
@@ -757,7 +739,7 @@ static int ep11_cryptsingle(u16 card, u16 domain,
 		 req, sizeof(*req) + req_pl_size,
 		 rep, sizeof(*rep) + rep_pl_size);
 
-	rc = _zcrypt_send_ep11_cprb(urb);
+	rc = zcrypt_send_ep11_cprb(urb);
 	if (rc) {
 		DEBUG_ERR(
 			"%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
@@ -905,7 +887,7 @@ static int ep11_unwrapkey(u16 card, u16 domain,
 		 req, sizeof(*req) + req_pl_size,
 		 rep, sizeof(*rep) + sizeof(*rep_pl));
 
-	rc = _zcrypt_send_ep11_cprb(urb);
+	rc = zcrypt_send_ep11_cprb(urb);
 	if (rc) {
 		DEBUG_ERR(
 			"%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
@@ -1033,7 +1015,7 @@ static int ep11_wrapkey(u16 card, u16 domain,
 		 req, sizeof(*req) + req_pl_size,
 		 rep, sizeof(*rep) + sizeof(*rep_pl));
 
-	rc = _zcrypt_send_ep11_cprb(urb);
+	rc = zcrypt_send_ep11_cprb(urb);
 	if (rc) {
 		DEBUG_ERR(
 			"%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index d77991c74c25..3db901883a5c 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -388,7 +388,7 @@ struct type86_fmt2_msg {
 	struct type86_fmt2_ext fmt2;
 } __packed;
 
-static int XCRB_msg_to_type6CPRB_msgX(struct ap_message *ap_msg,
+static int XCRB_msg_to_type6CPRB_msgX(bool userspace, struct ap_message *ap_msg,
 				      struct ica_xcRB *xcRB,
 				      unsigned int *fcode,
 				      unsigned short **dom)
@@ -465,8 +465,8 @@ static int XCRB_msg_to_type6CPRB_msgX(struct ap_message *ap_msg,
 	msg->hdr.FromCardLen2 = xcRB->reply_data_length;
 
 	/* prepare CPRB */
-	if (copy_from_user(&(msg->cprbx), xcRB->request_control_blk_addr,
-		    xcRB->request_control_blk_length))
+	if (z_copy_from_user(userspace, &(msg->cprbx), xcRB->request_control_blk_addr,
+			     xcRB->request_control_blk_length))
 		return -EFAULT;
 	if (msg->cprbx.cprb_len + sizeof(msg->hdr.function_code) >
 	    xcRB->request_control_blk_length)
@@ -484,16 +484,16 @@ static int XCRB_msg_to_type6CPRB_msgX(struct ap_message *ap_msg,
 
 	/* copy data block */
 	if (xcRB->request_data_length &&
-	    copy_from_user(req_data, xcRB->request_data_address,
-		xcRB->request_data_length))
+	    z_copy_from_user(userspace, req_data, xcRB->request_data_address,
+			     xcRB->request_data_length))
 		return -EFAULT;
 
 	return 0;
 }
 
-static int xcrb_msg_to_type6_ep11cprb_msgx(struct ap_message *ap_msg,
-				       struct ep11_urb *xcRB,
-				       unsigned int *fcode)
+static int xcrb_msg_to_type6_ep11cprb_msgx(bool userspace, struct ap_message *ap_msg,
+					   struct ep11_urb *xcRB,
+					   unsigned int *fcode)
 {
 	unsigned int lfmt;
 	static struct type6_hdr static_type6_ep11_hdr = {
@@ -543,8 +543,8 @@ static int xcrb_msg_to_type6_ep11cprb_msgx(struct ap_message *ap_msg,
 	msg->hdr.FromCardLen1 = xcRB->resp_len;
 
 	/* Import CPRB data from the ioctl input parameter */
-	if (copy_from_user(&(msg->cprbx.cprb_len),
-			   (char __force __user *)xcRB->req, xcRB->req_len)) {
+	if (z_copy_from_user(userspace, &(msg->cprbx.cprb_len),
+			     (char __force __user *)xcRB->req, xcRB->req_len)) {
 		return -EFAULT;
 	}
 
@@ -707,7 +707,7 @@ static int convert_type86_ica(struct zcrypt_queue *zq,
  *
  * Returns 0 on success or -EINVAL, -EFAULT, -EAGAIN in case of an error.
  */
-static int convert_type86_xcrb(struct zcrypt_queue *zq,
+static int convert_type86_xcrb(bool userspace, struct zcrypt_queue *zq,
 			       struct ap_message *reply,
 			       struct ica_xcRB *xcRB)
 {
@@ -715,15 +715,15 @@ static int convert_type86_xcrb(struct zcrypt_queue *zq,
 	char *data = reply->msg;
 
 	/* Copy CPRB to user */
-	if (copy_to_user(xcRB->reply_control_blk_addr,
-		data + msg->fmt2.offset1, msg->fmt2.count1))
+	if (z_copy_to_user(userspace, xcRB->reply_control_blk_addr,
+			   data + msg->fmt2.offset1, msg->fmt2.count1))
 		return -EFAULT;
 	xcRB->reply_control_blk_length = msg->fmt2.count1;
 
 	/* Copy data buffer to user */
 	if (msg->fmt2.count2)
-		if (copy_to_user(xcRB->reply_data_addr,
-			data + msg->fmt2.offset2, msg->fmt2.count2))
+		if (z_copy_to_user(userspace, xcRB->reply_data_addr,
+				   data + msg->fmt2.offset2, msg->fmt2.count2))
 			return -EFAULT;
 	xcRB->reply_data_length = msg->fmt2.count2;
 	return 0;
@@ -738,7 +738,7 @@ static int convert_type86_xcrb(struct zcrypt_queue *zq,
  *
  * Returns 0 on success or -EINVAL, -EFAULT, -EAGAIN in case of an error.
  */
-static int convert_type86_ep11_xcrb(struct zcrypt_queue *zq,
+static int convert_type86_ep11_xcrb(bool userspace, struct zcrypt_queue *zq,
 				    struct ap_message *reply,
 				    struct ep11_urb *xcRB)
 {
@@ -749,8 +749,8 @@ static int convert_type86_ep11_xcrb(struct zcrypt_queue *zq,
 		return -EINVAL;
 
 	/* Copy response CPRB to user */
-	if (copy_to_user((char __force __user *)xcRB->resp,
-			 data + msg->fmt2.offset1, msg->fmt2.count1))
+	if (z_copy_to_user(userspace, (char __force __user *)xcRB->resp,
+			   data + msg->fmt2.offset1, msg->fmt2.count1))
 		return -EFAULT;
 	xcRB->resp_len = msg->fmt2.count1;
 	return 0;
@@ -814,9 +814,9 @@ static int convert_response_ica(struct zcrypt_queue *zq,
 	}
 }
 
-static int convert_response_xcrb(struct zcrypt_queue *zq,
-			    struct ap_message *reply,
-			    struct ica_xcRB *xcRB)
+static int convert_response_xcrb(bool userspace, struct zcrypt_queue *zq,
+				 struct ap_message *reply,
+				 struct ica_xcRB *xcRB)
 {
 	struct type86x_reply *msg = reply->msg;
 
@@ -831,7 +831,7 @@ static int convert_response_xcrb(struct zcrypt_queue *zq,
 			return convert_error(zq, reply);
 		}
 		if (msg->cprbx.cprb_ver_id == 0x02)
-			return convert_type86_xcrb(zq, reply, xcRB);
+			return convert_type86_xcrb(userspace, zq, reply, xcRB);
 		fallthrough;	/* wrong cprb version is an unknown response */
 	default: /* Unknown response type, this should NEVER EVER happen */
 		xcRB->status = 0x0008044DL; /* HDD_InvalidParm */
@@ -848,8 +848,8 @@ static int convert_response_xcrb(struct zcrypt_queue *zq,
 	}
 }
 
-static int convert_response_ep11_xcrb(struct zcrypt_queue *zq,
-	struct ap_message *reply, struct ep11_urb *xcRB)
+static int convert_response_ep11_xcrb(bool userspace, struct zcrypt_queue *zq,
+				      struct ap_message *reply, struct ep11_urb *xcRB)
 {
 	struct type86_ep11_reply *msg = reply->msg;
 
@@ -861,7 +861,7 @@ static int convert_response_ep11_xcrb(struct zcrypt_queue *zq,
 		if (msg->hdr.reply_code)
 			return convert_error(zq, reply);
 		if (msg->cprbx.cprb_ver_id == 0x04)
-			return convert_type86_ep11_xcrb(zq, reply, xcRB);
+			return convert_type86_ep11_xcrb(userspace, zq, reply, xcRB);
 		fallthrough;	/* wrong cprb version is an unknown resp */
 	default: /* Unknown response type, this should NEVER EVER happen */
 		zq->online = 0;
@@ -1095,9 +1095,9 @@ static long zcrypt_msgtype6_modexpo_crt(struct zcrypt_queue *zq,
  * by the caller with ap_init_message(). Also the caller has to
  * make sure ap_release_message() is always called even on failure.
  */
-unsigned int get_cprb_fc(struct ica_xcRB *xcRB,
-				struct ap_message *ap_msg,
-				unsigned int *func_code, unsigned short **dom)
+unsigned int get_cprb_fc(bool userspace, struct ica_xcRB *xcRB,
+			 struct ap_message *ap_msg,
+			 unsigned int *func_code, unsigned short **dom)
 {
 	struct response_type resp_type = {
 		.type = CEXXC_RESPONSE_TYPE_XCRB,
@@ -1112,7 +1112,7 @@ unsigned int get_cprb_fc(struct ica_xcRB *xcRB,
 	ap_msg->private = kmemdup(&resp_type, sizeof(resp_type), GFP_KERNEL);
 	if (!ap_msg->private)
 		return -ENOMEM;
-	return XCRB_msg_to_type6CPRB_msgX(ap_msg, xcRB, func_code, dom);
+	return XCRB_msg_to_type6CPRB_msgX(userspace, ap_msg, xcRB, func_code, dom);
 }
 
 /**
@@ -1122,9 +1122,9 @@ unsigned int get_cprb_fc(struct ica_xcRB *xcRB,
  *	CEXxC device to the request distributor
  * @xcRB: pointer to the send_cprb request buffer
  */
-static long zcrypt_msgtype6_send_cprb(struct zcrypt_queue *zq,
-				    struct ica_xcRB *xcRB,
-				    struct ap_message *ap_msg)
+static long zcrypt_msgtype6_send_cprb(bool userspace, struct zcrypt_queue *zq,
+				      struct ica_xcRB *xcRB,
+				      struct ap_message *ap_msg)
 {
 	int rc;
 	struct response_type *rtype = (struct response_type *)(ap_msg->private);
@@ -1135,7 +1135,7 @@ static long zcrypt_msgtype6_send_cprb(struct zcrypt_queue *zq,
 	if (rc == 0) {
 		rc = ap_msg->rc;
 		if (rc == 0)
-			rc = convert_response_xcrb(zq, ap_msg, xcRB);
+			rc = convert_response_xcrb(userspace, zq, ap_msg, xcRB);
 	} else
 		/* Signal pending. */
 		ap_cancel_message(zq->queue, ap_msg);
@@ -1150,9 +1150,9 @@ static long zcrypt_msgtype6_send_cprb(struct zcrypt_queue *zq,
  * by the caller with ap_init_message(). Also the caller has to
  * make sure ap_release_message() is always called even on failure.
  */
-unsigned int get_ep11cprb_fc(struct ep11_urb *xcrb,
-				    struct ap_message *ap_msg,
-				    unsigned int *func_code)
+unsigned int get_ep11cprb_fc(bool userspace, struct ep11_urb *xcrb,
+			     struct ap_message *ap_msg,
+			     unsigned int *func_code)
 {
 	struct response_type resp_type = {
 		.type = CEXXC_RESPONSE_TYPE_EP11,
@@ -1167,7 +1167,7 @@ unsigned int get_ep11cprb_fc(struct ep11_urb *xcrb,
 	ap_msg->private = kmemdup(&resp_type, sizeof(resp_type), GFP_KERNEL);
 	if (!ap_msg->private)
 		return -ENOMEM;
-	return xcrb_msg_to_type6_ep11cprb_msgx(ap_msg, xcrb, func_code);
+	return xcrb_msg_to_type6_ep11cprb_msgx(userspace, ap_msg, xcrb, func_code);
 }
 
 /**
@@ -1177,7 +1177,7 @@ unsigned int get_ep11cprb_fc(struct ep11_urb *xcrb,
  *	  CEX4P device to the request distributor
  * @xcRB: pointer to the ep11 user request block
  */
-static long zcrypt_msgtype6_send_ep11_cprb(struct zcrypt_queue *zq,
+static long zcrypt_msgtype6_send_ep11_cprb(bool userspace, struct zcrypt_queue *zq,
 					   struct ep11_urb *xcrb,
 					   struct ap_message *ap_msg)
 {
@@ -1237,7 +1237,7 @@ static long zcrypt_msgtype6_send_ep11_cprb(struct zcrypt_queue *zq,
 	if (rc == 0) {
 		rc = ap_msg->rc;
 		if (rc == 0)
-			rc = convert_response_ep11_xcrb(zq, ap_msg, xcrb);
+			rc = convert_response_ep11_xcrb(userspace, zq, ap_msg, xcrb);
 	} else
 		/* Signal pending. */
 		ap_cancel_message(zq->queue, ap_msg);
diff --git a/drivers/s390/crypto/zcrypt_msgtype6.h b/drivers/s390/crypto/zcrypt_msgtype6.h
index 0de280a81dd4..0a0bf074206b 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.h
+++ b/drivers/s390/crypto/zcrypt_msgtype6.h
@@ -96,9 +96,9 @@ struct type86_fmt2_ext {
 	unsigned int	  offset4;	/* 0x00000000			*/
 } __packed;
 
-unsigned int get_cprb_fc(struct ica_xcRB *, struct ap_message *,
+unsigned int get_cprb_fc(bool userspace, struct ica_xcRB *, struct ap_message *,
 			 unsigned int *, unsigned short **);
-unsigned int get_ep11cprb_fc(struct ep11_urb *, struct ap_message *,
+unsigned int get_ep11cprb_fc(bool userspace, struct ep11_urb *, struct ap_message *,
 			     unsigned int *);
 unsigned int get_rng_fc(struct ap_message *, int *, unsigned int *);
 
-- 
2.17.1
