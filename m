Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726678AbfGCKVV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 3 Jul 2019 06:21:21 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x63ALAwf032404
        for <linux-s390@vger.kernel.org>; Wed, 3 Jul 2019 06:21:19 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tgsu020sb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 03 Jul 2019 06:21:14 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <maier@linux.ibm.com>;
        Wed, 3 Jul 2019 11:20:18 +0100
From: Steffen Maier <maier@linux.ibm.com>
Subject: [PATCH 2/3] docs: s390: unify and update s390dbf kdocs at debug.c
Date: Wed,  3 Jul 2019 12:19:48 +0200
In-Reply-To: <1562149189-1417-1-git-send-email-maier@linux.ibm.com>
References: <1562149189-1417-1-git-send-email-maier@linux.ibm.com>
Message-Id: <1562149189-1417-3-git-send-email-maier@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-doc@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org

For non-static-inlines, debug.c already had non-compliant function
header docs. So move the pure prototype kdocs of
("s390: include/asm/debug.h add kerneldoc markups")
from debug.h to debug.c and merge them with the old function docs.
Also, I had the impression that kdoc typically is at the implementation
in the compile unit rather than at the prototype in the header file.

While at it, update the short kdoc description to distinguish the
different functions. And a few more consistency cleanups.

Added a new kdoc for debug_set_critical() since debug.h comments it
as part of the API.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 Documentation/s390/s390dbf.rst |   1 +
 arch/s390/include/asm/debug.h  | 112 ++++++-----------------------------------
 arch/s390/kernel/debug.c       | 105 +++++++++++++++++++++++++++++++-------
 3 files changed, 102 insertions(+), 116 deletions(-)

diff --git a/Documentation/s390/s390dbf.rst b/Documentation/s390/s390dbf.rst
index 01d66251643d..be42892b159e 100644
--- a/Documentation/s390/s390dbf.rst
+++ b/Documentation/s390/s390dbf.rst
@@ -107,6 +107,7 @@ will stay deactivated.
 Kernel Interfaces:
 ------------------
 
+.. kernel-doc:: arch/s390/kernel/debug.c
 .. kernel-doc:: arch/s390/include/asm/debug.h
 
 Predefined views:
diff --git a/arch/s390/include/asm/debug.h b/arch/s390/include/asm/debug.h
index 02c36eedd780..310134015541 100644
--- a/arch/s390/include/asm/debug.h
+++ b/arch/s390/include/asm/debug.h
@@ -95,77 +95,19 @@ debug_entry_t *debug_exception_common(debug_info_t *id, int level,
 
 /* Debug Feature API: */
 
-/**
- * debug_register() - allocates memory for a debug log.
- *
- * @name:        Name of debug log (e.g. used for debugfs entry)
- * @pages:       Number of pages, which will be allocated per area
- * @nr_areas:    Number of debug areas
- * @buf_size:    Size of data area in each debug entry
- *
- * Return:
- * - Handler for generated debug area
- * - %NULL if register failed
- *
- * Must not be called within an interrupt handler.
- */
 debug_info_t *debug_register(const char *name, int pages, int nr_areas,
 			     int buf_size);
 
-/**
- * debug_register_mode() - allocates memory for a debug log.
- *
- * @name:	Name of debug log (e.g. used for debugfs entry)
- * @pages:	Number of pages, which will be allocated per area
- * @nr_areas:	Number of debug areas
- * @buf_size:	Size of data area in each debug entry
- * @mode:	File mode for debugfs files. E.g. S_IRWXUGO
- * @uid:	User ID for debugfs files. Currently only 0 is supported.
- * @gid:	Group ID for debugfs files. Currently only 0 is supported.
- *
- * Return:
- * - Handler for generated debug area
- * - %NULL if register failed
- *
- * Must not be called within an interrupt handler
- */
 debug_info_t *debug_register_mode(const char *name, int pages, int nr_areas,
 				  int buf_size, umode_t mode, uid_t uid,
 				  gid_t gid);
 
-/**
- * debug_unregister() - frees memory for a debug log and removes all
- *			registered debug
- * views.
- *
- * @id:		handle for debug log
- *
- * Return:
- *    none
- *
- * Must not be called within an interrupt handler
- */
 void debug_unregister(debug_info_t *id);
 
-/**
- * debug_set_level() -  Sets new actual debug level if new_level is valid.
- *
- * @id:		handle for debug log
- * @new_level:	new debug level
- *
- * Return:
- *    none
- */
 void debug_set_level(debug_info_t *id, int new_level);
 
 void debug_set_critical(void);
 
-/**
- * debug_stop_all() - stops the debug feature if stopping is allowed.
- *
- * Return:
- * -   none
- */
 void debug_stop_all(void);
 
 /**
@@ -184,7 +126,7 @@ static inline bool debug_level_enabled(debug_info_t *id, int level)
 }
 
 /**
- * debug_event() - writes debug entry to active debug area
+ * debug_event() - writes binary debug entry to active debug area
  *		   (if level <= actual debug level)
  *
  * @id:		handle for debug log
@@ -194,6 +136,7 @@ static inline bool debug_level_enabled(debug_info_t *id, int level)
  *
  * Return:
  * - Address of written debug entry
+ * - %NULL if error
  */
 static inline debug_entry_t *debug_event(debug_info_t *id, int level,
 					 void *data, int length)
@@ -204,7 +147,7 @@ static inline debug_entry_t *debug_event(debug_info_t *id, int level,
 }
 
 /**
- * debug_int_event() - writes debug entry to active debug area
+ * debug_int_event() - writes unsigned integer debug entry to active debug area
  *		       (if level <= actual debug level)
  *
  * @id:		handle for debug log
@@ -226,12 +169,12 @@ static inline debug_entry_t *debug_int_event(debug_info_t *id, int level,
 }
 
 /**
- * debug_long_event() - writes debug entry to active debug area
+ * debug_long_event() - writes unsigned long debug entry to active debug area
  *		       (if level <= actual debug level)
  *
  * @id:		handle for debug log
  * @level:	debug level
- * @tag:	integer value for debug entry
+ * @tag:	long integer value for debug entry
  *
  * Return:
  * - Address of written debug entry
@@ -248,7 +191,7 @@ static inline debug_entry_t *debug_long_event(debug_info_t *id, int level,
 }
 
 /**
- * debug_text_event() - writes debug entry in ascii format to active
+ * debug_text_event() - writes string debug entry in ascii format to active
  *			debug area (if level <= actual debug level)
  *
  * @id:		handle for debug log
@@ -306,9 +249,9 @@ static inline debug_entry_t *debug_text_event(debug_info_t *id, int level,
 })
 
 /**
- * debug_exception() - writes debug entry to active debug area
- *		       (if level <= actual debug level) and switches
- *		       to next debug area
+ * debug_exception() - writes binary debug entry to active debug area
+ *		       (if level <= actual debug level)
+ *		       and switches to next debug area
  *
  * @id:		handle for debug log
  * @level:	debug level
@@ -328,7 +271,7 @@ static inline debug_entry_t *debug_exception(debug_info_t *id, int level,
 }
 
 /**
- * debug_int_exception() - writes debug entry to active debug area
+ * debug_int_exception() - writes unsigned int debug entry to active debug area
  *			   (if level <= actual debug level)
  *			   and switches to next debug area
  *
@@ -351,13 +294,13 @@ static inline debug_entry_t *debug_int_exception(debug_info_t *id, int level,
 }
 
 /**
- * debug_long_exception() - writes debug entry to active debug area
+ * debug_long_exception() - writes long debug entry to active debug area
  *			   (if level <= actual debug level)
  *			   and switches to next debug area
  *
  * @id:		handle for debug log
  * @level:	debug level
- * @tag:	integer value for debug entry
+ * @tag:	long integer value for debug entry
  *
  * Return:
  * - Address of written debug entry
@@ -374,9 +317,9 @@ static inline debug_entry_t *debug_long_exception (debug_info_t *id, int level,
 }
 
 /**
- * debug_text_exception() - writes debug entry in ascii format to active
+ * debug_text_exception() - writes string debug entry in ascii format to active
  *			    debug area (if level <= actual debug level)
- *			    and switches to next debug
+ *			    and switches to next debug area
  * area
  *
  * @id:	handle for debug log
@@ -407,7 +350,7 @@ static inline debug_entry_t *debug_text_exception(debug_info_t *id, int level,
 /**
  * debug_sprintf_exception() - writes debug entry with format string and
  *			       varargs (longs) to active debug area
- *			       (if level $<=$ actual debug level)
+ *			       (if level <= actual debug level)
  *			       and switches to next debug area.
  *
  * @_id:	handle for debug log
@@ -435,33 +378,8 @@ static inline debug_entry_t *debug_text_exception(debug_info_t *id, int level,
 	__ret;								\
 })
 
-/**
- * debug_register_view() - registers new debug view and creates debugfs
- *			   dir entry
- *
- * @id:	handle for debug log
- * @view:	pointer to debug view struct
- *
- * Return:
- * -   0  : ok
- * -   < 0: Error
- */
 int debug_register_view(debug_info_t *id, struct debug_view *view);
 
-/**
- * debug_unregister_view()
- *
- * @id:	handle for debug log
- * @view:	pointer to debug view struct
- *
- * Return:
- * -   0  : ok
- * -   < 0: Error
- *
- *
- * unregisters debug view and removes debugfs dir entry
- */
-
 int debug_unregister_view(debug_info_t *id, struct debug_view *view);
 
 /*
diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 0ebf08c3b35e..70a44bad625f 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -647,11 +647,23 @@ static int debug_close(struct inode *inode, struct file *file)
 	return 0; /* success */
 }
 
-/*
- * debug_register_mode:
- * - Creates and initializes debug area for the caller
- *   The mode parameter allows to specify access rights for the s390dbf files
- * - Returns handle for debug area
+/**
+ * debug_register_mode() - creates and initializes debug area.
+ *
+ * @name:	Name of debug log (e.g. used for debugfs entry)
+ * @pages_per_area:	Number of pages, which will be allocated per area
+ * @nr_areas:	Number of debug areas
+ * @buf_size:	Size of data area in each debug entry
+ * @mode:	File mode for debugfs files. E.g. S_IRWXUGO
+ * @uid:	User ID for debugfs files. Currently only 0 is supported.
+ * @gid:	Group ID for debugfs files. Currently only 0 is supported.
+ *
+ * Return:
+ * - Handle for generated debug area
+ * - %NULL if register failed
+ *
+ * Allocates memory for a debug log.
+ * Must not be called within an interrupt handler.
  */
 debug_info_t *debug_register_mode(const char *name, int pages_per_area,
 				  int nr_areas, int buf_size, umode_t mode,
@@ -681,10 +693,21 @@ debug_info_t *debug_register_mode(const char *name, int pages_per_area,
 }
 EXPORT_SYMBOL(debug_register_mode);
 
-/*
- * debug_register:
- * - creates and initializes debug area for the caller
- * - returns handle for debug area
+/**
+ * debug_register() - creates and initializes debug area with default file mode.
+ *
+ * @name:	Name of debug log (e.g. used for debugfs entry)
+ * @pages_per_area:	Number of pages, which will be allocated per area
+ * @nr_areas:	Number of debug areas
+ * @buf_size:	Size of data area in each debug entry
+ *
+ * Return:
+ * - Handle for generated debug area
+ * - %NULL if register failed
+ *
+ * Allocates memory for a debug log.
+ * The debugfs file mode access permisions are read and write for user.
+ * Must not be called within an interrupt handler.
  */
 debug_info_t *debug_register(const char *name, int pages_per_area,
 			     int nr_areas, int buf_size)
@@ -694,9 +717,13 @@ debug_info_t *debug_register(const char *name, int pages_per_area,
 }
 EXPORT_SYMBOL(debug_register);
 
-/*
- * debug_unregister:
- * - give back debug area
+/**
+ * debug_unregister() -  give back debug area.
+ *
+ * @id:		handle for debug log
+ *
+ * Return:
+ *    none
  */
 void debug_unregister(debug_info_t *id)
 {
@@ -745,9 +772,14 @@ static int debug_set_size(debug_info_t *id, int nr_areas, int pages_per_area)
 	return rc;
 }
 
-/*
- * debug_set_level:
- * - set actual debug level
+/**
+ * debug_set_level() -  Sets new actual debug level if new_level is valid.
+ *
+ * @id:		handle for debug log
+ * @new_level:	new debug level
+ *
+ * Return:
+ *    none
  */
 void debug_set_level(debug_info_t *id, int new_level)
 {
@@ -873,6 +905,14 @@ static int s390dbf_procactive(struct ctl_table *table, int write,
 
 static struct ctl_table_header *s390dbf_sysctl_header;
 
+/**
+ * debug_stop_all() - stops the debug feature if stopping is allowed.
+ *
+ * Return:
+ * -   none
+ *
+ * Currently used in case of a kernel oops.
+ */
 void debug_stop_all(void)
 {
 	if (debug_stoppable)
@@ -880,6 +920,17 @@ void debug_stop_all(void)
 }
 EXPORT_SYMBOL(debug_stop_all);
 
+/**
+ * debug_set_critical() - event/exception functions try lock instead of spin.
+ *
+ * Return:
+ * -   none
+ *
+ * Currently used in case of stopping all CPUs but the current one.
+ * Once in this state, functions to write a debug entry for an
+ * event or exception no longer spin on the debug area lock,
+ * but only try to get it and fail if they do not get the lock.
+ */
 void debug_set_critical(void)
 {
 	debug_critical = 1;
@@ -1036,8 +1087,16 @@ debug_entry_t *__debug_sprintf_exception(debug_info_t *id, int level, char *stri
 }
 EXPORT_SYMBOL(__debug_sprintf_exception);
 
-/*
- * debug_register_view:
+/**
+ * debug_register_view() - registers new debug view and creates debugfs
+ *			   dir entry
+ *
+ * @id:		handle for debug log
+ * @view:	pointer to debug view struct
+ *
+ * Return:
+ * -   0  : ok
+ * -   < 0: Error
  */
 int debug_register_view(debug_info_t *id, struct debug_view *view)
 {
@@ -1077,8 +1136,16 @@ int debug_register_view(debug_info_t *id, struct debug_view *view)
 }
 EXPORT_SYMBOL(debug_register_view);
 
-/*
- * debug_unregister_view:
+/**
+ * debug_unregister_view() - unregisters debug view and removes debugfs
+ *			     dir entry
+ *
+ * @id:		handle for debug log
+ * @view:	pointer to debug view struct
+ *
+ * Return:
+ * -   0  : ok
+ * -   < 0: Error
  */
 int debug_unregister_view(debug_info_t *id, struct debug_view *view)
 {
-- 
1.8.3.1
