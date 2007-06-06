Return-Path: <linux-kernel-owner+w=401wt.eu-S936132AbXFFVdy@vger.kernel.org>
Subject: [RFC] [Patch 1/4] statistics: no include hell for users
From: Martin Peschke <mp3@de.ibm.com>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 23:33:29 +0200
Message-Id: <1181165609.7133.20.camel@dix>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: a.p.zijlstra@chello.nl, jbaron@redhat.com, rostedt@goodmis.org, billh@gnuppy.monkey.org, mingo@elte.hu, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Cleaning up inclusion of header files. Don't want to create
an include hell for users.

Maintain void pointers instead of dentry pointers for debugfs files.
We never poke inside those dentries anyway. We just keep them in order
to pass them back as a kind of handle to debugfs on cleanup.

Getting rid of seq_file as parameter to the label-function.
Now we just pass a buffer to the label-function.

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 include/linux/statistic.h |   11 ++++-------
 lib/statistic.c           |   23 +++++++++++++++++++----
 2 files changed, 23 insertions(+), 11 deletions(-)

Index: linux/include/linux/statistic.h
===================================================================
--- linux.orig/include/linux/statistic.h
+++ linux/include/linux/statistic.h
@@ -23,9 +23,7 @@
 #ifndef STATISTIC_H
 #define STATISTIC_H
 
-#include <linux/fs.h>
 #include <linux/types.h>
-#include <linux/percpu.h>
 
 /**
  * struct statistic_info - description of a class of statistics
@@ -124,17 +122,16 @@ struct statistic {
 struct statistic_interface {
 /* private: */
 	struct list_head	 list;
-	struct dentry		*debugfs_dir;
-	struct dentry		*data_file;
-	struct dentry		*def_file;
+	void			*debugfs_dir;
+	void			*data_file;
+	void			*def_file;
 /* public: */
 	struct statistic	*stat;
 	struct statistic_info	*info;
 	int			 number;
 	int			(*pull)(struct statistic_interface *interface);
 	void			(*label)(struct statistic_interface *interface,
-					 int i, void *key,
-					 struct seq_file *seq);
+					 int i, void *key, char *buf, int size);
 	void			*private;
 };
 
Index: linux/lib/statistic.c
===================================================================
--- linux.orig/lib/statistic.c
+++ linux/lib/statistic.c
@@ -483,6 +483,23 @@ static void statistic_parse_line(struct 
 
 /* sequential files comprising user interface */
 
+#define STATISTIC_LABEL_SIZE	128
+static void statistic_label(struct statistic_interface *interface, int i,
+			    void *key, struct seq_file *seq)
+{
+	struct statistic_info *info = &interface->info[i];
+	char *buf;
+
+	if (!(info->flags & STATISTIC_FLAGS_LABEL))
+		return;
+	buf = kzalloc(STATISTIC_LABEL_SIZE, GFP_ATOMIC);
+	if (!buf)
+		return;
+	interface->label(interface, i, key, buf, STATISTIC_LABEL_SIZE - 1);
+	seq_printf(seq, "%s", buf);
+	kfree(buf);
+}
+
 struct statistic_seq_private {
 	struct statistic_interface *interface;
 	int i;
@@ -995,8 +1012,7 @@ static void _statistic_data_histogram(st
 				      int i)
 {
 	seq_printf(seq, "%s %s%Ld %Lu ", info->name, prefix, bound, hits);
-	if (info->flags & STATISTIC_FLAGS_LABEL)
-		interface->label(interface, i, &bound, seq);
+	statistic_label(interface, i, &bound, seq);
 	seq_printf(seq, "\n");
 }
 
@@ -1218,8 +1234,7 @@ static void statistic_data_sparse(struct
 			seq_printf(seq, "0x%Lx ",
 				   *(signed long long *)entry->key);
 		seq_printf(seq, "%Lu ", (unsigned long long)entry->hits);
-		if (info->flags & STATISTIC_FLAGS_LABEL)
-			interface->label(interface, i, entry->key, seq);
+		statistic_label(interface, i, entry->key, seq);
 		seq_printf(seq, "\n");
 	}
 }
