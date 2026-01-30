Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BA62EBBB9;
	Fri, 30 Jan 2026 05:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769752084; cv=none; b=WPi981gA86xwDaL7fah5kQg91p/LWVdRazIHaGcoKorf6ejyReaL7EwoJYDWCT/YtY4MJ0bDmvGZfSUPOuhL8O6Luf25QZBjgrfAzvxML3nZmvlORFTsNtoOhvni6otGZRMc4b1In0RXY+2+GRuat/qihsza37xpT9aGxP2Tw0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769752084; c=relaxed/simple;
	bh=Lhccew2SwapeRY9mMq3M7jhI3jE4UnFih+gogwzX4Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HrOkz0s3DzPxoAqf31jHirpb7uh26AhCZHdqvGXcZb5gli7O5/8gxCfYjoOpipxR+qiiqzfoSHXSPHR9yi5WGrockJEt6kcQnfimtyZUeYCX8axRboZNFRweIdlD4lKUg6+iGMjyIM2/K23IHho8luqx17hLuk6m5RZOsan+A2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bUsr+oCp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bUsr+oCp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=6ZmSC00KrPI+OiUbaGcl5aD3dIGhnovACrjYKocu8RM=; b=bUsr+oCp7dhtV/J4G9E4X8YLzE
	a4Z7Cf0Usu+50u+A7MY1sUVATpJPXP10APVvXJJHaRgflS5N+BmBg5qVw51XIDiXT0Fzj94ppMm6m
	VmtGB1cAVQBe6w61i9GbwUSLTXLX9hZu6+QWYl9FbT6VVXPAz7E4hH0ZE5qV55DTsBUiilm3d5kvm
	8VcH+8sy4YWRj17y5B3i2uhnOCeegm48yaMm5IvcJHhvf+bwfJsvSV00ZgJOYRBR55GJwdCCN5oJA
	X8Y4J7oT6LNtzH/oUExttMst8eVF9VMVJGfNQGVGCPhsZIfNAsqfASdSA1zV80JpK6iAzzUj11mZo
	3e0wVibQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlhMP-000000014YN-1Gyn;
	Fri, 30 Jan 2026 05:48:01 +0000
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
Subject: [PATCH net-next] net/iucv: clean up iucv kernel-doc warnings
Date: Thu, 29 Jan 2026 21:47:59 -0800
Message-ID: <20260130054759.1301608-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix numerous (many) kernel-doc warnings in iucv.[ch]:

- remove kernel-doc on static functions in iucv.c
- convert function documentation comments to a common (kernel-doc) look,
  even for static functions (without "/**")
- use matching parameter and parameter description names

Examples:

Warning: include/net/iucv/iucv.h:210 missing initial short description
 on line: * iucv_unregister
Warning: include/net/iucv/iucv.h:216 function parameter 'handle' not
 described in 'iucv_unregister'
Warning: include/net/iucv/iucv.h:467 function parameter 'answer' not
 described in 'iucv_message_send2way'
Warning: net/iucv/iucv.c:727 missing initial short description on line:
 * iucv_cleanup_queue

Build-tested with both "make htmldocs" and make ARCH=s390 defconfig all".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Alexandra Winter <wintera@linux.ibm.com>
Cc: Thorsten Winkler <twinkler@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>

 include/net/iucv/iucv.h |   54 +++------
 net/iucv/iucv.c         |  223 +++++++++++++++++---------------------
 2 files changed, 127 insertions(+), 150 deletions(-)

--- linux-next-20260128.orig/include/net/iucv/iucv.h
+++ linux-next-20260128/include/net/iucv/iucv.h
@@ -70,7 +70,7 @@
 #define IUCV_IPLOCAL	0x01
 
 /*
- * iucv_array : Defines buffer array.
+ * iucv_array - Defines buffer array.
  * Inside the array may be 31- bit addresses and 31-bit lengths.
  * Use a pointer to an iucv_array as the buffer, reply or answer
  * parameter on iucv_message_send, iucv_message_send2way, iucv_message_receive
@@ -196,34 +196,29 @@ struct iucv_handler {
 };
 
 /**
- * iucv_register:
+ * iucv_register - Registers a driver with IUCV.
  * @handler: address of iucv handler structure
  * @smp: != 0 indicates that the handler can deal with out of order messages
  *
- * Registers a driver with IUCV.
- *
  * Returns: 0 on success, -ENOMEM if the memory allocation for the pathid
  * table failed, or -EIO if IUCV_DECLARE_BUFFER failed on all cpus.
  */
 int iucv_register(struct iucv_handler *handler, int smp);
 
 /**
- * iucv_unregister
+ * iucv_unregister - Unregister driver from IUCV.
  * @handler:  address of iucv handler structure
  * @smp: != 0 indicates that the handler can deal with out of order messages
  *
- * Unregister driver from IUCV.
  */
-void iucv_unregister(struct iucv_handler *handle, int smp);
+void iucv_unregister(struct iucv_handler *handler, int smp);
 
 /**
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
@@ -240,10 +235,8 @@ static inline struct iucv_path *iucv_pat
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
@@ -251,7 +244,7 @@ static inline void iucv_path_free(struct
 }
 
 /**
- * iucv_path_accept
+ * iucv_path_accept - Complete the IUCV communication path
  * @path: address of iucv path structure
  * @handler: address of iucv handler structure
  * @userdata: 16 bytes of data reflected to the communication partner
@@ -266,7 +259,7 @@ int iucv_path_accept(struct iucv_path *p
 		     u8 *userdata, void *private);
 
 /**
- * iucv_path_connect
+ * iucv_path_connect - Establish an IUCV path
  * @path: address of iucv path structure
  * @handler: address of iucv handler structure
  * @userid: 8-byte user identification
@@ -285,7 +278,7 @@ int iucv_path_connect(struct iucv_path *
 		      void *private);
 
 /**
- * iucv_path_quiesce:
+ * iucv_path_quiesce - Temporarily suspend incoming messages
  * @path: address of iucv path structure
  * @userdata: 16 bytes of data reflected to the communication partner
  *
@@ -297,7 +290,7 @@ int iucv_path_connect(struct iucv_path *
 int iucv_path_quiesce(struct iucv_path *path, u8 *userdata);
 
 /**
- * iucv_path_resume:
+ * iucv_path_resume - Resume incoming messages on a suspended IUCV path
  * @path: address of iucv path structure
  * @userdata: 16 bytes of data reflected to the communication partner
  *
@@ -309,31 +302,27 @@ int iucv_path_quiesce(struct iucv_path *
 int iucv_path_resume(struct iucv_path *path, u8 *userdata);
 
 /**
- * iucv_path_sever
+ * iucv_path_sever - Terminates an IUCV path.
  * @path: address of iucv path structure
  * @userdata: 16 bytes of data reflected to the communication partner
  *
- * This function terminates an IUCV path.
- *
  * Returns: the result from the CP IUCV call.
  */
 int iucv_path_sever(struct iucv_path *path, u8 *userdata);
 
 /**
- * iucv_message_purge
+ * iucv_message_purge - Cancels a message you have sent.
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
  * @srccls: source class of message
  *
- * Cancels a message you have sent.
- *
  * Returns: the result from the CP IUCV call.
  */
 int iucv_message_purge(struct iucv_path *path, struct iucv_message *msg,
 		       u32 srccls);
 
 /**
- * iucv_message_receive
+ * iucv_message_receive - Receives messages on an established path, with locking
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
  * @flags: flags that affect how the message is received (IUCV_IPBUFLST)
@@ -353,7 +342,7 @@ int iucv_message_receive(struct iucv_pat
 			 u8 flags, void *buffer, size_t size, size_t *residual);
 
 /**
- * __iucv_message_receive
+ * __iucv_message_receive - Terminates an IUCV path.
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
  * @flags: flags that affect how the message is received (IUCV_IPBUFLST)
@@ -374,7 +363,7 @@ int __iucv_message_receive(struct iucv_p
 			   size_t *residual);
 
 /**
- * iucv_message_reject
+ * iucv_message_reject - Refuses a specified message
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
  *
@@ -387,7 +376,7 @@ int __iucv_message_receive(struct iucv_p
 int iucv_message_reject(struct iucv_path *path, struct iucv_message *msg);
 
 /**
- * iucv_message_reply
+ * iucv_message_reply - Refuses a specified message
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
  * @flags: how the reply is sent (IUCV_IPRMDATA, IUCV_IPPRTY, IUCV_IPBUFLST)
@@ -395,7 +384,7 @@ int iucv_message_reject(struct iucv_path
  * @size: length of reply data buffer
  *
  * This function responds to the two-way messages that you receive. You
- * must identify completely the message to which you wish to reply. ie,
+ * must identify completely the message to which you wish to reply. I.e.,
  * pathid, msgid, and trgcls. Prmmsg signifies the data is moved into
  * the parameter list.
  *
@@ -405,7 +394,7 @@ int iucv_message_reply(struct iucv_path
 		       u8 flags, void *reply, size_t size);
 
 /**
- * iucv_message_send
+ * iucv_message_send - Transmits a one-way message, with locking
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
  * @flags: how the message is sent (IUCV_IPRMDATA, IUCV_IPPRTY, IUCV_IPBUFLST)
@@ -425,7 +414,7 @@ int iucv_message_send(struct iucv_path *
 		      u8 flags, u32 srccls, void *buffer, size_t size);
 
 /**
- * __iucv_message_send
+ * __iucv_message_send - Transmits a one-way message, no locking
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
  * @flags: how the message is sent (IUCV_IPRMDATA, IUCV_IPPRTY, IUCV_IPBUFLST)
@@ -445,7 +434,7 @@ int __iucv_message_send(struct iucv_path
 			u8 flags, u32 srccls, void *buffer, size_t size);
 
 /**
- * iucv_message_send2way
+ * iucv_message_send2way - Transmits a two-way message
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
  * @flags: how the message is sent and the reply is received
@@ -453,8 +442,9 @@ int __iucv_message_send(struct iucv_path
  * @srccls: source class of message
  * @buffer: address of data buffer or address of struct iucv_array
  * @size: length of send buffer
- * @ansbuf: address of answer buffer or address of struct iucv_array
+ * @answer: address of answer buffer or address of struct iucv_array
  * @asize: size of reply buffer
+ * @residual: ignored
  *
  * This function transmits data to another application. Data to be
  * transmitted is in a buffer. The receiver of the send is expected to
--- linux-next-20260128.orig/net/iucv/iucv.c
+++ linux-next-20260128/net/iucv/iucv.c
@@ -312,13 +312,12 @@ union iucv_param {
 static union iucv_param *iucv_param[NR_CPUS];
 static union iucv_param *iucv_param_irq[NR_CPUS];
 
-/**
- * __iucv_call_b2f0
+/*
+ * __iucv_call_b2f0 - Calls CP to execute IUCV commands.
+ *
  * @command: identifier of IUCV call to CP.
  * @parm: pointer to a struct iucv_parm block
  *
- * Calls CP to execute IUCV commands.
- *
  * Returns the result of the CP IUCV call.
  */
 static inline int __iucv_call_b2f0(int command, union iucv_param *parm)
@@ -348,9 +347,8 @@ static inline int iucv_call_b2f0(int com
 }
 
 /*
- * iucv_query_maxconn
- *
- * Determines the maximum number of connections that may be established.
+ * iucv_query_maxconn - Determine the maximum number of connections that
+ * may be established.
  *
  * Returns the maximum number of connections or -EPERM is IUCV is not
  * available.
@@ -390,11 +388,10 @@ static int iucv_query_maxconn(void)
 	return ccode ? -EPERM : 0;
 }
 
-/**
- * iucv_allow_cpu
- * @data: unused
+/*
+ * iucv_allow_cpu - Allow iucv interrupts on this cpu.
  *
- * Allow iucv interrupts on this cpu.
+ * @data: unused
  */
 static void iucv_allow_cpu(void *data)
 {
@@ -431,11 +428,10 @@ static void iucv_allow_cpu(void *data)
 	cpumask_set_cpu(cpu, &iucv_irq_cpumask);
 }
 
-/**
- * iucv_block_cpu
- * @data: unused
+/*
+ * iucv_block_cpu - Block iucv interrupts on this cpu.
  *
- * Block iucv interrupts on this cpu.
+ * @data: unused
  */
 static void iucv_block_cpu(void *data)
 {
@@ -451,11 +447,10 @@ static void iucv_block_cpu(void *data)
 	cpumask_clear_cpu(cpu, &iucv_irq_cpumask);
 }
 
-/**
- * iucv_declare_cpu
- * @data: unused
+/*
+ * iucv_declare_cpu - Declare a interrupt buffer on this cpu.
  *
- * Declare a interrupt buffer on this cpu.
+ * @data: unused
  */
 static void iucv_declare_cpu(void *data)
 {
@@ -506,11 +501,10 @@ static void iucv_declare_cpu(void *data)
 		iucv_block_cpu(NULL);
 }
 
-/**
- * iucv_retrieve_cpu
- * @data: unused
+/*
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
@@ -694,12 +682,11 @@ __free_cpumask:
 	return ret;
 }
 
-/**
- * iucv_sever_pathid
+/*
+ * iucv_sever_pathid - Sever an iucv path to free up the pathid. Used internally.
+ *
  * @pathid: path identification number.
  * @userdata: 16-bytes of user data.
- *
- * Sever an iucv path to free up the pathid. Used internally.
  */
 static int iucv_sever_pathid(u16 pathid, u8 *userdata)
 {
@@ -713,23 +700,21 @@ static int iucv_sever_pathid(u16 pathid,
 	return iucv_call_b2f0(IUCV_SEVER, parm);
 }
 
-/**
- * __iucv_cleanup_queue
- * @dummy: unused dummy argument
+/*
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
 
-/**
- * iucv_cleanup_queue
+/*
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
@@ -757,12 +742,11 @@ static void iucv_cleanup_queue(void)
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
  * Returns 0 on success, -ENOMEM if the memory allocation for the pathid
  * table failed, or -EIO if IUCV_DECLARE_BUFFER failed on all cpus.
  */
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
@@ -896,7 +880,8 @@ out:
 EXPORT_SYMBOL(iucv_path_accept);
 
 /**
- * iucv_path_connect
+ * iucv_path_connect - Establish an IUCV path
+ *
  * @path: address of iucv path structure
  * @handler: address of iucv handler structure
  * @userid: 8-byte user identification
@@ -964,7 +949,7 @@ out:
 EXPORT_SYMBOL(iucv_path_connect);
 
 /**
- * iucv_path_quiesce:
+ * iucv_path_quiesce - Temporarily suspend incoming messages
  * @path: address of iucv path structure
  * @userdata: 16 bytes of data reflected to the communication partner
  *
@@ -996,7 +981,8 @@ out:
 EXPORT_SYMBOL(iucv_path_quiesce);
 
 /**
- * iucv_path_resume:
+ * iucv_path_resume - Resume incoming messages on a suspended IUCV path
+ *
  * @path: address of iucv path structure
  * @userdata: 16 bytes of data reflected to the communication partner
  *
@@ -1027,12 +1013,11 @@ out:
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
  * Returns the result from the CP IUCV call.
  */
 int iucv_path_sever(struct iucv_path *path, u8 *userdata)
@@ -1058,13 +1043,11 @@ out:
 EXPORT_SYMBOL(iucv_path_sever);
 
 /**
- * iucv_message_purge
+ * iucv_message_purge - Cancels a message you have sent.
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
  * @srccls: source class of message
  *
- * Cancels a message you have sent.
- *
  * Returns the result from the CP IUCV call.
  */
 int iucv_message_purge(struct iucv_path *path, struct iucv_message *msg,
@@ -1095,14 +1078,16 @@ out:
 }
 EXPORT_SYMBOL(iucv_message_purge);
 
-/**
- * iucv_message_receive_iprmdata
+/*
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
@@ -1140,7 +1125,8 @@ static int iucv_message_receive_iprmdata
 }
 
 /**
- * __iucv_message_receive
+ * __iucv_message_receive - Terminates an IUCV path.
+ *
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
  * @flags: how the message is received (IUCV_IPBUFLST)
@@ -1188,7 +1174,8 @@ int __iucv_message_receive(struct iucv_p
 EXPORT_SYMBOL(__iucv_message_receive);
 
 /**
- * iucv_message_receive
+ * iucv_message_receive - Receives messages on an established path, with locking
+ *
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
  * @flags: how the message is received (IUCV_IPBUFLST)
@@ -1220,7 +1207,8 @@ int iucv_message_receive(struct iucv_pat
 EXPORT_SYMBOL(iucv_message_receive);
 
 /**
- * iucv_message_reject
+ * iucv_message_reject - Refuses a specified message
+ *
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
  *
@@ -1254,7 +1242,8 @@ out:
 EXPORT_SYMBOL(iucv_message_reject);
 
 /**
- * iucv_message_reply
+ * iucv_message_reply - Refuses a specified message
+ *
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
  * @flags: how the reply is sent (IUCV_IPRMDATA, IUCV_IPPRTY, IUCV_IPBUFLST)
@@ -1303,7 +1292,8 @@ out:
 EXPORT_SYMBOL(iucv_message_reply);
 
 /**
- * __iucv_message_send
+ * __iucv_message_send - Transmits a one-way message, no locking
+ *
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
  * @flags: how the message is sent (IUCV_IPRMDATA, IUCV_IPPRTY, IUCV_IPBUFLST)
@@ -1357,7 +1347,8 @@ out:
 EXPORT_SYMBOL(__iucv_message_send);
 
 /**
- * iucv_message_send
+ * iucv_message_send - Transmits a one-way message, with locking
+ *
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
  * @flags: how the message is sent (IUCV_IPRMDATA, IUCV_IPPRTY, IUCV_IPBUFLST)
@@ -1386,7 +1377,7 @@ int iucv_message_send(struct iucv_path *
 EXPORT_SYMBOL(iucv_message_send);
 
 /**
- * iucv_message_send2way
+ * iucv_message_send2way - Transmits a two-way message
  * @path: address of iucv path structure
  * @msg: address of iucv msg structure
  * @flags: how the message is sent and the reply is received
@@ -1461,12 +1452,12 @@ struct iucv_path_pending {
 	u8  res4[3];
 } __packed;
 
-/**
- * iucv_path_pending
+/*
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
@@ -1522,12 +1513,12 @@ struct iucv_path_complete {
 	u8  res4[3];
 } __packed;
 
-/**
- * iucv_path_complete
+/*
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
@@ -1552,12 +1543,12 @@ struct iucv_path_severed {
 	u8  res5[3];
 } __packed;
 
-/**
- * iucv_path_severed
+/*
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
@@ -1588,12 +1579,12 @@ struct iucv_path_quiesced {
 	u8  res5[3];
 } __packed;
 
-/**
- * iucv_path_quiesced
+/*
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
@@ -1616,12 +1607,12 @@ struct iucv_path_resumed {
 	u8  res5[3];
 } __packed;
 
-/**
- * iucv_path_resumed
+/*
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
@@ -1647,12 +1638,12 @@ struct iucv_message_complete {
 	u8  res2[3];
 } __packed;
 
-/**
- * iucv_message_complete
+/*
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
@@ -1694,12 +1685,12 @@ struct iucv_message_pending {
 	u8  res2[3];
 } __packed;
 
-/**
- * iucv_message_pending
+/*
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
@@ -1722,7 +1713,7 @@ static void iucv_message_pending(struct
 }
 
 /*
- * iucv_tasklet_fn:
+ * iucv_tasklet_fn - Process the queue of IRQ buffers
  *
  * This tasklet loops over the queue of irq buffers created by
  * iucv_external_interrupt, calls the appropriate action handler
@@ -1766,7 +1757,7 @@ static void iucv_tasklet_fn(unsigned lon
 }
 
 /*
- * iucv_work_fn:
+ * iucv_work_fn - Process the queue of path pending IRQ blocks
  *
  * This work function loops over the queue of path pending irq blocks
  * created by iucv_external_interrupt, calls the appropriate action
@@ -1797,9 +1788,8 @@ static void iucv_work_fn(struct work_str
 }
 
 /*
- * iucv_external_interrupt
+ * iucv_external_interrupt - Handles external interrupts coming in from CP.
  *
- * Handles external interrupts coming in from CP.
  * Places the interrupt buffer on a queue and schedules iucv_tasklet_fn().
  */
 static void iucv_external_interrupt(struct ext_code ext_code,
@@ -1857,10 +1847,9 @@ struct iucv_interface iucv_if = {
 EXPORT_SYMBOL(iucv_if);
 
 static enum cpuhp_state iucv_online;
-/**
- * iucv_init
- *
- * Allocates and initializes various data structures.
+
+/*
+ * iucv_init - Allocates and initializes various data structures.
  */
 static int __init iucv_init(void)
 {
@@ -1923,10 +1912,8 @@ out:
 	return rc;
 }
 
-/**
- * iucv_exit
- *
- * Frees everything allocated from iucv_init.
+/*
+ * iucv_exit - Frees everything allocated from iucv_init.
  */
 static void __exit iucv_exit(void)
 {
