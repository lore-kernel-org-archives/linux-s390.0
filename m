Return-Path: <linux-kernel-owner+w=401wt.eu-S964981AbXFFVff@vger.kernel.org>
Subject: [RFC] [Patch 4/4] lock contention tracking slimmed down
From: Martin Peschke <mp3@de.ibm.com>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 23:34:16 +0200
Message-Id: <1181165656.7133.23.camel@dix>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: a.p.zijlstra@chello.nl, jbaron@redhat.com, rostedt@goodmis.org, billh@gnuppy.monkey.org, mingo@elte.hu, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This patch converts the lock statistics to a user of lib/statistic.c,
resulting in somewhat simpler code (a 300 lines-of-code diet).

Anyone interested in the details of code duplication might want to study:
- lock_time_inc() vs. statistic_add_util()
- lock_stats() vs. statistic_merge()
- clear_lock_stats() vs. statistic_reset()
- seq file code and per cpu data used by both approaches

The output has changed from a terribly wide table to an enormously
long list (just the generic way the statistics code prints data).
Still, all information has been retained:

<snip>
&rq->rq_lock_key contentions 0x34c04 545 task_rq_lock+0x64/0xb0
&rq->rq_lock_key contentions 0x34b62 148 double_rq_lock+0x4a/0x88
&rq->rq_lock_key contentions 0x357d0 8 double_lock_balance+0x7c/0x98
&rq->rq_lock_key contentions 0x35cf6 1 run_rebalance_domains+0x50a/0x5c0
&rq->rq_lock_key contentions other 404
&rq->rq_lock_key wait_read samples 0
&rq->rq_lock_key wait_read minimum 0
&rq->rq_lock_key wait_read average 0.000
&rq->rq_lock_key wait_read maximum 0
&rq->rq_lock_key wait_read variance 0.000
&rq->rq_lock_key wait_write samples 1106
&rq->rq_lock_key wait_write minimum 343
&rq->rq_lock_key wait_write average 361157.478
&rq->rq_lock_key wait_write maximum 5886625
&rq->rq_lock_key wait_write variance 753383636064.242
&rq->rq_lock_key hold_read samples 0
&rq->rq_lock_key hold_read minimum 0
&rq->rq_lock_key hold_read average 0.000
&rq->rq_lock_key hold_read maximum 0
&rq->rq_lock_key hold_read variance 0.000
&rq->rq_lock_key hold_write samples 551474
&rq->rq_lock_key hold_write minimum 94
&rq->rq_lock_key hold_write average 2517.107
&rq->rq_lock_key hold_write maximum 6269659
&rq->rq_lock_key hold_write variance 1996596045.121
xtime_lock contentions 0x17bd2 3327 account_ticks+0x96/0x184
xtime_lock contentions other 0
xtime_lock wait_read samples 0
xtime_lock wait_read minimum 0
xtime_lock wait_read average 0.000
xtime_lock wait_read maximum 0
xtime_lock wait_read variance 0.000
xtime_lock wait_write samples 3327
xtime_lock wait_write minimum 422
xtime_lock wait_write average 63371.777
xtime_lock wait_write maximum 3731202
xtime_lock wait_write variance 109560396493.412
xtime_lock hold_read samples 0
xtime_lock hold_read minimum 0
xtime_lock hold_read average 0.000
xtime_lock hold_read maximum 0
xtime_lock hold_read variance 0.000
xtime_lock hold_write samples 500405
xtime_lock hold_write minimum 203
xtime_lock hold_write average 2224.482
xtime_lock hold_write maximum 3495922
xtime_lock hold_write variance 350307599.860
clocksource_lock contentions other 0
clocksource_lock wait_read samples 0
clocksource_lock wait_read minimum 0
clocksource_lock wait_read average 0.000
clocksource_lock wait_read maximum 0
clocksource_lock wait_read variance 0.000
clocksource_lock wait_write samples 0
clocksource_lock wait_write minimum 0
clocksource_lock wait_write average 0.000
clocksource_lock wait_write maximum 0
clocksource_lock wait_write variance 0.000
clocksource_lock hold_read samples 0
clocksource_lock hold_read minimum 0
clocksource_lock hold_read average 0.000
clocksource_lock hold_read maximum 0
clocksource_lock hold_read variance 0.000
clocksource_lock hold_write samples 308908
clocksource_lock hold_write minimum 188
clocksource_lock hold_write average 435.165
clocksource_lock hold_write maximum 2485654
clocksource_lock hold_write variance 86184020.322
<snip>


Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 include/linux/lockdep.h |   35 ++---
 kernel/lockdep.c        |  122 ++-----------------
 kernel/lockdep_proc.c   |  294 +++++++-----------------------------------------
 3 files changed, 76 insertions(+), 375 deletions(-)

Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -37,6 +37,7 @@
 #include <linux/debug_locks.h>
 #include <linux/irqflags.h>
 #include <linux/utsname.h>
+#include <linux/statistic.h>
 
 #include <asm/sections.h>
 
@@ -119,93 +120,9 @@ unsigned long nr_lock_classes;
 static struct lock_class lock_classes[MAX_LOCKDEP_KEYS];
 
 #ifdef CONFIG_LOCK_STAT
-static DEFINE_PER_CPU(struct lock_class_stats[MAX_LOCKDEP_KEYS], lock_stats);
-
-static int lock_contention_point(struct lock_class *class, unsigned long ip)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(class->contention_point); i++) {
-		if (class->contention_point[i] == 0) {
-			class->contention_point[i] = ip;
-			break;
-		}
-		if (class->contention_point[i] == ip)
-			break;
-	}
-
-	return i;
-}
-
-static void lock_time_inc(struct lock_time *lt, s64 time)
-{
-	if (time > lt->max)
-		lt->max = time;
-
-	if (time < lt->min || !lt->min)
-		lt->min = time;
-
-	lt->total += time;
-	lt->nr++;
-}
-
-static inline void lock_time_add(struct lock_time *src, struct lock_time *dst)
-{
-	dst->min += src->min;
-	dst->max += src->max;
-	dst->total += src->total;
-	dst->nr += src->nr;
-}
-
-struct lock_class_stats lock_stats(struct lock_class *class)
-{
-	struct lock_class_stats stats;
-	int cpu, i;
-
-	memset(&stats, 0, sizeof(struct lock_class_stats));
-	for_each_possible_cpu(cpu) {
-		struct lock_class_stats *pcs =
-			&per_cpu(lock_stats, cpu)[class - lock_classes];
-
-		for (i = 0; i < ARRAY_SIZE(stats.contention_point); i++)
-			stats.contention_point[i] += pcs->contention_point[i];
-
-		lock_time_add(&pcs->read_waittime, &stats.read_waittime);
-		lock_time_add(&pcs->write_waittime, &stats.write_waittime);
-
-		lock_time_add(&pcs->read_holdtime, &stats.read_holdtime);
-		lock_time_add(&pcs->write_holdtime, &stats.write_holdtime);
-	}
-
-	return stats;
-}
-
-void clear_lock_stats(struct lock_class *class)
-{
-	int cpu;
-
-	for_each_possible_cpu(cpu) {
-		struct lock_class_stats *cpu_stats =
-			&per_cpu(lock_stats, cpu)[class - lock_classes];
-
-		memset(cpu_stats, 0, sizeof(struct lock_class_stats));
-	}
-	memset(class->contention_point, 0, sizeof(class->contention_point));
-}
-
-static struct lock_class_stats *get_lock_stats(struct lock_class *class)
-{
-	return &get_cpu_var(lock_stats)[class - lock_classes];
-}
-
-static void put_lock_stats(struct lock_class_stats *stats)
-{
-	put_cpu_var(lock_stats);
-}
-
 static void lock_release_holdtime(struct held_lock *hlock)
 {
-	struct lock_class_stats *stats;
+	struct statistic *stat = hlock->class->stat;
 	s64 holdtime;
 
 	if (!lock_stat)
@@ -213,12 +130,10 @@ static void lock_release_holdtime(struct
 
 	holdtime = sched_clock() - hlock->holdtime_stamp;
 
-	stats = get_lock_stats(hlock->class);
 	if (hlock->read)
-		lock_time_inc(&stats->read_holdtime, holdtime);
+		statistic_inc(stat, LOCK_STAT_HOLD_READ, holdtime);
 	else
-		lock_time_inc(&stats->write_holdtime, holdtime);
-	put_lock_stats(stats);
+		statistic_inc(stat, LOCK_STAT_HOLD_WRITE, holdtime);
 }
 #else
 static inline void lock_release_holdtime(struct held_lock *hlock)
@@ -2745,9 +2660,8 @@ __lock_contended(struct lockdep_map *loc
 {
 	struct task_struct *curr = current;
 	struct held_lock *hlock, *prev_hlock;
-	struct lock_class_stats *stats;
 	unsigned int depth;
-	int i, point;
+	int i;
 
 	depth = curr->lockdep_depth;
 	if (DEBUG_LOCKS_WARN_ON(!depth))
@@ -2761,22 +2675,15 @@ __lock_contended(struct lockdep_map *loc
 		 */
 		if (prev_hlock && prev_hlock->irq_context != hlock->irq_context)
 			break;
-		if (hlock->instance == lock)
-			goto found_it;
+		if (hlock->instance == lock) {
+			hlock->waittime_stamp = sched_clock();
+			_statistic_inc(hlock->class->stat, LOCK_STAT_CONT, ip);
+			return;
+		}
 		prev_hlock = hlock;
 	}
 	print_lock_contention_bug(curr, lock, ip);
 	return;
-
-found_it:
-	hlock->waittime_stamp = sched_clock();
-
-	point = lock_contention_point(hlock->class, ip);
-
-	stats = get_lock_stats(hlock->class);
-	if (point < ARRAY_SIZE(stats->contention_point))
-		stats->contention_point[i]++;
-	put_lock_stats(stats);
 }
 
 static void
@@ -2784,7 +2691,7 @@ __lock_acquired(struct lockdep_map *lock
 {
 	struct task_struct *curr = current;
 	struct held_lock *hlock, *prev_hlock;
-	struct lock_class_stats *stats;
+	struct statistic *stat;
 	unsigned int depth;
 	u64 now;
 	s64 waittime;
@@ -2817,12 +2724,11 @@ found_it:
 	waittime = now - hlock->waittime_stamp;
 	hlock->holdtime_stamp = now;
 
-	stats = get_lock_stats(hlock->class);
+	stat = hlock->class->stat;
 	if (hlock->read)
-		lock_time_inc(&stats->read_waittime, waittime);
+		_statistic_inc(stat, LOCK_STAT_WAIT_READ, waittime);
 	else
-		lock_time_inc(&stats->write_waittime, waittime);
-	put_lock_stats(stats);
+		_statistic_inc(stat, LOCK_STAT_WAIT_WRITE, waittime);
 }
 
 void lock_contended(struct lockdep_map *lock, unsigned long ip)
Index: linux/include/linux/lockdep.h
===================================================================
--- linux.orig/include/linux/lockdep.h
+++ linux/include/linux/lockdep.h
@@ -17,6 +17,7 @@ struct lockdep_map;
 #include <linux/list.h>
 #include <linux/debug_locks.h>
 #include <linux/stacktrace.h>
+#include <linux/statistic.h>
 
 /*
  * Lock-class usage-state bits:
@@ -72,6 +73,17 @@ struct lock_class_key {
 	struct lockdep_subclass_key	subkeys[MAX_LOCKDEP_SUBCLASSES];
 };
 
+#ifdef CONFIG_LOCK_STAT
+enum lock_stat_enum {
+	LOCK_STAT_CONT,
+	LOCK_STAT_WAIT_READ,
+	LOCK_STAT_WAIT_WRITE,
+	LOCK_STAT_HOLD_READ,
+	LOCK_STAT_HOLD_WRITE,
+	_LOCK_STAT_NUMBER
+};
+#endif
+
 /*
  * The lock-class itself:
  */
@@ -117,30 +129,11 @@ struct lock_class {
 	int				name_version;
 
 #ifdef CONFIG_LOCK_STAT
-	unsigned long			contention_point[4];
+	struct statistic		stat[_LOCK_STAT_NUMBER];
+	struct statistic_coll		stat_coll;
 #endif
 };
 
-#ifdef CONFIG_LOCK_STAT
-struct lock_time {
-	s64				min;
-	s64				max;
-	s64				total;
-	unsigned long			nr;
-};
-
-struct lock_class_stats {
-	unsigned long			contention_point[4];
-	struct lock_time		read_waittime;
-	struct lock_time		write_waittime;
-	struct lock_time		read_holdtime;
-	struct lock_time		write_holdtime;
-};
-
-struct lock_class_stats lock_stats(struct lock_class *class);
-void clear_lock_stats(struct lock_class *class);
-#endif
-
 /*
  * Map the lock object (the lock instance) to the lock-class object.
  * This is embedded into specific lock instances:
Index: linux/kernel/lockdep_proc.c
===================================================================
--- linux.orig/kernel/lockdep_proc.c
+++ linux/kernel/lockdep_proc.c
@@ -349,260 +349,64 @@ static const struct file_operations proc
 };
 
 #ifdef CONFIG_LOCK_STAT
-
-struct lock_stat_data {
-	struct lock_class *class;
-	struct lock_class_stats stats;
-};
-
-struct lock_stat_seq {
-	struct lock_stat_data *iter;
-	struct lock_stat_data *iter_end;
-	struct lock_stat_data stats[MAX_LOCKDEP_KEYS];
-};
-
-/*
- * sort on absolute number of contentions
- */
-int lock_stat_cmp(const void *l, const void *r)
-{
-	const struct lock_stat_data *dl = l, *dr = r;
-	unsigned long nl, nr;
-
-	nl = dl->stats.read_waittime.nr + dl->stats.write_waittime.nr;
-	nr = dr->stats.read_waittime.nr + dr->stats.write_waittime.nr;
-
-	return nr - nl;
-}
-
-static void seq_line(struct seq_file *m, char c, int offset, int length)
-{
-	int i;
-
-	for (i = 0; i < offset; i++)
-		seq_puts(m, " ");
-	for (i = 0; i < length; i++)
-		seq_printf(m, "%c", c);
-	seq_puts(m, "\n");
-}
-
-static void snprint_time(char *buf, size_t bufsiz, s64 nr)
-{
-	unsigned long rem;
-
-	rem = do_div(nr, 1000); /* XXX: do_div_signed */
-	snprintf(buf, bufsiz, "%lld.%02d", nr, ((int)rem+5)/10);
-}
-
-static void seq_time(struct seq_file *m, s64 time)
-{
-	char num[15];
-
-	snprint_time(num, sizeof(num), time);
-	seq_printf(m, " %14s", num);
-}
-
-static void seq_lock_time(struct seq_file *m, struct lock_time *lt)
-{
-	seq_printf(m, "%14lu", lt->nr);
-	seq_time(m, lt->min);
-	seq_time(m, lt->max);
-	seq_time(m, lt->total);
-}
-
-static void seq_stats(struct seq_file *m, struct lock_stat_data *data)
-{
-	char name[39];
-	struct lock_class *class;
-	struct lock_class_stats *stats;
-	int i, namelen;
-
-	class = data->class;
-	stats = &data->stats;
-
-	snprintf(name, 38, "%s", class->name);
-	namelen = strlen(name);
-
-	if (stats->write_holdtime.nr) {
-		if (stats->read_holdtime.nr)
-			seq_printf(m, "%38s-W:", name);
-		else
-			seq_printf(m, "%40s:", name);
-
-		seq_lock_time(m, &stats->write_waittime);
-		seq_puts(m, " ");
-		seq_lock_time(m, &stats->write_holdtime);
-		seq_puts(m, "\n");
-	}
-
-	if (stats->read_holdtime.nr) {
-		seq_printf(m, "%38s-R:", name);
-		seq_lock_time(m, &stats->read_waittime);
-		seq_puts(m, " ");
-		seq_lock_time(m, &stats->read_holdtime);
-		seq_puts(m, "\n");
+struct statistic_info lock_stat_info[_LOCK_STAT_NUMBER] = {
+	[LOCK_STAT_CONT] = {
+		.name	  = "contentions",
+		.x_unit	  = "instruction_pointer",
+		.y_unit	  = "occurrence",
+		.defaults = "type=sparse entries=4",
+		.flags	  = STATISTIC_FLAGS_LABEL,
+	},
+	[LOCK_STAT_WAIT_READ] = {
+		.name	  = "wait_read",
+		.x_unit	  = "nanoseconds",
+		.y_unit	  = "occurrence",
+		.defaults = "type=utilisation",
+	},
+	[LOCK_STAT_WAIT_WRITE] = {
+		.name	  = "wait_write",
+		.x_unit	  = "nanoseconds",
+		.y_unit	  = "occurrence",
+		.defaults = "type=utilisation",
+	},
+	[LOCK_STAT_HOLD_READ] = {
+		.name	  = "hold_read",
+		.x_unit	  = "nanoseconds",
+		.y_unit	  = "occurrence",
+		.defaults = "type=utilisation",
+	},
+	[LOCK_STAT_HOLD_WRITE] = {
+		.name	  = "hold_write",
+		.x_unit	  = "nanoseconds",
+		.y_unit	  = "occurrence",
+		.defaults = "type=utilisation",
 	}
-
-	if (stats->read_waittime.nr + stats->write_waittime.nr == 0)
-		return;
-
-	if (stats->read_holdtime.nr)
-		namelen += 2;
-
-	for (i = 0; i < ARRAY_SIZE(class->contention_point); i++) {
-		char sym[KSYM_SYMBOL_LEN];
-		char ip[32];
-
-		if (class->contention_point[i] == 0)
-			break;
-
-		if (!i)
-			seq_line(m, '-', 40-namelen, namelen);
-
-		sprint_symbol(sym, class->contention_point[i]);
-		snprintf(ip, sizeof(ip), "[<%p>]",
-				(void *)class->contention_point[i]);
-		seq_printf(m, "%40s %14lu %29s %s\n", name,
-				stats->contention_point[i],
-				ip, sym);
-	}
-	if (i) {
-		seq_puts(m, "\n");
-		seq_line(m, '.', 0, 40 + 1 + 8 * (14 + 1));
-		seq_puts(m, "\n");
-	}
-}
-
-static void seq_header(struct seq_file *m)
-{
-	seq_printf(m, "lock_stat version 0.1\n");
-	seq_line(m, '-', 0, 40 + 1 + 8 * (14 + 1));
-	seq_printf(m, "%40s %14s %14s %14s %14s %14s %14s %14s %14s\n",
-			"class name",
-			"contentions",
-			"waittime-min",
-			"waittime-max",
-			"waittime-total",
-			"acquisitions",
-			"holdtime-min",
-			"holdtime-max",
-			"holdtime-total");
-	seq_line(m, '-', 0, 40 + 1 + 8 * (14 + 1));
-	seq_printf(m, "\n");
-}
-
-static void *ls_start(struct seq_file *m, loff_t *pos)
-{
-	struct lock_stat_seq *data = m->private;
-
-	if (data->iter == data->stats)
-		seq_header(m);
-
-	return data->iter;
-}
-
-static void *ls_next(struct seq_file *m, void *v, loff_t *pos)
-{
-	struct lock_stat_seq *data = m->private;
-
-	(*pos)++;
-
-	data->iter = v;
-	data->iter++;
-	if (data->iter == data->iter_end)
-		data->iter = NULL;
-
-	return data->iter;
-}
-
-static void ls_stop(struct seq_file *m, void *v)
-{
-}
-
-static int ls_show(struct seq_file *m, void *v)
-{
-	struct lock_stat_seq *data = m->private;
-
-	seq_stats(m, data->iter);
-	return 0;
-}
-
-static struct seq_operations lockstat_ops = {
-	.start	= ls_start,
-	.next	= ls_next,
-	.stop	= ls_stop,
-	.show	= ls_show,
 };
 
-static int lock_stat_open(struct inode *inode, struct file *file)
-{
-	int res;
-	struct lock_class *class;
-	struct lock_stat_seq *data = vmalloc(sizeof(struct lock_stat_seq));
-
-	if (!data)
-		return -ENOMEM;
-
-	res = seq_open(file, &lockstat_ops);
-	if (!res) {
-		struct lock_stat_data *iter = data->stats;
-		struct seq_file *m = file->private_data;
-
-		data->iter = iter;
-		list_for_each_entry(class, &all_lock_classes, lock_entry) {
-			iter->class = class;
-			iter->stats = lock_stats(class);
-			iter++;
-		}
-		data->iter_end = iter;
-
-		sort(data->stats, data->iter_end - data->iter,
-				sizeof(struct lock_stat_data),
-				lock_stat_cmp, NULL);
-
-		m->private = data;
-	} else
-		vfree(data);
+struct statistic_ui lock_stat_ui;
 
-	return res;
+static void lock_stat_label(struct statistic_coll *coll, int i,
+			    void *key, char *buf, int size)
+{
+	sprint_symbol(buf, *(unsigned long *)key);
 }
 
-ssize_t lock_stat_write(struct file *file, const char __user *buf,
-		size_t count, loff_t *ppos)
+static void lock_stat_init(void)
 {
 	struct lock_class *class;
-	char c;
-
-	if (count) {
-		if (get_user(c, buf))
-			return -EFAULT;
 
-		if (c != '0')
-			return count;
-
-		list_for_each_entry(class, &all_lock_classes, lock_entry)
-			clear_lock_stats(class);
+	statistic_create(&lock_stat_ui, "lockstat");
+	list_for_each_entry(class, &all_lock_classes, lock_entry) {
+		class->stat_coll.stat = class->stat;
+		class->stat_coll.info = lock_stat_info;
+		class->stat_coll.number  = _LOCK_STAT_NUMBER;
+		class->stat_coll.label = lock_stat_label;
+		strncpy(class->stat_coll.name, class->name,
+			STATISTIC_COLL_NAME_SIZE - 1);
+		statistic_attach(&class->stat_coll, &lock_stat_ui);
 	}
-	return count;
-}
-
-static int lock_stat_release(struct inode *inode, struct file *file)
-{
-	struct seq_file *seq = file->private_data;
-
-	vfree(seq->private);
-	seq->private = NULL;
-	return seq_release(inode, file);
 }
-
-static const struct file_operations proc_lock_stat_operations = {
-	.open		= lock_stat_open,
-	.write		= lock_stat_write,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= lock_stat_release,
-};
-#endif /* CONFIG_LOCK_STAT */
+#endif
 
 static int __init lockdep_proc_init(void)
 {
@@ -617,9 +421,7 @@ static int __init lockdep_proc_init(void
 		entry->proc_fops = &proc_lockdep_stats_operations;
 
 #ifdef CONFIG_LOCK_STAT
-	entry = create_proc_entry("lock_stat", S_IRUSR, NULL);
-	if (entry)
-		entry->proc_fops = &proc_lock_stat_operations;
+	lock_stat_init();
 #endif
 
 	return 0;
