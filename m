Return-Path: <linux-kernel-owner+w=401wt.eu-S935135AbXFFVeU@vger.kernel.org>
Subject: [RFC] [Patch 2/4] statistics: cleanups
From: Martin Peschke <mp3@de.ibm.com>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 23:33:37 +0200
Message-Id: <1181165617.7133.21.camel@dix>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: a.p.zijlstra@chello.nl, jbaron@redhat.com, rostedt@goodmis.org, billh@gnuppy.monkey.org, mingo@elte.hu, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Statistics code cleanups. Would not have been needed for the following
changes - just done along the way.

- make function void
- found more handy names for a few identifiers

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 drivers/s390/scsi/zfcp_def.h |    4
 include/linux/statistic.h    |   27 +++---
 lib/statistic.c              |  177 ++++++++++++++++++++-----------------------
 3 files changed, 100 insertions(+), 108 deletions(-)

Index: linux/include/linux/statistic.h
===================================================================
--- linux.orig/include/linux/statistic.h
+++ linux/include/linux/statistic.h
@@ -36,7 +36,7 @@
  *
  * Exploiters must setup an array of struct statistic_info for a
  * corresponding array of struct statistic, which are then pointed to
- * by struct statistic_interface.
+ * by struct statistic_ui.
  *
  * Struct statistic_info and all members and addressed strings must stay for
  * the lifetime of corresponding statistics created with statistic_create().
@@ -108,7 +108,7 @@ struct statistic {
 };
 
 /**
- * struct statistic_interface - collection of statistics for an entity
+ * struct statistic_ui - collection of statistics for an entity
  * @stat: a struct statistic array
  * @info: a struct statistic_info array describing the struct statistic array
  * @number: number of entries in both arrays
@@ -116,29 +116,29 @@ struct statistic {
  * @label: an optional function retrieving a label for each statistics entry
  * @private: optional data pointer reserved for use by clients
  *
- * Exploiters must setup a struct statistic_interface prior to calling
+ * Exploiters must setup a struct statistic_ui prior to calling
  * statistic_create().
  */
-struct statistic_interface {
+struct statistic_ui {
 /* private: */
 	struct list_head	 list;
-	void			*debugfs_dir;
-	void			*data_file;
-	void			*def_file;
+	void			*dir;
+	void			*data;
+	void			*def;
 /* public: */
 	struct statistic	*stat;
 	struct statistic_info	*info;
 	int			 number;
-	int			(*pull)(struct statistic_interface *interface);
-	void			(*label)(struct statistic_interface *interface,
+	void			(*pull)(struct statistic_ui *ui);
+	void			(*label)(struct statistic_ui *ui,
 					 int i, void *key, char *buf, int size);
 	void			*private;
 };
 
 #ifdef CONFIG_STATISTICS
 
-extern int statistic_create(struct statistic_interface *, const char *);
-extern int statistic_remove(struct statistic_interface *);
+extern int statistic_create(struct statistic_ui *, const char *);
+extern int statistic_remove(struct statistic_ui *);
 
 extern void statistic_set(struct statistic *, int, s64, u64);
 extern void statistic_set_key(struct statistic *, int, void *, u64);
@@ -313,13 +313,12 @@ static inline void statistic_add_as_key(
 #else /* !CONFIG_STATISTICS */
 /* These NOP functions unburden clients from handling !CONFIG_STATISTICS. */
 
-static inline int statistic_create(struct statistic_interface *interface,
-				   const char *name)
+static inline int statistic_create(struct statistic_ui *ui, const char *name)
 {
 	return 0;
 }
 
-static inline int statistic_remove(struct statistic_interface *interface)
+static inline int statistic_remove(struct statistic_ui *ui)
 {
 	return 0;
 }
Index: linux/lib/statistic.c
===================================================================
--- linux.orig/lib/statistic.c
+++ linux/lib/statistic.c
@@ -94,7 +94,7 @@ struct statistic_discipline {
 	void (*merge)(struct statistic *stat, void *dst, void *src);
 	void (*def)(struct statistic *stat, struct seq_file *seq);
 	void (*data)(struct statistic *stat, struct seq_file *seq,
-		     struct statistic_interface *interface, int i);
+		     struct statistic_ui *ui, int i);
 	void (*add)(struct statistic *stat, s64 value, u64 incr);
 	void (*set)(struct statistic *stat, s64 value, u64 total);
 	void (*kadd)(struct statistic *stat, void *key, u64 incr);
@@ -256,10 +256,10 @@ static void _statistic_merge(void *__mpr
 	spin_unlock(&mpriv->lock);
 }
 
-static void *statistic_merge(struct statistic_interface *interface, int i)
+static void *statistic_merge(struct statistic_ui *ui, int i)
 {
-	struct statistic *stat = &interface->stat[i];
-	struct statistic_info *info = &interface->info[i];
+	struct statistic *stat = &ui->stat[i];
+	struct statistic_info *info = &ui->info[i];
 	struct statistic_discipline *disc = &statistic_discs[stat->type];
 	struct statistic_merge_private mpriv;
 	size_t size = disc->size(stat);
@@ -280,11 +280,11 @@ static void *statistic_merge(struct stat
 
 /* cpu hotplug handling for per-cpu data */
 
-static int _statistic_hotcpu(struct statistic_interface *interface,
-			     int i, unsigned long action, int cpu)
+static int _statistic_hotcpu(struct statistic_ui *ui, int i,
+			     unsigned long action, int cpu)
 {
-	struct statistic *stat = &interface->stat[i];
-	struct statistic_info *info = &interface->info[i];
+	struct statistic *stat = &ui->stat[i];
+	struct statistic_info *info = &ui->info[i];
 	struct statistic_discipline *disc = &statistic_discs[stat->type];
 	void *src, *dst;
 	size_t size;
@@ -326,12 +326,12 @@ static int __cpuinit statistic_hotcpu(st
 				      unsigned long action, void *__cpu)
 {
 	int cpu = (unsigned long)__cpu, i, retval = NOTIFY_OK;
-	struct statistic_interface *interface;
+	struct statistic_ui *ui;
 
 	mutex_lock(&statistic_list_mutex);
-	list_for_each_entry(interface, &statistic_list, list)
-		for (i = 0; i < interface->number; i++) {
-			retval = _statistic_hotcpu(interface, i, action, cpu);
+	list_for_each_entry(ui, &statistic_list, list)
+		for (i = 0; i < ui->number; i++) {
+			retval = _statistic_hotcpu(ui, i, action, cpu);
 			if (retval == NOTIFY_BAD)
 				goto unlock;
 		}
@@ -433,15 +433,14 @@ static match_table_t statistic_match_com
 	{9999, NULL}
 };
 
-static void statistic_parse_line(struct statistic_interface *interface,
-				 char *def)
+static void statistic_parse_line(struct statistic_ui *ui, char *def)
 {
 	char *name = NULL;
 	substring_t args[MAX_OPT_ARGS], sub;
 	int token, reset = 0, defaults = 0, i;
 	int state = STATISTIC_STATE_INVALID;
-	struct statistic *stat = interface->stat;
-	struct statistic_info *info = interface->info;
+	struct statistic *stat = ui->stat;
+	struct statistic_info *info = ui->info;
 
 	if (unlikely(!def))
 		return;
@@ -466,7 +465,7 @@ static void statistic_parse_line(struct 
 			break;
 		}
 	}
-	for (i = 0; i < interface->number; i++, stat++, info++) {
+	for (i = 0; i < ui->number; i++, stat++, info++) {
 		if (!name || (name && !strcmp(name, info->name))) {
 			if (defaults)
 				statistic_parse_match(stat, info, NULL);
@@ -484,10 +483,10 @@ static void statistic_parse_line(struct 
 /* sequential files comprising user interface */
 
 #define STATISTIC_LABEL_SIZE	128
-static void statistic_label(struct statistic_interface *interface, int i,
-			    void *key, struct seq_file *seq)
+static void statistic_label(struct statistic_ui *ui, int i, void *key,
+			    struct seq_file *seq)
 {
-	struct statistic_info *info = &interface->info[i];
+	struct statistic_info *info = &ui->info[i];
 	char *buf;
 
 	if (!(info->flags & STATISTIC_FLAGS_LABEL))
@@ -495,13 +494,13 @@ static void statistic_label(struct stati
 	buf = kzalloc(STATISTIC_LABEL_SIZE, GFP_ATOMIC);
 	if (!buf)
 		return;
-	interface->label(interface, i, key, buf, STATISTIC_LABEL_SIZE - 1);
+	ui->label(ui, i, key, buf, STATISTIC_LABEL_SIZE - 1);
 	seq_printf(seq, "%s", buf);
 	kfree(buf);
 }
 
 struct statistic_seq_private {
-	struct statistic_interface *interface;
+	struct statistic_ui *ui;
 	int i;
 	size_t w_offset;
 	char *w_buf;
@@ -512,7 +511,7 @@ static void *statistic_seq_traverse(stru
 				    struct statistic_seq_private *seq_priv)
 {
 	*pos += inc;
-	if (*pos >= seq_priv->interface->number)
+	if (*pos >= seq_priv->ui->number)
 		return NULL;
 	seq_priv->i = *pos;
 	return seq_priv;
@@ -543,9 +542,9 @@ static char *statistic_state_strings[] =
 static int statistic_seq_show_def(struct seq_file *seq, void *_seq_priv)
 {
 	struct statistic_seq_private *seq_priv = _seq_priv;
-	struct statistic_interface *interface = seq_priv->interface;
-	struct statistic *stat = &interface->stat[seq_priv->i];
-	struct statistic_info *info = &interface->info[seq_priv->i];
+	struct statistic_ui *ui = seq_priv->ui;
+	struct statistic *stat = &ui->stat[seq_priv->i];
+	struct statistic_info *info = &ui->info[seq_priv->i];
 	struct statistic_discipline *disc = &statistic_discs[stat->type];
 	char t0[TIMESTAMP_SIZE], t1[TIMESTAMP_SIZE], t2[TIMESTAMP_SIZE];
 
@@ -584,7 +583,7 @@ static int statistic_seq_show_data(struc
 	struct statistic_discipline *disc = &statistic_discs[stat->type];
 
 	if (stat->state >= STATISTIC_STATE_OFF)
-		disc->data(stat, seq, seq_priv->interface, seq_priv->i);
+		disc->data(stat, seq, seq_priv->ui, seq_priv->i);
 	return 0;
 }
 
@@ -611,7 +610,7 @@ static int statistic_open_def(struct ino
 	seq_priv = kzalloc(sizeof(struct statistic_seq_private), GFP_KERNEL);
 	if (!seq_priv)
 		return -ENOMEM;
-	seq_priv->interface = inode->i_private;
+	seq_priv->ui = inode->i_private;
 	retval = seq_open(file, &statistic_seq_ops_def);
 	if (!retval) {
 		seq = file->private_data;
@@ -623,14 +622,14 @@ static int statistic_open_def(struct ino
 
 static int statistic_release_def(struct inode *inode, struct file *file)
 {
-	struct statistic_interface *interface = inode->i_private;
+	struct statistic_ui *ui = inode->i_private;
 	struct seq_file *seq = file->private_data;
 	struct statistic_seq_private *seq_priv = seq->private;
 	char *p, *q = seq_priv->w_buf;
 
 	if (seq_priv->w_buf) {
 		while ((p = strsep(&q, "\n")))
-			statistic_parse_line(interface, p);
+			statistic_parse_line(ui, p);
 		kfree(seq_priv->w_buf);
 	}
 	return seq_release_private(inode, file);
@@ -674,31 +673,31 @@ static struct file_operations statistic_
 
 static int statistic_open_data(struct inode *inode, struct file *file)
 {
-	struct statistic_interface *interface = inode->i_private;
+	struct statistic_ui *ui = inode->i_private;
 	struct statistic *stat;
 	struct statistic_discipline *disc;
 	struct statistic_seq_private *seq_priv;
 	struct seq_file *seq;
 	int size, i, j, retval = -ENOMEM;
 
-	if (interface->pull)
-		interface->pull(interface);
+	if (ui->pull)
+		ui->pull(ui);
 
-	size = interface->number * sizeof(struct statistic);
+	size = ui->number * sizeof(struct statistic);
 	seq_priv = kzalloc(sizeof(struct statistic_seq_private), GFP_KERNEL);
 	if (!seq_priv)
 		goto failed_priv;
 
-	seq_priv->interface = interface;
+	seq_priv->ui = ui;
 	seq_priv->stat = stat = kmalloc(size, GFP_KERNEL);
 	if (!stat)
 		goto failed_stat;
 
-	memcpy(stat, interface->stat, size);
-	for (i = 0; i < interface->number; i++) {
+	memcpy(stat, ui->stat, size);
+	for (i = 0; i < ui->number; i++) {
 		if (stat[i].state < STATISTIC_STATE_OFF)
 			continue;
-		stat[i].data = statistic_merge(interface, i);
+		stat[i].data = statistic_merge(ui, i);
 		if (!stat[i].data)
 			goto failed_merge;
 	}
@@ -731,12 +730,12 @@ static int statistic_release_data(struct
 {
 	struct seq_file *seq = file->private_data;
 	struct statistic_seq_private *seq_priv = seq->private;
-	struct statistic_interface *interface = seq_priv->interface;
+	struct statistic_ui *ui = seq_priv->ui;
 	struct statistic *stat = seq_priv->stat;
 	struct statistic_discipline *disc;
 	int i;
 
-	for (i = 0; i < interface->number; i++) {
+	for (i = 0; i < ui->number; i++) {
 		if (stat[i].state < STATISTIC_STATE_OFF)
 			continue;
 		disc = &statistic_discs[stat[i].type];
@@ -802,9 +801,9 @@ static void statistic_merge_counter(stru
 }
 
 static void statistic_data_counter(struct statistic *stat, struct seq_file *seq,
-				   struct statistic_interface *interface, int i)
+				   struct statistic_ui *ui, int i)
 {
-	struct statistic_info *info = &interface->info[i];
+	struct statistic_info *info = &ui->info[i];
 
 	seq_printf(seq, "%s %Lu\n",
 		   info->name, *(unsigned long long *)stat->data);
@@ -891,9 +890,9 @@ static int statistic_div(signed long lon
 }
 
 static void statistic_data_util(struct statistic *stat, struct seq_file *seq,
-				struct statistic_interface *interface, int i)
+				struct statistic_ui *ui, int i)
 {
-	struct statistic_info *info = &interface->info[i];
+	struct statistic_info *info = &ui->info[i];
 	struct statistic_entry_util *util = stat->data;
 	unsigned long long mean_w = 0, mean_d = 0, var_w = 0, var_d = 0,
 			   num = util->num, acc = util->acc, sqr = util->sqr;
@@ -1008,20 +1007,18 @@ static void _statistic_data_histogram(st
 				      signed long long bound,
 				      unsigned long long hits,
 				      struct statistic_info *info,
-				      struct statistic_interface *interface,
-				      int i)
+				      struct statistic_ui *ui, int i)
 {
 	seq_printf(seq, "%s %s%Ld %Lu ", info->name, prefix, bound, hits);
-	statistic_label(interface, i, &bound, seq);
+	statistic_label(ui, i, &bound, seq);
 	seq_printf(seq, "\n");
 }
 
 static void statistic_data_histogram(struct statistic *stat,
 				     struct seq_file *seq,
-				     struct statistic_interface *interface,
-				     int i)
+				     struct statistic_ui *ui, int i)
 {
-	struct statistic_info *info = &interface->info[i];
+	struct statistic_info *info = &ui->info[i];
 	int j;
 	signed long long bound = 0;
 	unsigned long long hits = 0;
@@ -1029,10 +1026,9 @@ static void statistic_data_histogram(str
 	for (j = 0; j < (stat->u.histogram.last_index); j++) {
 		bound = statistic_histogram_calc_value(stat, j);
 		hits = ((u64*)stat->data)[j];
-		_statistic_data_histogram(seq, "<=", bound, hits, info,
-					  interface, i);
+		_statistic_data_histogram(seq, "<=", bound, hits, info, ui, i);
 	}
-	_statistic_data_histogram(seq, ">", bound, hits, info, interface, i);
+	_statistic_data_histogram(seq, ">", bound, hits, info, ui, i);
 }
 
 static void statistic_def_histogram(struct statistic *stat,
@@ -1218,14 +1214,12 @@ static void statistic_merge_sparse(struc
 }
 
 static void statistic_data_sparse(struct statistic *stat, struct seq_file *seq,
-				  struct statistic_interface *interface, int i)
+				  struct statistic_ui *ui, int i)
 {
-	struct statistic_info *info = &interface->info[i];
+	struct statistic_info *info = &ui->info[i];
 	struct statistic_sparse_list *slist = stat->data;
 	struct statistic_entry_sparse *entry;
 
-	seq_printf(seq, "%s missed 0x%Lu\n", info->name,
-		   (unsigned long long)slist->hits_missed);
 	list_for_each_entry(entry, &slist->entry_lh, list) {
 		seq_printf(seq, "%s ", info->name);
 		if (info->flags & _STATISTIC_FLAGS_KEY)
@@ -1234,9 +1228,11 @@ static void statistic_data_sparse(struct
 			seq_printf(seq, "0x%Lx ",
 				   *(signed long long *)entry->key);
 		seq_printf(seq, "%Lu ", (unsigned long long)entry->hits);
-		statistic_label(interface, i, entry->key, seq);
+		statistic_label(ui, i, entry->key, seq);
 		seq_printf(seq, "\n");
 	}
+	seq_printf(seq, "%s other %Lu\n", info->name,
+		   (unsigned long long)slist->hits_missed);
 }
 
 static void statistic_def_sparse(struct statistic *stat, struct seq_file *seq)
@@ -1337,51 +1333,48 @@ static struct statistic_discipline stati
 
 /**
  * statistic_create - setup statistics and create debugfs files
- * @interface: struct statistic_interface provided by client
+ * @ui: struct statistic_ui provided by client
  * @name: name of debugfs directory to be created
  *
  * Creates a debugfs directory in "statistics" as well as the "data" and
  * "definition" files. Then we attach setup statistics according to the
- * definition provided by client through struct statistic_interface.
+ * definition provided by client through struct statistic_ui.
  *
- * struct statistic_interface must have been set up prior to calling this.
+ * struct statistic_ui must have been set up prior to calling this.
  *
  * On success, 0 is returned.
  *
  * If some required memory could not be allocated, or the creation
  * of debugfs entries failed, this routine fails, and -ENOMEM is returned.
  */
-int statistic_create(struct statistic_interface *interface, const char *name)
+int statistic_create(struct statistic_ui *ui, const char *name)
 {
-	struct statistic *stat = interface->stat;
-	struct statistic_info *info = interface->info;
+	struct statistic *stat = ui->stat;
+	struct statistic_info *info = ui->info;
 	int i;
 
-	BUG_ON(!stat || !info || !interface->number);
+	BUG_ON(!stat || !info || !ui->number);
 
-	interface->debugfs_dir =
-		debugfs_create_dir(name, statistic_root_dir);
-	if (unlikely(!interface->debugfs_dir))
+	ui->dir = debugfs_create_dir(name, statistic_root_dir);
+	if (unlikely(!ui->dir))
 		return -ENOMEM;
 
-	interface->data_file = debugfs_create_file(
-		"data", S_IFREG | S_IRUSR, interface->debugfs_dir,
-		(void*)interface, &statistic_data_fops);
-	if (unlikely(!interface->data_file)) {
-		debugfs_remove(interface->debugfs_dir);
+	ui->data = debugfs_create_file("data", S_IFREG | S_IRUSR, ui->dir,
+				       (void*)ui, &statistic_data_fops);
+	if (unlikely(!ui->data)) {
+		debugfs_remove(ui->dir);
 		return -ENOMEM;
 	}
 
-	interface->def_file = debugfs_create_file(
-		"definition", S_IFREG | S_IRUSR | S_IWUSR,
-		interface->debugfs_dir, (void*)interface, &statistic_def_fops);
-	if (unlikely(!interface->def_file)) {
-		debugfs_remove(interface->data_file);
-		debugfs_remove(interface->debugfs_dir);
+	ui->def = debugfs_create_file("definition", S_IFREG | S_IRUSR | S_IWUSR,
+				      ui->dir, (void*)ui, &statistic_def_fops);
+	if (unlikely(!ui->def)) {
+		debugfs_remove(ui->data);
+		debugfs_remove(ui->dir);
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < interface->number; i++, stat++, info++) {
+	for (i = 0; i < ui->number; i++, stat++, info++) {
 		if (info->flags & _STATISTIC_FLAGS_KEY)
 			stat->key_size = info->key_size;
 		else
@@ -1391,7 +1384,7 @@ int statistic_create(struct statistic_in
 	}
 
 	mutex_lock(&statistic_list_mutex);
-	list_add(&interface->list, &statistic_list);
+	list_add(&ui->list, &statistic_list);
 	mutex_unlock(&statistic_list_mutex);
 	return 0;
 }
@@ -1399,7 +1392,7 @@ EXPORT_SYMBOL_GPL(statistic_create);
 
 /**
  * statistic_remove - remove unused statistics
- * @interface: struct statistic_interface to clean up
+ * @ui: struct statistic_ui to clean up
  *
  * Remove a debugfs directory in "statistics" along with its "data" and
  * "definition" files. Removing this user interface also causes the removal
@@ -1409,23 +1402,23 @@ EXPORT_SYMBOL_GPL(statistic_create);
  *
  * Returns -EINVAL for attempted double removal, 0 otherwise.
  */
-int statistic_remove(struct statistic_interface *interface)
+int statistic_remove(struct statistic_ui *ui)
 {
-	struct statistic *stat = interface->stat;
-	struct statistic_info *info = interface->info;
+	struct statistic *stat = ui->stat;
+	struct statistic_info *info = ui->info;
 	int i;
 
-	if (unlikely(!interface->debugfs_dir))
+	if (unlikely(!ui->dir))
 		return -EINVAL;
 	mutex_lock(&statistic_list_mutex);
-	list_del(&interface->list);
+	list_del(&ui->list);
 	mutex_unlock(&statistic_list_mutex);
-	for (i = 0; i < interface->number; i++, stat++, info++)
+	for (i = 0; i < ui->number; i++, stat++, info++)
 		statistic_transition(stat, info, STATISTIC_STATE_INVALID);
-	debugfs_remove(interface->data_file);
-	debugfs_remove(interface->def_file);
-	debugfs_remove(interface->debugfs_dir);
-	interface->debugfs_dir = NULL;
+	debugfs_remove(ui->data);
+	debugfs_remove(ui->def);
+	debugfs_remove(ui->dir);
+	ui->dir = NULL;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(statistic_remove);
Index: linux/drivers/s390/scsi/zfcp_def.h
===================================================================
--- linux.orig/drivers/s390/scsi/zfcp_def.h
+++ linux/drivers/s390/scsi/zfcp_def.h
@@ -942,7 +942,7 @@ struct zfcp_adapter {
 	struct fc_host_statistics *fc_stats;
 	struct fsf_qtcb_bottom_port *stats_reset_data;
 	unsigned long		stats_reset;
-	struct statistic_interface stat_if;
+	struct statistic_ui stat_if;
 	struct statistic stat[_ZFCP_STAT_A_NUMBER];
 };
 
@@ -1006,7 +1006,7 @@ struct zfcp_unit {
 						  all scsi_scan_target
 						  requests have been
 						  completed. */
-	struct statistic_interface stat_if;
+	struct statistic_ui stat_if;
 	struct statistic stat[_ZFCP_STAT_U_NUMBER];
 };
 
