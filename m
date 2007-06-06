Return-Path: <linux-kernel-owner+w=401wt.eu-S936240AbXFFVem@vger.kernel.org>
Subject: [RFC] [Patch 3/4] statistics: sets of statistics in single file
From: Martin Peschke <mp3@de.ibm.com>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 23:33:43 +0200
Message-Id: <1181165623.7133.22.camel@dix>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: a.p.zijlstra@chello.nl, jbaron@redhat.com, rostedt@goodmis.org, billh@gnuppy.monkey.org, mingo@elte.hu, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This patch chips a structure describing a set of statistics from the
structure used to manage the user interface (files) for a set of
statistics. The benefit of this split and small API change is that
users can have multiple sets of statistics per file.

For example, a user which reports statistics data for many entities of
similar type can have them all represented in the same file now:

my_entity_1 some_statistic 0x1000 67
my_entity_1 some_statistic 0x4000 52
my_entity_1 some_statistic 0x5000 13
my_entity_1 some_statistic other 4
my_entity_1 another_statistic samples 83
my_entity_1 another_statistic minimum 185
my_entity_1 another_statistic average 2875.763
my_entity_1 another_statistic maximum 2837585
my_entity_1 another_statistic variance 298469.485
my_entity_2 some_statistic other 0
my_entity_2 another_statistic samples 0
my_entity_2 another_statistic minimum 0
my_entity_2 another_statistic average 0.000
my_entity_2 another_statistic maximum 0
my_entity_2 another_statistic variance 0.000


Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 include/linux/statistic.h |   47 ++++
 lib/statistic.c           |  444 ++++++++++++++++++++++++++++------------------
 2 files changed, 315 insertions(+), 176 deletions(-)

Index: linux/include/linux/statistic.h
===================================================================
--- linux.orig/include/linux/statistic.h
+++ linux/include/linux/statistic.h
@@ -108,13 +108,34 @@ struct statistic {
 };
 
 /**
- * struct statistic_ui - collection of statistics for an entity
+ * struct statistic_coll - collection of statistics for an entity
  * @stat: a struct statistic array
  * @info: a struct statistic_info array describing the struct statistic array
  * @number: number of entries in both arrays
- * @pull: an optional function called when user reads data from file
+ * @private: optional data pointer reserved for use by clients
  * @label: an optional function retrieving a label for each statistics entry
+ *
+ * Exploiters must setup a struct statistic_coll prior to calling
+ * statistic_attach().
+ */
+struct statistic_coll {
+/* private: */
+	struct list_head	 list;
+/* public: */
+#define STATISTIC_COLL_NAME_SIZE 64
+	char 			 name[STATISTIC_COLL_NAME_SIZE];
+	struct statistic	*stat;
+	struct statistic_info	*info;
+	int			 number;
+	void			*private;
+	void			(*label)(struct statistic_coll *coll, int i,
+					 void *key, char *buf, int size);
+};
+
+/**
+ * struct statistic_ui - user interface for statistics
  * @private: optional data pointer reserved for use by clients
+ * @pull: an optional function called when user reads data from file
  *
  * Exploiters must setup a struct statistic_ui prior to calling
  * statistic_create().
@@ -122,17 +143,13 @@ struct statistic {
 struct statistic_ui {
 /* private: */
 	struct list_head	 list;
+	struct list_head	 coll_list;
 	void			*dir;
 	void			*data;
 	void			*def;
 /* public: */
-	struct statistic	*stat;
-	struct statistic_info	*info;
-	int			 number;
-	void			(*pull)(struct statistic_ui *ui);
-	void			(*label)(struct statistic_ui *ui,
-					 int i, void *key, char *buf, int size);
 	void			*private;
+	void			(*pull)(struct statistic_ui *ui);
 };
 
 #ifdef CONFIG_STATISTICS
@@ -140,6 +157,9 @@ struct statistic_ui {
 extern int statistic_create(struct statistic_ui *, const char *);
 extern int statistic_remove(struct statistic_ui *);
 
+extern int statistic_attach(struct statistic_coll *, struct statistic_ui *);
+extern int statistic_detach(struct statistic_coll *);
+
 extern void statistic_set(struct statistic *, int, s64, u64);
 extern void statistic_set_key(struct statistic *, int, void *, u64);
 
@@ -323,6 +343,17 @@ static inline int statistic_remove(struc
 	return 0;
 }
 
+static inline int statistic_attach(struct statistic_coll *coll,
+				   struct statistic_ui *ui)
+{
+	return 0;
+}
+
+static inline int statistic_detach(struct statistic_coll *coll)
+{
+	return 0;
+}
+
 static inline void statistic_set(struct statistic *stat, int i,
 				 s64 value, u64 total)
 {
Index: linux/lib/statistic.c
===================================================================
--- linux.orig/lib/statistic.c
+++ linux/lib/statistic.c
@@ -93,8 +93,7 @@ struct statistic_discipline {
 	void (*reset)(struct statistic *stat, void *ptr);
 	void (*merge)(struct statistic *stat, void *dst, void *src);
 	void (*def)(struct statistic *stat, struct seq_file *seq);
-	void (*data)(struct statistic *stat, struct seq_file *seq,
-		     struct statistic_ui *ui, int i);
+	void (*data)(struct statistic_coll *coll, int i, struct seq_file *seq);
 	void (*add)(struct statistic *stat, s64 value, u64 incr);
 	void (*set)(struct statistic *stat, s64 value, u64 total);
 	void (*kadd)(struct statistic *stat, void *key, u64 incr);
@@ -256,10 +255,9 @@ static void _statistic_merge(void *__mpr
 	spin_unlock(&mpriv->lock);
 }
 
-static void *statistic_merge(struct statistic_ui *ui, int i)
+static void *statistic_merge(struct statistic *stat,
+			     struct statistic_info *info)
 {
-	struct statistic *stat = &ui->stat[i];
-	struct statistic_info *info = &ui->info[i];
 	struct statistic_discipline *disc = &statistic_discs[stat->type];
 	struct statistic_merge_private mpriv;
 	size_t size = disc->size(stat);
@@ -280,11 +278,11 @@ static void *statistic_merge(struct stat
 
 /* cpu hotplug handling for per-cpu data */
 
-static int _statistic_hotcpu(struct statistic_ui *ui, int i,
+static int _statistic_hotcpu(struct statistic_coll *coll, int i,
 			     unsigned long action, int cpu)
 {
-	struct statistic *stat = &ui->stat[i];
-	struct statistic_info *info = &ui->info[i];
+	struct statistic *stat = &coll->stat[i];
+	struct statistic_info *info = &coll->info[i];
 	struct statistic_discipline *disc = &statistic_discs[stat->type];
 	void *src, *dst;
 	size_t size;
@@ -323,18 +321,20 @@ static struct list_head statistic_list;
 static struct mutex statistic_list_mutex;
 
 static int __cpuinit statistic_hotcpu(struct notifier_block *notifier,
-				      unsigned long action, void *__cpu)
+				      unsigned long act, void *__cpu)
 {
 	int cpu = (unsigned long)__cpu, i, retval = NOTIFY_OK;
 	struct statistic_ui *ui;
+	struct statistic_coll *coll;
 
 	mutex_lock(&statistic_list_mutex);
 	list_for_each_entry(ui, &statistic_list, list)
-		for (i = 0; i < ui->number; i++) {
-			retval = _statistic_hotcpu(ui, i, action, cpu);
-			if (retval == NOTIFY_BAD)
-				goto unlock;
-		}
+		list_for_each_entry(coll, &ui->coll_list, list)
+			for (i = 0; i < coll->number; i++) {
+				retval = _statistic_hotcpu(coll, i, act, cpu);
+				if (retval == NOTIFY_BAD)
+					goto unlock;
+			}
 unlock:
 	mutex_unlock(&statistic_list_mutex);
 	return retval;
@@ -439,8 +439,9 @@ static void statistic_parse_line(struct 
 	substring_t args[MAX_OPT_ARGS], sub;
 	int token, reset = 0, defaults = 0, i;
 	int state = STATISTIC_STATE_INVALID;
-	struct statistic *stat = ui->stat;
-	struct statistic_info *info = ui->info;
+	struct statistic_coll *coll;
+	struct statistic_info *info;
+	struct statistic *stat;
 
 	if (unlikely(!def))
 		return;
@@ -465,16 +466,20 @@ static void statistic_parse_line(struct 
 			break;
 		}
 	}
-	for (i = 0; i < ui->number; i++, stat++, info++) {
-		if (!name || (name && !strcmp(name, info->name))) {
-			if (defaults)
-				statistic_parse_match(stat, info, NULL);
-			if (name)
-				statistic_parse_match(stat, info, def);
-			if (state != STATISTIC_STATE_INVALID)
-				statistic_transition(stat, info, state);
-			if (reset)
-				statistic_reset(stat, info);
+	list_for_each_entry(coll, &ui->coll_list, list) {
+		for (i = 0; i < coll->number; i++) {
+			info = &coll->info[i];
+			stat = &coll->stat[i];
+			if (!name || (name && !strcmp(name, info->name))) {
+				if (defaults)
+					statistic_parse_match(stat, info, NULL);
+				if (name)
+					statistic_parse_match(stat, info, def);
+				if (state != STATISTIC_STATE_INVALID)
+					statistic_transition(stat, info, state);
+				if (reset)
+					statistic_reset(stat, info);
+			}
 		}
 	}
 	kfree(name);
@@ -483,10 +488,10 @@ static void statistic_parse_line(struct 
 /* sequential files comprising user interface */
 
 #define STATISTIC_LABEL_SIZE	128
-static void statistic_label(struct statistic_ui *ui, int i, void *key,
+static void statistic_label(struct statistic_coll *coll, int i, void *key,
 			    struct seq_file *seq)
 {
-	struct statistic_info *info = &ui->info[i];
+	struct statistic_info *info = &coll->info[i];
 	char *buf;
 
 	if (!(info->flags & STATISTIC_FLAGS_LABEL))
@@ -494,37 +499,123 @@ static void statistic_label(struct stati
 	buf = kzalloc(STATISTIC_LABEL_SIZE, GFP_ATOMIC);
 	if (!buf)
 		return;
-	ui->label(ui, i, key, buf, STATISTIC_LABEL_SIZE - 1);
+	coll->label(coll, i, key, buf, STATISTIC_LABEL_SIZE - 1);
 	seq_printf(seq, "%s", buf);
 	kfree(buf);
 }
 
 struct statistic_seq_private {
 	struct statistic_ui *ui;
+	struct list_head coll_list;
+	struct statistic_coll *coll;
 	int i;
 	size_t w_offset;
 	char *w_buf;
-	struct statistic *stat;
 };
 
-static void *statistic_seq_traverse(struct seq_file *seq, loff_t *pos, int inc,
-				    struct statistic_seq_private *seq_priv)
+static void statistic_snapshot_free(struct statistic_seq_private *seq_priv,
+				    int with_data)
+{
+	struct statistic_coll *coll, *next;
+	struct statistic_discipline *disc;
+	struct statistic *stat;
+	int i;
+
+	list_for_each_entry_safe(coll, next, &seq_priv->coll_list, list) {
+		if (with_data) {
+			for (i = 0; i < coll->number; i++) {
+				stat = &coll->stat[i];
+				if (stat->state < STATISTIC_STATE_OFF ||
+				    !stat->data)
+					continue;
+				disc = &statistic_discs[stat->type];
+				disc->reset(stat, stat->data);
+				kfree(stat->data);
+			}
+		}
+		list_del(&coll->list);
+		kfree(coll->stat);
+		kfree(coll);
+	}
+	kfree(seq_priv);
+}
+
+static struct statistic_seq_private *statistic_snapshot(struct statistic_ui *ui,
+							int with_data)
 {
-	*pos += inc;
-	if (*pos >= seq_priv->ui->number)
+	struct statistic_seq_private *seq_priv;
+	struct statistic_coll *coll_src, *coll_dst;
+	struct statistic_info *info;
+	struct statistic *src, *dst;
+	int size, i;
+
+	seq_priv = kzalloc(sizeof(*seq_priv), GFP_KERNEL);
+	if (!seq_priv)
 		return NULL;
-	seq_priv->i = *pos;
+
+	seq_priv->ui = ui;
+	INIT_LIST_HEAD(&seq_priv->coll_list);
+
+	list_for_each_entry(coll_src, &ui->coll_list, list) {
+		coll_dst = kmalloc(sizeof(*coll_dst), GFP_KERNEL);
+		if (!coll_dst)
+			goto failed;
+
+		memcpy(coll_dst, coll_src, sizeof(*coll_src));
+		list_add_tail(&coll_dst->list, &seq_priv->coll_list);
+		size = coll_src->number * sizeof(struct statistic);
+		coll_dst->stat = kzalloc(size, GFP_KERNEL);
+		if (!coll_dst->stat)
+			goto failed;
+
+		memcpy(coll_dst->stat, coll_src->stat, size);
+		if (with_data) {
+			for (i = 0; i < coll_dst->number; i++) {
+				src = &coll_src->stat[i];
+				dst = &coll_dst->stat[i];
+				info = &coll_dst->info[i];
+				if (src->state < STATISTIC_STATE_OFF)
+					continue;
+				dst->data = statistic_merge(src, info);
+				if (!dst->data)
+					goto failed;
+			}
+		}
+	}
 	return seq_priv;
+failed:
+	statistic_snapshot_free(seq_priv, with_data);
+	return NULL;
 }
 
 static void *statistic_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	return statistic_seq_traverse(seq, pos, 0, seq->private);
+	struct statistic_seq_private *seq_priv = seq->private;
+	loff_t off = 0;
+
+	list_for_each_entry(seq_priv->coll, &seq_priv->coll_list, list)
+		for (seq_priv->i = 0; seq_priv->i < seq_priv->coll->number;
+		     seq_priv->i++, off++)
+			if (off == *pos)
+				return seq_priv;
+	return NULL;
 }
 
 static void *statistic_seq_next(struct seq_file *seq, void *_seq_priv, loff_t *pos)
 {
-	return statistic_seq_traverse(seq, pos, 1, _seq_priv);
+	struct statistic_seq_private *seq_priv = _seq_priv;
+
+	++*pos;
+	++seq_priv->i;
+	if (seq_priv->i >= seq_priv->coll->number) {
+		if (list_is_last(&seq_priv->coll->list, &seq_priv->coll_list))
+			return NULL;
+		list_for_each_entry_continue(
+				seq_priv->coll, &seq_priv->coll_list, list)
+			break;
+		seq_priv->i = 0;
+	}
+	return seq_priv;
 }
 
 static void statistic_seq_stop(struct seq_file *seq, void *_seq_priv)
@@ -542,13 +633,14 @@ static char *statistic_state_strings[] =
 static int statistic_seq_show_def(struct seq_file *seq, void *_seq_priv)
 {
 	struct statistic_seq_private *seq_priv = _seq_priv;
-	struct statistic_ui *ui = seq_priv->ui;
-	struct statistic *stat = &ui->stat[seq_priv->i];
-	struct statistic_info *info = &ui->info[seq_priv->i];
+	struct statistic_coll *coll = seq_priv->coll;
+	struct statistic_info *info = &coll->info[seq_priv->i];
+	struct statistic *stat = &coll->stat[seq_priv->i];
 	struct statistic_discipline *disc = &statistic_discs[stat->type];
 	char t0[TIMESTAMP_SIZE], t1[TIMESTAMP_SIZE], t2[TIMESTAMP_SIZE];
 
-	seq_printf(seq, "name=%s", info->name);
+	seq_printf(seq, "collection=%s", coll->name);
+	seq_printf(seq, " name=%s", info->name);
 	seq_printf(seq, " state=%s", statistic_state_strings[stat->state]);
 	seq_printf(seq, " units=%s/%s", info->x_unit, info->y_unit);
 
@@ -579,11 +671,12 @@ static int statistic_seq_show_def(struct
 static int statistic_seq_show_data(struct seq_file *seq, void *_seq_priv)
 {
 	struct statistic_seq_private *seq_priv = _seq_priv;
-	struct statistic *stat = &seq_priv->stat[seq_priv->i];
+	struct statistic_coll *coll = seq_priv->coll;
+	struct statistic *stat = &coll->stat[seq_priv->i];
 	struct statistic_discipline *disc = &statistic_discs[stat->type];
 
 	if (stat->state >= STATISTIC_STATE_OFF)
-		disc->data(stat, seq, seq_priv->ui, seq_priv->i);
+		disc->data(coll, seq_priv->i, seq);
 	return 0;
 }
 
@@ -603,21 +696,24 @@ static struct seq_operations statistic_s
 
 static int statistic_open_def(struct inode *inode, struct file *file)
 {
+	struct statistic_ui *ui = inode->i_private;
 	struct statistic_seq_private *seq_priv;
 	struct seq_file *seq;
 	int retval;
 
-	seq_priv = kzalloc(sizeof(struct statistic_seq_private), GFP_KERNEL);
+	seq_priv = statistic_snapshot(ui, 0);
 	if (!seq_priv)
 		return -ENOMEM;
-	seq_priv->ui = inode->i_private;
+
 	retval = seq_open(file, &statistic_seq_ops_def);
-	if (!retval) {
-		seq = file->private_data;
-		seq->private = seq_priv;
-	} else
-		kfree(seq_priv);
-	return retval;
+	if (retval) {
+		statistic_snapshot_free(seq_priv, 0);
+		return retval;
+	}
+
+	seq = file->private_data;
+	seq->private = seq_priv;
+	return 0;
 }
 
 static int statistic_release_def(struct inode *inode, struct file *file)
@@ -632,7 +728,8 @@ static int statistic_release_def(struct 
 			statistic_parse_line(ui, p);
 		kfree(seq_priv->w_buf);
 	}
-	return seq_release_private(inode, file);
+	statistic_snapshot_free(seq_priv, 0);
+	return seq_release(inode, file);
 }
 
 static ssize_t statistic_write_def(struct file *file, const char __user *buf,
@@ -674,76 +771,35 @@ static struct file_operations statistic_
 static int statistic_open_data(struct inode *inode, struct file *file)
 {
 	struct statistic_ui *ui = inode->i_private;
-	struct statistic *stat;
-	struct statistic_discipline *disc;
 	struct statistic_seq_private *seq_priv;
 	struct seq_file *seq;
-	int size, i, j, retval = -ENOMEM;
+	int retval;
 
 	if (ui->pull)
 		ui->pull(ui);
 
-	size = ui->number * sizeof(struct statistic);
-	seq_priv = kzalloc(sizeof(struct statistic_seq_private), GFP_KERNEL);
+	seq_priv = statistic_snapshot(ui, 1);
 	if (!seq_priv)
-		goto failed_priv;
-
-	seq_priv->ui = ui;
-	seq_priv->stat = stat = kmalloc(size, GFP_KERNEL);
-	if (!stat)
-		goto failed_stat;
-
-	memcpy(stat, ui->stat, size);
-	for (i = 0; i < ui->number; i++) {
-		if (stat[i].state < STATISTIC_STATE_OFF)
-			continue;
-		stat[i].data = statistic_merge(ui, i);
-		if (!stat[i].data)
-			goto failed_merge;
-	}
+		return -ENOMEM;
 
 	retval = seq_open(file, &statistic_seq_ops_data);
-	if (retval)
-		goto failed_open;
+	if (retval) {
+		statistic_snapshot_free(seq_priv, 1);
+		return retval;
+	}
 
 	seq = file->private_data;
 	seq->private = seq_priv;
 	return 0;
-
-failed_open:
-	for (j = 0; j < i; j++) {
-		if (stat[j].state < STATISTIC_STATE_OFF)
-			continue;
-		disc = &statistic_discs[stat[j].type];
-		disc->reset(&stat[j], stat[j].data);
-		kfree(stat[j].data);
-	}
-failed_merge:
-	kfree(stat);
-failed_stat:
-	kfree(seq_priv);
-failed_priv:
-	return retval;
 }
 
 static int statistic_release_data(struct inode *inode, struct file *file)
 {
 	struct seq_file *seq = file->private_data;
 	struct statistic_seq_private *seq_priv = seq->private;
-	struct statistic_ui *ui = seq_priv->ui;
-	struct statistic *stat = seq_priv->stat;
-	struct statistic_discipline *disc;
-	int i;
 
-	for (i = 0; i < ui->number; i++) {
-		if (stat[i].state < STATISTIC_STATE_OFF)
-			continue;
-		disc = &statistic_discs[stat[i].type];
-		disc->reset(&stat[i], stat[i].data);
-		kfree(stat[i].data);
-	}
-	kfree(stat);
-	return seq_release_private(inode, file);
+	statistic_snapshot_free(seq_priv, 1);
+	return seq_release(inode, file);
 }
 
 static struct file_operations statistic_data_fops = {
@@ -800,13 +856,14 @@ static void statistic_merge_counter(stru
 	*(u64*)dst += *(u64*)src;
 }
 
-static void statistic_data_counter(struct statistic *stat, struct seq_file *seq,
-				   struct statistic_ui *ui, int i)
+static void statistic_data_counter(struct statistic_coll *coll, int i,
+				   struct seq_file *seq)
 {
-	struct statistic_info *info = &ui->info[i];
+	struct statistic_info *info = &coll->info[i];
+	struct statistic *stat = &coll->stat[i];
 
-	seq_printf(seq, "%s %Lu\n",
-		   info->name, *(unsigned long long *)stat->data);
+	seq_printf(seq, "%s %s %Lu\n", coll->name, info->name,
+		   *(unsigned long long *)stat->data);
 }
 
 /* code concerned with utilisation indicator statistic */
@@ -889,10 +946,11 @@ static int statistic_div(signed long lon
 	return 0;
 }
 
-static void statistic_data_util(struct statistic *stat, struct seq_file *seq,
-				struct statistic_ui *ui, int i)
+static void statistic_data_util(struct statistic_coll *coll, int i,
+				struct seq_file *seq)
 {
-	struct statistic_info *info = &ui->info[i];
+	struct statistic_info *info = &coll->info[i];
+	struct statistic *stat = &coll->stat[i];
 	struct statistic_entry_util *util = stat->data;
 	unsigned long long mean_w = 0, mean_d = 0, var_w = 0, var_d = 0,
 			   num = util->num, acc = util->acc, sqr = util->sqr;
@@ -901,14 +959,14 @@ static void statistic_data_util(struct s
 
 	statistic_div(&mean_w, &mean_d, acc, num, 3);
 	statistic_div(&var_w, &var_d, sqr - mean_w * mean_w, num, 3);
-	seq_printf(seq, "%s samples %Lu\n%s minimum %Ld\n"
-		   "%s average %Ld.%03Ld\n%s maximum %Ld\n"
-		   "%s variance %Ld.%03Ld\n",
-		   info->name, num,
-		   info->name, min,
-		   info->name, mean_w, mean_d,
-		   info->name, max,
-		   info->name, var_w, var_d);
+	seq_printf(seq, "%s %s samples %Lu\n%s %s minimum %Ld\n"
+		   "%s %s average %Ld.%03Ld\n%s %s maximum %Ld\n"
+		   "%s %s variance %Ld.%03Ld\n",
+		   coll->name, info->name, num,
+		   coll->name, info->name, min,
+		   coll->name, info->name, mean_w, mean_d,
+		   coll->name, info->name, max,
+		   coll->name, info->name, var_w, var_d);
 }
 
 /* code concerned with histogram statistics */
@@ -1006,29 +1064,30 @@ static void statistic_merge_histogram(st
 static void _statistic_data_histogram(struct seq_file *seq, const char *prefix,
 				      signed long long bound,
 				      unsigned long long hits,
-				      struct statistic_info *info,
-				      struct statistic_ui *ui, int i)
+				      struct statistic_coll *coll, int i)
 {
-	seq_printf(seq, "%s %s%Ld %Lu ", info->name, prefix, bound, hits);
-	statistic_label(ui, i, &bound, seq);
+	struct statistic_info *info = &coll->info[i];
+
+	seq_printf(seq, "%s %s %s%Ld %Lu ", coll->name, info->name, prefix,
+		   bound, hits);
+	statistic_label(coll, i, &bound, seq);
 	seq_printf(seq, "\n");
 }
 
-static void statistic_data_histogram(struct statistic *stat,
-				     struct seq_file *seq,
-				     struct statistic_ui *ui, int i)
+static void statistic_data_histogram(struct statistic_coll *coll, int i,
+				     struct seq_file *seq)
 {
-	struct statistic_info *info = &ui->info[i];
-	int j;
+	struct statistic *stat = &coll->stat[i];
 	signed long long bound = 0;
 	unsigned long long hits = 0;
+	int j;
 
 	for (j = 0; j < (stat->u.histogram.last_index); j++) {
 		bound = statistic_histogram_calc_value(stat, j);
 		hits = ((u64*)stat->data)[j];
-		_statistic_data_histogram(seq, "<=", bound, hits, info, ui, i);
+		_statistic_data_histogram(seq, "<=", bound, hits, coll, i);
 	}
-	_statistic_data_histogram(seq, ">", bound, hits, info, ui, i);
+	_statistic_data_histogram(seq, ">", bound, hits, coll, i);
 }
 
 static void statistic_def_histogram(struct statistic *stat,
@@ -1213,25 +1272,26 @@ static void statistic_merge_sparse(struc
 				    entry->key, entry->hits);
 }
 
-static void statistic_data_sparse(struct statistic *stat, struct seq_file *seq,
-				  struct statistic_ui *ui, int i)
+static void statistic_data_sparse(struct statistic_coll *coll, int i,
+				  struct seq_file *seq)
 {
-	struct statistic_info *info = &ui->info[i];
+	struct statistic_info *info = &coll->info[i];
+	struct statistic *stat  =&coll->stat[i];
 	struct statistic_sparse_list *slist = stat->data;
 	struct statistic_entry_sparse *entry;
 
 	list_for_each_entry(entry, &slist->entry_lh, list) {
-		seq_printf(seq, "%s ", info->name);
+		seq_printf(seq, "%s %s ", coll->name, info->name);
 		if (info->flags & _STATISTIC_FLAGS_KEY)
 			seq_printf(seq, "- ");
 		else
 			seq_printf(seq, "0x%Lx ",
 				   *(signed long long *)entry->key);
 		seq_printf(seq, "%Lu ", (unsigned long long)entry->hits);
-		statistic_label(ui, i, entry->key, seq);
+		statistic_label(coll, i, entry->key, seq);
 		seq_printf(seq, "\n");
 	}
-	seq_printf(seq, "%s other %Lu\n", info->name,
+	seq_printf(seq, "%s %s other %Lu\n", coll->name, info->name,
 		   (unsigned long long)slist->hits_missed);
 }
 
@@ -1332,49 +1392,34 @@ static struct statistic_discipline stati
 /* programming interface functions */
 
 /**
- * statistic_create - setup statistics and create debugfs files
- * @ui: struct statistic_ui provided by client
- * @name: name of debugfs directory to be created
+ * statistic_attach - stuff more statistics into a user interface
+ * @coll: struct statistic_coll provided by client
+ * @ui: struct statistic_ui to attach to
  *
- * Creates a debugfs directory in "statistics" as well as the "data" and
- * "definition" files. Then we attach setup statistics according to the
- * definition provided by client through struct statistic_ui.
- *
- * struct statistic_ui must have been set up prior to calling this.
+ * Attach statistics to user interface.
+ * Setup statistics according to default definition.
  *
  * On success, 0 is returned.
  *
  * If some required memory could not be allocated, or the creation
  * of debugfs entries failed, this routine fails, and -ENOMEM is returned.
  */
-int statistic_create(struct statistic_ui *ui, const char *name)
+int statistic_attach(struct statistic_coll *coll, struct statistic_ui *ui)
 {
-	struct statistic *stat = ui->stat;
-	struct statistic_info *info = ui->info;
+	struct statistic *stat = coll->stat;
+	struct statistic_info *info = coll->info;
 	int i;
 
-	BUG_ON(!stat || !info || !ui->number);
+	BUG_ON(!stat || !info || !coll->number);
 
-	ui->dir = debugfs_create_dir(name, statistic_root_dir);
 	if (unlikely(!ui->dir))
 		return -ENOMEM;
 
-	ui->data = debugfs_create_file("data", S_IFREG | S_IRUSR, ui->dir,
-				       (void*)ui, &statistic_data_fops);
-	if (unlikely(!ui->data)) {
-		debugfs_remove(ui->dir);
-		return -ENOMEM;
-	}
-
-	ui->def = debugfs_create_file("definition", S_IFREG | S_IRUSR | S_IWUSR,
-				      ui->dir, (void*)ui, &statistic_def_fops);
-	if (unlikely(!ui->def)) {
-		debugfs_remove(ui->data);
-		debugfs_remove(ui->dir);
-		return -ENOMEM;
-	}
+	mutex_lock(&statistic_list_mutex);
+	list_add_tail(&coll->list, &ui->coll_list);
+	mutex_unlock(&statistic_list_mutex);
 
-	for (i = 0; i < ui->number; i++, stat++, info++) {
+	for (i = 0; i < coll->number; i++, stat++, info++) {
 		if (info->flags & _STATISTIC_FLAGS_KEY)
 			stat->key_size = info->key_size;
 		else
@@ -1382,11 +1427,76 @@ int statistic_create(struct statistic_ui
 		statistic_transition(stat, info, STATISTIC_STATE_UNCONFIGURED);
 		statistic_parse_match(stat, info, NULL);
 	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(statistic_attach);
+
+/**
+ * statistic_detach - rip statistics out from user interface
+ * @coll: struct statistic_coll to clean up
+ *
+ * The client must have ceased reporting statistic data.
+ *
+ * Returns -EINVAL for attempted double removal, 0 otherwise.
+ */
+int statistic_detach(struct statistic_coll *coll)
+{
+	struct statistic *stat = coll->stat;
+	struct statistic_info *info = coll->info;
+	int i;
+
+	mutex_lock(&statistic_list_mutex);
+	list_del(&coll->list);
+	mutex_unlock(&statistic_list_mutex);
+	for (i = 0; i < coll->number; i++, stat++, info++)
+		statistic_transition(stat, info, STATISTIC_STATE_INVALID);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(statistic_detach);
+
+/**
+ * statistic_create - create debugfs files
+ * @ui: struct statistic_ui provided by client
+ * @name: name of debugfs directory to be created
+ *
+ * Creates a debugfs directory in "statistics" as well as the "data" and
+ * "definition" files.
+ *
+ * struct statistic_ui must have been set up prior to calling this.
+ *
+ * On success, 0 is returned.
+ *
+ * If some required memory could not be allocated, or the creation
+ * of debugfs entries failed, this routine fails, and -ENOMEM is returned.
+ */
+int statistic_create(struct statistic_ui *ui, const char *name)
+{
+	ui->dir = debugfs_create_dir(name, statistic_root_dir);
+	if (unlikely(!ui->dir))
+		goto failed_dir;
 
+	ui->data = debugfs_create_file("data", S_IFREG | S_IRUSR, ui->dir,
+				       (void*)ui, &statistic_data_fops);
+	if (unlikely(!ui->data))
+		goto failed_data;
+
+	ui->def = debugfs_create_file("definition", S_IFREG | S_IRUSR | S_IWUSR,
+				      ui->dir, (void*)ui, &statistic_def_fops);
+	if (unlikely(!ui->def))
+		goto failed_def;
+
+	INIT_LIST_HEAD(&ui->coll_list);
 	mutex_lock(&statistic_list_mutex);
 	list_add(&ui->list, &statistic_list);
 	mutex_unlock(&statistic_list_mutex);
 	return 0;
+
+failed_def:
+	debugfs_remove(ui->data);
+failed_data:
+	debugfs_remove(ui->dir);
+failed_dir:
+	return -ENOMEM;
 }
 EXPORT_SYMBOL_GPL(statistic_create);
 
@@ -1404,17 +1514,15 @@ EXPORT_SYMBOL_GPL(statistic_create);
  */
 int statistic_remove(struct statistic_ui *ui)
 {
-	struct statistic *stat = ui->stat;
-	struct statistic_info *info = ui->info;
-	int i;
+	struct statistic_coll *coll, *next;
 
 	if (unlikely(!ui->dir))
 		return -EINVAL;
 	mutex_lock(&statistic_list_mutex);
 	list_del(&ui->list);
 	mutex_unlock(&statistic_list_mutex);
-	for (i = 0; i < ui->number; i++, stat++, info++)
-		statistic_transition(stat, info, STATISTIC_STATE_INVALID);
+	list_for_each_entry_safe(coll, next, &ui->coll_list, list)
+		statistic_detach(coll);
 	debugfs_remove(ui->data);
 	debugfs_remove(ui->def);
 	debugfs_remove(ui->dir);
