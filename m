Return-Path: <linux-kernel-owner+w=401wt.eu-S1756251AbYK0Kkp@vger.kernel.org>
Message-Id: <20081127103133.367502008@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:30:40 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 20/60] iucv: Locking free version of iucv_message_(receive|send)
Content-Disposition: inline; filename=119-iucv-lockfree.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

Provide a locking free version of iucv_message_receive and iucv_message_send
that do not call local_bh_enable in a spin_lock_(bh|irqsave)() context.

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---

 include/net/iucv/iucv.h |   45 ++++++++++++++
 net/iucv/iucv.c         |  152 ++++++++++++++++++++++++++++++++++++------------
 2 files changed, 161 insertions(+), 36 deletions(-)

Index: quilt-2.6/include/net/iucv/iucv.h
===================================================================
--- quilt-2.6.orig/include/net/iucv/iucv.h
+++ quilt-2.6/include/net/iucv/iucv.h
@@ -337,12 +337,35 @@ int iucv_message_purge(struct iucv_path 
  * established paths. This function will deal with RMDATA messages
  * embedded in struct iucv_message as well.
  *
+ * Locking:	local_bh_enable/local_bh_disable
+ *
  * Returns the result from the CP IUCV call.
  */
 int iucv_message_receive(struct iucv_path *path, struct iucv_message *msg,
 			 u8 flags, void *buffer, size_t size, size_t *residual);
 
 /**
+ * __iucv_message_receive
+ * @path: address of iucv path structure
+ * @msg: address of iucv msg structure
+ * @flags: flags that affect how the message is received (IUCV_IPBUFLST)
+ * @buffer: address of data buffer or address of struct iucv_array
+ * @size: length of data buffer
+ * @residual:
+ *
+ * This function receives messages that are being sent to you over
+ * established paths. This function will deal with RMDATA messages
+ * embedded in struct iucv_message as well.
+ *
+ * Locking:	no locking.
+ *
+ * Returns the result from the CP IUCV call.
+ */
+int __iucv_message_receive(struct iucv_path *path, struct iucv_message *msg,
+			   u8 flags, void *buffer, size_t size,
+			   size_t *residual);
+
+/**
  * iucv_message_reject
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
@@ -386,12 +409,34 @@ int iucv_message_reply(struct iucv_path 
  * transmitted is in a buffer and this is a one-way message and the
  * receiver will not reply to the message.
  *
+ * Locking:	local_bh_enable/local_bh_disable
+ *
  * Returns the result from the CP IUCV call.
  */
 int iucv_message_send(struct iucv_path *path, struct iucv_message *msg,
 		      u8 flags, u32 srccls, void *buffer, size_t size);
 
 /**
+ * __iucv_message_send
+ * @path: address of iucv path structure
+ * @msg: address of iucv msg structure
+ * @flags: how the message is sent (IUCV_IPRMDATA, IUCV_IPPRTY, IUCV_IPBUFLST)
+ * @srccls: source class of message
+ * @buffer: address of data buffer or address of struct iucv_array
+ * @size: length of send buffer
+ *
+ * This function transmits data to another application. Data to be
+ * transmitted is in a buffer and this is a one-way message and the
+ * receiver will not reply to the message.
+ *
+ * Locking:	no locking.
+ *
+ * Returns the result from the CP IUCV call.
+ */
+int __iucv_message_send(struct iucv_path *path, struct iucv_message *msg,
+			u8 flags, u32 srccls, void *buffer, size_t size);
+
+/**
  * iucv_message_send2way
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
Index: quilt-2.6/net/iucv/iucv.c
===================================================================
--- quilt-2.6.orig/net/iucv/iucv.c
+++ quilt-2.6/net/iucv/iucv.c
@@ -957,7 +957,52 @@ int iucv_message_purge(struct iucv_path 
 EXPORT_SYMBOL(iucv_message_purge);
 
 /**
- * iucv_message_receive
+ * iucv_message_receive_iprmdata
+ * @path: address of iucv path structure
+ * @msg: address of iucv msg structure
+ * @flags: how the message is received (IUCV_IPBUFLST)
+ * @buffer: address of data buffer or address of struct iucv_array
+ * @size: length of data buffer
+ * @residual:
+ *
+ * Internal function used by iucv_message_receive and __iucv_message_receive
+ * to receive RMDATA data stored in struct iucv_message.
+ */
+static int iucv_message_receive_iprmdata(struct iucv_path *path,
+					 struct iucv_message *msg,
+					 u8 flags, void *buffer,
+					 size_t size, size_t *residual)
+{
+	struct iucv_array *array;
+	u8 *rmmsg;
+	size_t copy;
+
+	/*
+	 * Message is 8 bytes long and has been stored to the
+	 * message descriptor itself.
+	 */
+	if (residual)
+		*residual = abs(size - 8);
+	rmmsg = msg->rmmsg;
+	if (flags & IUCV_IPBUFLST) {
+		/* Copy to struct iucv_array. */
+		size = (size < 8) ? size : 8;
+		for (array = buffer; size > 0; array++) {
+			copy = min_t(size_t, size, array->length);
+			memcpy((u8 *)(addr_t) array->address,
+				rmmsg, copy);
+			rmmsg += copy;
+			size -= copy;
+		}
+	} else {
+		/* Copy to direct buffer. */
+		memcpy(buffer, rmmsg, min_t(size_t, size, 8));
+	}
+	return 0;
+}
+
+/**
+ * __iucv_message_receive
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
  * @flags: how the message is received (IUCV_IPBUFLST)
@@ -969,44 +1014,19 @@ EXPORT_SYMBOL(iucv_message_purge);
  * established paths. This function will deal with RMDATA messages
  * embedded in struct iucv_message as well.
  *
+ * Locking:	no locking
+ *
  * Returns the result from the CP IUCV call.
  */
-int iucv_message_receive(struct iucv_path *path, struct iucv_message *msg,
-			 u8 flags, void *buffer, size_t size, size_t *residual)
+int __iucv_message_receive(struct iucv_path *path, struct iucv_message *msg,
+			   u8 flags, void *buffer, size_t size, size_t *residual)
 {
 	union iucv_param *parm;
-	struct iucv_array *array;
-	u8 *rmmsg;
-	size_t copy;
 	int rc;
 
-	if (msg->flags & IUCV_IPRMDATA) {
-		/*
-		 * Message is 8 bytes long and has been stored to the
-		 * message descriptor itself.
-		 */
-		rc = (size < 8) ? 5 : 0;
-		if (residual)
-			*residual = abs(size - 8);
-		rmmsg = msg->rmmsg;
-		if (flags & IUCV_IPBUFLST) {
-			/* Copy to struct iucv_array. */
-			size = (size < 8) ? size : 8;
-			for (array = buffer; size > 0; array++) {
-				copy = min_t(size_t, size, array->length);
-				memcpy((u8 *)(addr_t) array->address,
-				       rmmsg, copy);
-				rmmsg += copy;
-				size -= copy;
-			}
-		} else {
-			/* Copy to direct buffer. */
-			memcpy(buffer, rmmsg, min_t(size_t, size, 8));
-		}
-		return 0;
-	}
-
-	local_bh_disable();
+	if (msg->flags & IUCV_IPRMDATA)
+		return iucv_message_receive_iprmdata(path, msg, flags,
+						     buffer, size, residual);
 	parm = iucv_param[smp_processor_id()];
 	memset(parm, 0, sizeof(union iucv_param));
 	parm->db.ipbfadr1 = (u32)(addr_t) buffer;
@@ -1022,6 +1042,37 @@ int iucv_message_receive(struct iucv_pat
 		if (residual)
 			*residual = parm->db.ipbfln1f;
 	}
+	return rc;
+}
+EXPORT_SYMBOL(__iucv_message_receive);
+
+/**
+ * iucv_message_receive
+ * @path: address of iucv path structure
+ * @msg: address of iucv msg structure
+ * @flags: how the message is received (IUCV_IPBUFLST)
+ * @buffer: address of data buffer or address of struct iucv_array
+ * @size: length of data buffer
+ * @residual:
+ *
+ * This function receives messages that are being sent to you over
+ * established paths. This function will deal with RMDATA messages
+ * embedded in struct iucv_message as well.
+ *
+ * Locking:	local_bh_enable/local_bh_disable
+ *
+ * Returns the result from the CP IUCV call.
+ */
+int iucv_message_receive(struct iucv_path *path, struct iucv_message *msg,
+			 u8 flags, void *buffer, size_t size, size_t *residual)
+{
+	int rc;
+
+	if (msg->flags & IUCV_IPRMDATA)
+		return iucv_message_receive_iprmdata(path, msg, flags,
+						     buffer, size, residual);
+	local_bh_disable();
+	rc = __iucv_message_receive(path, msg, flags, buffer, size, residual);
 	local_bh_enable();
 	return rc;
 }
@@ -1101,7 +1152,7 @@ int iucv_message_reply(struct iucv_path 
 EXPORT_SYMBOL(iucv_message_reply);
 
 /**
- * iucv_message_send
+ * __iucv_message_send
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
  * @flags: how the message is sent (IUCV_IPRMDATA, IUCV_IPPRTY, IUCV_IPBUFLST)
@@ -1113,15 +1164,16 @@ EXPORT_SYMBOL(iucv_message_reply);
  * transmitted is in a buffer and this is a one-way message and the
  * receiver will not reply to the message.
  *
+ * Locking:	no locking
+ *
  * Returns the result from the CP IUCV call.
  */
-int iucv_message_send(struct iucv_path *path, struct iucv_message *msg,
+int __iucv_message_send(struct iucv_path *path, struct iucv_message *msg,
 		      u8 flags, u32 srccls, void *buffer, size_t size)
 {
 	union iucv_param *parm;
 	int rc;
 
-	local_bh_disable();
 	parm = iucv_param[smp_processor_id()];
 	memset(parm, 0, sizeof(union iucv_param));
 	if (flags & IUCV_IPRMDATA) {
@@ -1144,6 +1196,34 @@ int iucv_message_send(struct iucv_path *
 	rc = iucv_call_b2f0(IUCV_SEND, parm);
 	if (!rc)
 		msg->id = parm->db.ipmsgid;
+	return rc;
+}
+EXPORT_SYMBOL(__iucv_message_send);
+
+/**
+ * iucv_message_send
+ * @path: address of iucv path structure
+ * @msg: address of iucv msg structure
+ * @flags: how the message is sent (IUCV_IPRMDATA, IUCV_IPPRTY, IUCV_IPBUFLST)
+ * @srccls: source class of message
+ * @buffer: address of send buffer or address of struct iucv_array
+ * @size: length of send buffer
+ *
+ * This function transmits data to another application. Data to be
+ * transmitted is in a buffer and this is a one-way message and the
+ * receiver will not reply to the message.
+ *
+ * Locking:	local_bh_enable/local_bh_disable
+ *
+ * Returns the result from the CP IUCV call.
+ */
+int iucv_message_send(struct iucv_path *path, struct iucv_message *msg,
+		      u8 flags, u32 srccls, void *buffer, size_t size)
+{
+	int rc;
+
+	local_bh_disable();
+	rc = __iucv_message_send(path, msg, flags, srccls, buffer, size);
 	local_bh_enable();
 	return rc;
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
