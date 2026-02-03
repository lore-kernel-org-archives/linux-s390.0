Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D423326562D;
	Tue,  3 Feb 2026 07:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770105177; cv=none; b=oy4/+8STUG/SH3bIlDXk47aNPTZMzbMDFTnlSfrZIejf/cTm48O1Ryb0fxl6DONm0yPRjM7DlsLZZYl4sFYczT5y9fdkRunBpVaxSIsHYzslatFH5Xks4CKpOFGODwfG4vt5nYWWV0CZakjLIJRiVp1hDYQQVsiSH5vLA8SDfgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770105177; c=relaxed/simple;
	bh=WOqtE6eaD+wqsed5lrLrPQfeszzp6MkHOSeMKAUt8Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XDAn1l8ZObe9rWYsREfpJWTVme6KsoOSjxDHoY1pKYDQlUh7sV8R0j9hFbI70qsKw8FJic8YY829qxkQHHlmJw7Rxcj2rl/fRt+3FUBdTKfsF6fARMJLXYM7W7FgqaH97kT0I1VOpxA/tUesBuuz32/xzlJm3OgFhmrwjeLuhw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=v5GzDKNk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v5GzDKNk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=WIXvkzx8iUqqeDStuXY1tbIZQcWn61Qd5F6faw4yzNI=; b=v5GzDKNkJPa4AD1kHBnOT9vG31
	j4gvFKV7GTNA0P5GL8pwNMS5PEusLhdVmRbj03uZ0fu2Uj3igYLV/h4v8i7p10EkIM1yh+Gqf8ELm
	fPG33uwAwim+HGPb8FTESmziLB4A/e7wcRqUFshDOgXezjXP4aDKnnvlGfWfkY/JKbWCsVf4Tla8F
	rvkg20Fvt6hUqjWc1v7H5aN1QXT2kVwS9KdBEszIJSAFCRHzhCjseHDy7maIqiZM02n0+irs0Etey
	7MN7BObuhcD0e1Oy492ZBHEMBaC5p5VRTsA64/JwaexIwETdN8421e67MEmnS/y524dMbPXDd92fO
	DwihS/RA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnBDP-00000006GOn-0yLA;
	Tue, 03 Feb 2026 07:52:51 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v3 net-next] net/iucv: clean up iucv kernel-doc warnings
Date: Mon,  2 Feb 2026 23:52:48 -0800
Message-ID: <20260203075248.1177869-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix numerous (many) kernel-doc warnings in iucv.[ch]:

- convert function documentation comments to a common (kernel-doc) look,
  even for static functions (without "/**")
- use matching parameter and parameter description names
- use better wording in function descriptions (Jakub & AI)
- remove duplicate kernel-doc comments from the header file (Jakub)

Examples:

Warning: include/net/iucv/iucv.h:210 missing initial short description
 on line: * iucv_unregister
Warning: include/net/iucv/iucv.h:216 function parameter 'handle' not
 described in 'iucv_unregister'
Warning: include/net/iucv/iucv.h:467 function parameter 'answer' not
 described in 'iucv_message_send2way'
Warning: net/iucv/iucv.c:727 missing initial short description on line:
 * iucv_cleanup_queue

Build-tested with both "make htmldocs" and "make ARCH=s390 defconfig all".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v3:
- I didn't use Alexandra'a (v2) Reviewed-by: due to the number of changes.
- leave kernel-doc ("/**") on static functions in iucv.c (I did not
  convert other static functions to kernel-doc comments.)
v2:
- correct verbs in descriptions of 2 functions (Jakub)
- remove duplicate kernel-doc comments from the header file (Jakub)

Cc: Alexandra Winter <wintera@linux.ibm.com>
Cc: Thorsten Winkler <twinkler@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>

 include/net/iucv/iucv.h |  207 ----------------------------------
 net/iucv/iucv.c         |  227 ++++++++++++++++++--------------------
 2 files changed, 111 insertions(+), 323 deletions(-)

--- linux-next-20260202.orig/include/net/iucv/iucv.h
+++ linux-next-20260202/include/net/iucv/iucv.h
@@ -195,35 +195,15 @@ struct iucv_handler {
 	struct list_head paths;
 };
 
-/**
- * iucv_register:
- * @handler: address of iucv handler structure
- * @smp: != 0 indicates that the handler can deal with out of order messages
- *
- * Registers a driver with IUCV.
- *
- * Returns: 0 on success, -ENOMEM if the memory allocation for the pathid
- * table failed, or -EIO if IUCV_DECLARE_BUFFER failed on all cpus.
- */
 int iucv_register(struct iucv_handler *handler, int smp);
+void iucv_unregister(struct iucv_handler *handler, int smp);
 
 /**
- * iucv_unregister
- * @handler:  address of iucv handler structure
- * @smp: != 0 indicates that the handler can deal with out of order messages
- *
- * Unregister driver from IUCV.
- */
-void iucv_unregister(struct iucv_handler *handle, int smp);
-
-/**
- * iucv_path_alloc
+ * iucv_path_alloc - Allocate a new path structure for use with iucv_connect.
  * @msglim: initial message limit
  * @flags: initial flags
  * @gfp: kmalloc allocation flag
  *
- * Allocate a new path structure for use with iucv_connect.
- *
  * Returns: NULL if the memory allocation failed or a pointer to the
  * path structure.
  */
@@ -240,229 +220,48 @@ static inline struct iucv_path *iucv_pat
 }
 
 /**
- * iucv_path_free
+ * iucv_path_free - Frees a path structure.
  * @path: address of iucv path structure
- *
- * Frees a path structure.
  */
 static inline void iucv_path_free(struct iucv_path *path)
 {
 	kfree(path);
 }
 
-/**
- * iucv_path_accept
- * @path: address of iucv path structure
- * @handler: address of iucv handler structure
- * @userdata: 16 bytes of data reflected to the communication partner
- * @private: private data passed to interrupt handlers for this path
- *
- * This function is issued after the user received a connection pending
- * external interrupt and now wishes to complete the IUCV communication path.
- *
- * Returns: the result of the CP IUCV call.
- */
 int iucv_path_accept(struct iucv_path *path, struct iucv_handler *handler,
 		     u8 *userdata, void *private);
 
-/**
- * iucv_path_connect
- * @path: address of iucv path structure
- * @handler: address of iucv handler structure
- * @userid: 8-byte user identification
- * @system: 8-byte target system identification
- * @userdata: 16 bytes of data reflected to the communication partner
- * @private: private data passed to interrupt handlers for this path
- *
- * This function establishes an IUCV path. Although the connect may complete
- * successfully, you are not able to use the path until you receive an IUCV
- * Connection Complete external interrupt.
- *
- * Returns: the result of the CP IUCV call.
- */
 int iucv_path_connect(struct iucv_path *path, struct iucv_handler *handler,
 		      u8 *userid, u8 *system, u8 *userdata,
 		      void *private);
 
-/**
- * iucv_path_quiesce:
- * @path: address of iucv path structure
- * @userdata: 16 bytes of data reflected to the communication partner
- *
- * This function temporarily suspends incoming messages on an IUCV path.
- * You can later reactivate the path by invoking the iucv_resume function.
- *
- * Returns: the result from the CP IUCV call.
- */
 int iucv_path_quiesce(struct iucv_path *path, u8 *userdata);
 
-/**
- * iucv_path_resume:
- * @path: address of iucv path structure
- * @userdata: 16 bytes of data reflected to the communication partner
- *
- * This function resumes incoming messages on an IUCV path that has
- * been stopped with iucv_path_quiesce.
- *
- * Returns: the result from the CP IUCV call.
- */
 int iucv_path_resume(struct iucv_path *path, u8 *userdata);
 
-/**
- * iucv_path_sever
- * @path: address of iucv path structure
- * @userdata: 16 bytes of data reflected to the communication partner
- *
- * This function terminates an IUCV path.
- *
- * Returns: the result from the CP IUCV call.
- */
 int iucv_path_sever(struct iucv_path *path, u8 *userdata);
 
-/**
- * iucv_message_purge
- * @path: address of iucv path structure
- * @msg: address of iucv msg structure
- * @srccls: source class of message
- *
- * Cancels a message you have sent.
- *
- * Returns: the result from the CP IUCV call.
- */
 int iucv_message_purge(struct iucv_path *path, struct iucv_message *msg,
 		       u32 srccls);
 
-/**
- * iucv_message_receive
- * @path: address of iucv path structure
- * @msg: address of iucv msg structure
- * @flags: flags that affect how the message is received (IUCV_IPBUFLST)
- * @buffer: address of data buffer or address of struct iucv_array
- * @size: length of data buffer
- * @residual:
- *
- * This function receives messages that are being sent to you over
- * established paths. This function will deal with RMDATA messages
- * embedded in struct iucv_message as well.
- *
- * Locking:	local_bh_enable/local_bh_disable
- *
- * Returns: the result from the CP IUCV call.
- */
 int iucv_message_receive(struct iucv_path *path, struct iucv_message *msg,
 			 u8 flags, void *buffer, size_t size, size_t *residual);
 
-/**
- * __iucv_message_receive
- * @path: address of iucv path structure
- * @msg: address of iucv msg structure
- * @flags: flags that affect how the message is received (IUCV_IPBUFLST)
- * @buffer: address of data buffer or address of struct iucv_array
- * @size: length of data buffer
- * @residual:
- *
- * This function receives messages that are being sent to you over
- * established paths. This function will deal with RMDATA messages
- * embedded in struct iucv_message as well.
- *
- * Locking:	no locking.
- *
- * Returns: the result from the CP IUCV call.
- */
 int __iucv_message_receive(struct iucv_path *path, struct iucv_message *msg,
 			   u8 flags, void *buffer, size_t size,
 			   size_t *residual);
 
-/**
- * iucv_message_reject
- * @path: address of iucv path structure
- * @msg: address of iucv msg structure
- *
- * The reject function refuses a specified message. Between the time you
- * are notified of a message and the time that you complete the message,
- * the message may be rejected.
- *
- * Returns: the result from the CP IUCV call.
- */
 int iucv_message_reject(struct iucv_path *path, struct iucv_message *msg);
 
-/**
- * iucv_message_reply
- * @path: address of iucv path structure
- * @msg: address of iucv msg structure
- * @flags: how the reply is sent (IUCV_IPRMDATA, IUCV_IPPRTY, IUCV_IPBUFLST)
- * @reply: address of data buffer or address of struct iucv_array
- * @size: length of reply data buffer
- *
- * This function responds to the two-way messages that you receive. You
- * must identify completely the message to which you wish to reply. ie,
- * pathid, msgid, and trgcls. Prmmsg signifies the data is moved into
- * the parameter list.
- *
- * Returns: the result from the CP IUCV call.
- */
 int iucv_message_reply(struct iucv_path *path, struct iucv_message *msg,
 		       u8 flags, void *reply, size_t size);
 
-/**
- * iucv_message_send
- * @path: address of iucv path structure
- * @msg: address of iucv msg structure
- * @flags: how the message is sent (IUCV_IPRMDATA, IUCV_IPPRTY, IUCV_IPBUFLST)
- * @srccls: source class of message
- * @buffer: address of data buffer or address of struct iucv_array
- * @size: length of send buffer
- *
- * This function transmits data to another application. Data to be
- * transmitted is in a buffer and this is a one-way message and the
- * receiver will not reply to the message.
- *
- * Locking:	local_bh_enable/local_bh_disable
- *
- * Returns: the result from the CP IUCV call.
- */
 int iucv_message_send(struct iucv_path *path, struct iucv_message *msg,
 		      u8 flags, u32 srccls, void *buffer, size_t size);
 
-/**
- * __iucv_message_send
- * @path: address of iucv path structure
- * @msg: address of iucv msg structure
- * @flags: how the message is sent (IUCV_IPRMDATA, IUCV_IPPRTY, IUCV_IPBUFLST)
- * @srccls: source class of message
- * @buffer: address of data buffer or address of struct iucv_array
- * @size: length of send buffer
- *
- * This function transmits data to another application. Data to be
- * transmitted is in a buffer and this is a one-way message and the
- * receiver will not reply to the message.
- *
- * Locking:	no locking.
- *
- * Returns: the result from the CP IUCV call.
- */
 int __iucv_message_send(struct iucv_path *path, struct iucv_message *msg,
 			u8 flags, u32 srccls, void *buffer, size_t size);
 
-/**
- * iucv_message_send2way
- * @path: address of iucv path structure
- * @msg: address of iucv msg structure
- * @flags: how the message is sent and the reply is received
- *	   (IUCV_IPRMDATA, IUCV_IPBUFLST, IUCV_IPPRTY, IUCV_ANSLST)
- * @srccls: source class of message
- * @buffer: address of data buffer or address of struct iucv_array
- * @size: length of send buffer
- * @ansbuf: address of answer buffer or address of struct iucv_array
- * @asize: size of reply buffer
- *
- * This function transmits data to another application. Data to be
- * transmitted is in a buffer. The receiver of the send is expected to
- * reply to the message and a buffer is provided into which IUCV moves
- * the reply to this message.
- *
- * Returns: the result from the CP IUCV call.
- */
 int iucv_message_send2way(struct iucv_path *path, struct iucv_message *msg,
 			  u8 flags, u32 srccls, void *buffer, size_t size,
 			  void *answer, size_t asize, size_t *residual);
--- linux-next-20260202.orig/net/iucv/iucv.c
+++ linux-next-20260202/net/iucv/iucv.c
@@ -313,13 +313,12 @@ static union iucv_param *iucv_param[NR_C
 static union iucv_param *iucv_param_irq[NR_CPUS];
 
 /**
- * __iucv_call_b2f0
+ * __iucv_call_b2f0 - Calls CP to execute IUCV commands.
+ *
  * @command: identifier of IUCV call to CP.
  * @parm: pointer to a struct iucv_parm block
  *
- * Calls CP to execute IUCV commands.
- *
- * Returns the result of the CP IUCV call.
+ * Returns: the result of the CP IUCV call.
  */
 static inline int __iucv_call_b2f0(int command, union iucv_param *parm)
 {
@@ -348,11 +347,10 @@ static inline int iucv_call_b2f0(int com
 }
 
 /*
- * iucv_query_maxconn
+ * iucv_query_maxconn - Determine the maximum number of connections that
+ * may be established.
  *
- * Determines the maximum number of connections that may be established.
- *
- * Returns the maximum number of connections or -EPERM is IUCV is not
+ * Returns: the maximum number of connections or -EPERM is IUCV is not
  * available.
  */
 static int __iucv_query_maxconn(void *param, unsigned long *max_pathid)
@@ -391,10 +389,9 @@ static int iucv_query_maxconn(void)
 }
 
 /**
- * iucv_allow_cpu
- * @data: unused
+ * iucv_allow_cpu - Allow iucv interrupts on this cpu.
  *
- * Allow iucv interrupts on this cpu.
+ * @data: unused
  */
 static void iucv_allow_cpu(void *data)
 {
@@ -432,10 +429,9 @@ static void iucv_allow_cpu(void *data)
 }
 
 /**
- * iucv_block_cpu
- * @data: unused
+ * iucv_block_cpu - Block iucv interrupts on this cpu.
  *
- * Block iucv interrupts on this cpu.
+ * @data: unused
  */
 static void iucv_block_cpu(void *data)
 {
@@ -452,10 +448,9 @@ static void iucv_block_cpu(void *data)
 }
 
 /**
- * iucv_declare_cpu
- * @data: unused
+ * iucv_declare_cpu - Declare a interrupt buffer on this cpu.
  *
- * Declare a interrupt buffer on this cpu.
+ * @data: unused
  */
 static void iucv_declare_cpu(void *data)
 {
@@ -507,10 +502,9 @@ static void iucv_declare_cpu(void *data)
 }
 
 /**
- * iucv_retrieve_cpu
- * @data: unused
+ * iucv_retrieve_cpu - Retrieve interrupt buffer on this cpu.
  *
- * Retrieve interrupt buffer on this cpu.
+ * @data: unused
  */
 static void iucv_retrieve_cpu(void *data)
 {
@@ -532,9 +526,7 @@ static void iucv_retrieve_cpu(void *data
 }
 
 /*
- * iucv_setmask_mp
- *
- * Allow iucv interrupts on all cpus.
+ * iucv_setmask_mp - Allow iucv interrupts on all cpus.
  */
 static void iucv_setmask_mp(void)
 {
@@ -551,9 +543,7 @@ static void iucv_setmask_mp(void)
 }
 
 /*
- * iucv_setmask_up
- *
- * Allow iucv interrupts on a single cpu.
+ * iucv_setmask_up - Allow iucv interrupts on a single cpu.
  */
 static void iucv_setmask_up(void)
 {
@@ -568,12 +558,11 @@ static void iucv_setmask_up(void)
 }
 
 /*
- * iucv_enable
+ * iucv_enable - Make the iucv ready for use
  *
- * This function makes iucv ready for use. It allocates the pathid
- * table, declares an iucv interrupt buffer and enables the iucv
- * interrupts. Called when the first user has registered an iucv
- * handler.
+ * It allocates the pathid table, declares an iucv interrupt buffer and
+ * enables the iucv interrupts. Called when the first user has registered
+ * an iucv handler.
  */
 static int iucv_enable(void)
 {
@@ -603,11 +592,10 @@ out:
 }
 
 /*
- * iucv_disable
+ * iucv_disable - Shuts down iucv.
  *
- * This function shuts down iucv. It disables iucv interrupts, retrieves
- * the iucv interrupt buffer and frees the pathid table. Called after the
- * last user unregister its iucv handler.
+ * It disables iucv interrupts, retrieves the iucv interrupt buffer and frees
+ * the pathid table. Called after the last user unregister its iucv handler.
  */
 static void iucv_disable(void)
 {
@@ -695,11 +683,10 @@ __free_cpumask:
 }
 
 /**
- * iucv_sever_pathid
+ * iucv_sever_pathid - Sever an iucv path to free up the pathid. Used internally.
+ *
  * @pathid: path identification number.
  * @userdata: 16-bytes of user data.
- *
- * Sever an iucv path to free up the pathid. Used internally.
  */
 static int iucv_sever_pathid(u16 pathid, u8 *userdata)
 {
@@ -714,22 +701,20 @@ static int iucv_sever_pathid(u16 pathid,
 }
 
 /**
- * __iucv_cleanup_queue
- * @dummy: unused dummy argument
+ * __iucv_cleanup_queue - Nop function called via smp_call_function to force
+ * work items from pending external iucv interrupts to the work queue.
  *
- * Nop function called via smp_call_function to force work items from
- * pending external iucv interrupts to the work queue.
+ * @dummy: unused dummy argument
  */
 static void __iucv_cleanup_queue(void *dummy)
 {
 }
 
 /**
- * iucv_cleanup_queue
+ * iucv_cleanup_queue - Called after a path has been severed to find all
+ * remaining work items for the now stale pathid.
  *
- * Function called after a path has been severed to find all remaining
- * work items for the now stale pathid. The caller needs to hold the
- * iucv_table_lock.
+ * The caller needs to hold the iucv_table_lock.
  */
 static void iucv_cleanup_queue(void)
 {
@@ -757,13 +742,12 @@ static void iucv_cleanup_queue(void)
 }
 
 /**
- * iucv_register:
+ * iucv_register - Registers a driver with IUCV.
+ *
  * @handler: address of iucv handler structure
  * @smp: != 0 indicates that the handler can deal with out of order messages
  *
- * Registers a driver with IUCV.
- *
- * Returns 0 on success, -ENOMEM if the memory allocation for the pathid
+ * Returns: 0 on success, -ENOMEM if the memory allocation for the pathid
  * table failed, or -EIO if IUCV_DECLARE_BUFFER failed on all cpus.
  */
 int iucv_register(struct iucv_handler *handler, int smp)
@@ -794,11 +778,10 @@ out_mutex:
 EXPORT_SYMBOL(iucv_register);
 
 /**
- * iucv_unregister
+ * iucv_unregister - Unregister driver from IUCV.
+ *
  * @handler:  address of iucv handler structure
  * @smp: != 0 indicates that the handler can deal with out of order messages
- *
- * Unregister driver from IUCV.
  */
 void iucv_unregister(struct iucv_handler *handler, int smp)
 {
@@ -852,7 +835,8 @@ static struct notifier_block iucv_reboot
 };
 
 /**
- * iucv_path_accept
+ * iucv_path_accept - Complete the IUCV communication path
+ *
  * @path: address of iucv path structure
  * @handler: address of iucv handler structure
  * @userdata: 16 bytes of data reflected to the communication partner
@@ -861,7 +845,7 @@ static struct notifier_block iucv_reboot
  * This function is issued after the user received a connection pending
  * external interrupt and now wishes to complete the IUCV communication path.
  *
- * Returns the result of the CP IUCV call.
+ * Returns: the result of the CP IUCV call.
  */
 int iucv_path_accept(struct iucv_path *path, struct iucv_handler *handler,
 		     u8 *userdata, void *private)
@@ -896,7 +880,8 @@ out:
 EXPORT_SYMBOL(iucv_path_accept);
 
 /**
- * iucv_path_connect
+ * iucv_path_connect - Establish an IUCV path
+ *
  * @path: address of iucv path structure
  * @handler: address of iucv handler structure
  * @userid: 8-byte user identification
@@ -908,7 +893,7 @@ EXPORT_SYMBOL(iucv_path_accept);
  * successfully, you are not able to use the path until you receive an IUCV
  * Connection Complete external interrupt.
  *
- * Returns the result of the CP IUCV call.
+ * Returns: the result of the CP IUCV call.
  */
 int iucv_path_connect(struct iucv_path *path, struct iucv_handler *handler,
 		      u8 *userid, u8 *system, u8 *userdata,
@@ -964,14 +949,14 @@ out:
 EXPORT_SYMBOL(iucv_path_connect);
 
 /**
- * iucv_path_quiesce:
+ * iucv_path_quiesce - Temporarily suspend incoming messages
  * @path: address of iucv path structure
  * @userdata: 16 bytes of data reflected to the communication partner
  *
  * This function temporarily suspends incoming messages on an IUCV path.
  * You can later reactivate the path by invoking the iucv_resume function.
  *
- * Returns the result from the CP IUCV call.
+ * Returns: the result from the CP IUCV call.
  */
 int iucv_path_quiesce(struct iucv_path *path, u8 *userdata)
 {
@@ -996,14 +981,15 @@ out:
 EXPORT_SYMBOL(iucv_path_quiesce);
 
 /**
- * iucv_path_resume:
+ * iucv_path_resume - Resume incoming messages on a suspended IUCV path
+ *
  * @path: address of iucv path structure
  * @userdata: 16 bytes of data reflected to the communication partner
  *
  * This function resumes incoming messages on an IUCV path that has
  * been stopped with iucv_path_quiesce.
  *
- * Returns the result from the CP IUCV call.
+ * Returns: the result from the CP IUCV call.
  */
 int iucv_path_resume(struct iucv_path *path, u8 *userdata)
 {
@@ -1027,13 +1013,12 @@ out:
 }
 
 /**
- * iucv_path_sever
+ * iucv_path_sever - Terminates an IUCV path.
+ *
  * @path: address of iucv path structure
  * @userdata: 16 bytes of data reflected to the communication partner
  *
- * This function terminates an IUCV path.
- *
- * Returns the result from the CP IUCV call.
+ * Returns: the result from the CP IUCV call.
  */
 int iucv_path_sever(struct iucv_path *path, u8 *userdata)
 {
@@ -1058,14 +1043,13 @@ out:
 EXPORT_SYMBOL(iucv_path_sever);
 
 /**
- * iucv_message_purge
+ * iucv_message_purge - Cancels a message you have sent.
+ *
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
  * @srccls: source class of message
  *
- * Cancels a message you have sent.
- *
- * Returns the result from the CP IUCV call.
+ * Returns: the result from the CP IUCV call.
  */
 int iucv_message_purge(struct iucv_path *path, struct iucv_message *msg,
 		       u32 srccls)
@@ -1096,13 +1080,15 @@ out:
 EXPORT_SYMBOL(iucv_message_purge);
 
 /**
- * iucv_message_receive_iprmdata
+ * iucv_message_receive_iprmdata - Internal function to receive RMDATA
+ * stored in &struct iucv_message
+ *
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
  * @flags: how the message is received (IUCV_IPBUFLST)
  * @buffer: address of data buffer or address of struct iucv_array
  * @size: length of data buffer
- * @residual:
+ * @residual: number of bytes remaining in the data buffer
  *
  * Internal function used by iucv_message_receive and __iucv_message_receive
  * to receive RMDATA data stored in struct iucv_message.
@@ -1140,10 +1126,11 @@ static int iucv_message_receive_iprmdata
 }
 
 /**
- * __iucv_message_receive
+ * __iucv_message_receive - Receives messages on an established path (no locking)
+ *
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
- * @flags: how the message is received (IUCV_IPBUFLST)
+ * @flags: flags that affect how the message is received (IUCV_IPBUFLST)
  * @buffer: address of data buffer or address of struct iucv_array
  * @size: length of data buffer
  * @residual:
@@ -1154,7 +1141,7 @@ static int iucv_message_receive_iprmdata
  *
  * Locking:	no locking
  *
- * Returns the result from the CP IUCV call.
+ * Returns: the result from the CP IUCV call.
  */
 int __iucv_message_receive(struct iucv_path *path, struct iucv_message *msg,
 			   u8 flags, void *buffer, size_t size, size_t *residual)
@@ -1188,10 +1175,11 @@ int __iucv_message_receive(struct iucv_p
 EXPORT_SYMBOL(__iucv_message_receive);
 
 /**
- * iucv_message_receive
+ * iucv_message_receive - Receives messages on an established path, with locking
+ *
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
- * @flags: how the message is received (IUCV_IPBUFLST)
+ * @flags: flags that affect how the message is received (IUCV_IPBUFLST)
  * @buffer: address of data buffer or address of struct iucv_array
  * @size: length of data buffer
  * @residual:
@@ -1202,7 +1190,7 @@ EXPORT_SYMBOL(__iucv_message_receive);
  *
  * Locking:	local_bh_enable/local_bh_disable
  *
- * Returns the result from the CP IUCV call.
+ * Returns: the result from the CP IUCV call.
  */
 int iucv_message_receive(struct iucv_path *path, struct iucv_message *msg,
 			 u8 flags, void *buffer, size_t size, size_t *residual)
@@ -1220,7 +1208,8 @@ int iucv_message_receive(struct iucv_pat
 EXPORT_SYMBOL(iucv_message_receive);
 
 /**
- * iucv_message_reject
+ * iucv_message_reject - Refuses a specified message
+ *
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
  *
@@ -1228,7 +1217,7 @@ EXPORT_SYMBOL(iucv_message_receive);
  * are notified of a message and the time that you complete the message,
  * the message may be rejected.
  *
- * Returns the result from the CP IUCV call.
+ * Returns: the result from the CP IUCV call.
  */
 int iucv_message_reject(struct iucv_path *path, struct iucv_message *msg)
 {
@@ -1254,7 +1243,8 @@ out:
 EXPORT_SYMBOL(iucv_message_reject);
 
 /**
- * iucv_message_reply
+ * iucv_message_reply - Replies to a specified message
+ *
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
  * @flags: how the reply is sent (IUCV_IPRMDATA, IUCV_IPPRTY, IUCV_IPBUFLST)
@@ -1262,11 +1252,11 @@ EXPORT_SYMBOL(iucv_message_reject);
  * @size: length of reply data buffer
  *
  * This function responds to the two-way messages that you receive. You
- * must identify completely the message to which you wish to reply. ie,
+ * must identify completely the message to which you wish to reply. I.e.,
  * pathid, msgid, and trgcls. Prmmsg signifies the data is moved into
  * the parameter list.
  *
- * Returns the result from the CP IUCV call.
+ * Returns: the result from the CP IUCV call.
  */
 int iucv_message_reply(struct iucv_path *path, struct iucv_message *msg,
 		       u8 flags, void *reply, size_t size)
@@ -1303,7 +1293,8 @@ out:
 EXPORT_SYMBOL(iucv_message_reply);
 
 /**
- * __iucv_message_send
+ * __iucv_message_send - Transmits a one-way message, no locking
+ *
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
  * @flags: how the message is sent (IUCV_IPRMDATA, IUCV_IPPRTY, IUCV_IPBUFLST)
@@ -1317,7 +1308,7 @@ EXPORT_SYMBOL(iucv_message_reply);
  *
  * Locking:	no locking
  *
- * Returns the result from the CP IUCV call.
+ * Returns: the result from the CP IUCV call.
  */
 int __iucv_message_send(struct iucv_path *path, struct iucv_message *msg,
 		      u8 flags, u32 srccls, void *buffer, size_t size)
@@ -1357,7 +1348,8 @@ out:
 EXPORT_SYMBOL(__iucv_message_send);
 
 /**
- * iucv_message_send
+ * iucv_message_send - Transmits a one-way message, with locking
+ *
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
  * @flags: how the message is sent (IUCV_IPRMDATA, IUCV_IPPRTY, IUCV_IPBUFLST)
@@ -1371,7 +1363,7 @@ EXPORT_SYMBOL(__iucv_message_send);
  *
  * Locking:	local_bh_enable/local_bh_disable
  *
- * Returns the result from the CP IUCV call.
+ * Returns: the result from the CP IUCV call.
  */
 int iucv_message_send(struct iucv_path *path, struct iucv_message *msg,
 		      u8 flags, u32 srccls, void *buffer, size_t size)
@@ -1386,7 +1378,8 @@ int iucv_message_send(struct iucv_path *
 EXPORT_SYMBOL(iucv_message_send);
 
 /**
- * iucv_message_send2way
+ * iucv_message_send2way - Transmits a two-way message
+ *
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
  * @flags: how the message is sent and the reply is received
@@ -1403,7 +1396,7 @@ EXPORT_SYMBOL(iucv_message_send);
  * reply to the message and a buffer is provided into which IUCV moves
  * the reply to this message.
  *
- * Returns the result from the CP IUCV call.
+ * Returns: the result from the CP IUCV call.
  */
 int iucv_message_send2way(struct iucv_path *path, struct iucv_message *msg,
 			  u8 flags, u32 srccls, void *buffer, size_t size,
@@ -1462,11 +1455,11 @@ struct iucv_path_pending {
 } __packed;
 
 /**
- * iucv_path_pending
+ * iucv_path_pending - Process connection pending work item
+ *
  * @data: Pointer to external interrupt buffer
  *
- * Process connection pending work item. Called from tasklet while holding
- * iucv_table_lock.
+ * Context: Called from tasklet while holding iucv_table_lock.
  */
 static void iucv_path_pending(struct iucv_irq_data *data)
 {
@@ -1523,11 +1516,11 @@ struct iucv_path_complete {
 } __packed;
 
 /**
- * iucv_path_complete
+ * iucv_path_complete - Process connection complete work item
+ *
  * @data: Pointer to external interrupt buffer
  *
- * Process connection complete work item. Called from tasklet while holding
- * iucv_table_lock.
+ * Context: Called from tasklet while holding iucv_table_lock.
  */
 static void iucv_path_complete(struct iucv_irq_data *data)
 {
@@ -1553,11 +1546,11 @@ struct iucv_path_severed {
 } __packed;
 
 /**
- * iucv_path_severed
+ * iucv_path_severed - Process connection severed work item.
+ *
  * @data: Pointer to external interrupt buffer
  *
- * Process connection severed work item. Called from tasklet while holding
- * iucv_table_lock.
+ * Context: Called from tasklet while holding iucv_table_lock.
  */
 static void iucv_path_severed(struct iucv_irq_data *data)
 {
@@ -1589,11 +1582,11 @@ struct iucv_path_quiesced {
 } __packed;
 
 /**
- * iucv_path_quiesced
+ * iucv_path_quiesced -Process connection quiesced work item.
+ *
  * @data: Pointer to external interrupt buffer
  *
- * Process connection quiesced work item. Called from tasklet while holding
- * iucv_table_lock.
+ * Context: Called from tasklet while holding iucv_table_lock.
  */
 static void iucv_path_quiesced(struct iucv_irq_data *data)
 {
@@ -1617,11 +1610,11 @@ struct iucv_path_resumed {
 } __packed;
 
 /**
- * iucv_path_resumed
+ * iucv_path_resumed - Process connection resumed work item.
+ *
  * @data: Pointer to external interrupt buffer
  *
- * Process connection resumed work item. Called from tasklet while holding
- * iucv_table_lock.
+ * Context: Called from tasklet while holding iucv_table_lock.
  */
 static void iucv_path_resumed(struct iucv_irq_data *data)
 {
@@ -1648,11 +1641,11 @@ struct iucv_message_complete {
 } __packed;
 
 /**
- * iucv_message_complete
+ * iucv_message_complete - Process message complete work item.
+ *
  * @data: Pointer to external interrupt buffer
  *
- * Process message complete work item. Called from tasklet while holding
- * iucv_table_lock.
+ * Context: Called from tasklet while holding iucv_table_lock.
  */
 static void iucv_message_complete(struct iucv_irq_data *data)
 {
@@ -1695,11 +1688,11 @@ struct iucv_message_pending {
 } __packed;
 
 /**
- * iucv_message_pending
+ * iucv_message_pending - Process message pending work item.
+ *
  * @data: Pointer to external interrupt buffer
  *
- * Process message pending work item. Called from tasklet while holding
- * iucv_table_lock.
+ * Context: Called from tasklet while holding iucv_table_lock.
  */
 static void iucv_message_pending(struct iucv_irq_data *data)
 {
@@ -1722,7 +1715,7 @@ static void iucv_message_pending(struct
 }
 
 /*
- * iucv_tasklet_fn:
+ * iucv_tasklet_fn - Process the queue of IRQ buffers
  *
  * This tasklet loops over the queue of irq buffers created by
  * iucv_external_interrupt, calls the appropriate action handler
@@ -1766,7 +1759,7 @@ static void iucv_tasklet_fn(unsigned lon
 }
 
 /*
- * iucv_work_fn:
+ * iucv_work_fn - Process the queue of path pending IRQ blocks
  *
  * This work function loops over the queue of path pending irq blocks
  * created by iucv_external_interrupt, calls the appropriate action
@@ -1797,9 +1790,8 @@ static void iucv_work_fn(struct work_str
 }
 
 /*
- * iucv_external_interrupt
+ * iucv_external_interrupt - Handles external interrupts coming in from CP.
  *
- * Handles external interrupts coming in from CP.
  * Places the interrupt buffer on a queue and schedules iucv_tasklet_fn().
  */
 static void iucv_external_interrupt(struct ext_code ext_code,
@@ -1857,10 +1849,9 @@ struct iucv_interface iucv_if = {
 EXPORT_SYMBOL(iucv_if);
 
 static enum cpuhp_state iucv_online;
+
 /**
- * iucv_init
- *
- * Allocates and initializes various data structures.
+ * iucv_init - Allocates and initializes various data structures.
  */
 static int __init iucv_init(void)
 {
@@ -1924,9 +1915,7 @@ out:
 }
 
 /**
- * iucv_exit
- *
- * Frees everything allocated from iucv_init.
+ * iucv_exit - Frees everything allocated from iucv_init.
  */
 static void __exit iucv_exit(void)
 {
