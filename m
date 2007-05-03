Return-Path: <linux-kernel-owner+w=401wt.eu-S1767644AbXECR5T@vger.kernel.org>
Subject: [RFC] [Patch 3/3] readahead statistics slimmed down
From: Martin Peschke <mp3@de.ibm.com>
Content-Type: text/plain
Date: Thu, 03 May 2007 19:56:39 +0200
Message-Id: <1178214999.5639.79.camel@dix>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fengguang Wu <fengguang.wu@gmail.com>, Fengguang Wu <wfg@mail.ustc.edu.cn>, swen@vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

This patch implements the bulk of the existing the adaptive readahead
statistics with lib/statistics.c.

The output format differs somewhat as the the statistics code just emits
lists of items and doesn't do tables. It is feasible to leave
reformating and beautification to some user scripts, if needed. This
patch omits some summary data, most of which can be done in user space
as well.

Sample output (from dd'ing a disk):

cache_miss.total 0 0
cache_miss.initial 0 0
cache_miss.clock 10 10
cache_miss.context 0 0
cache_miss.contexta 0 0
cache_miss.backward 0 0
cache_miss.onthrash 0 0
cache_miss.none 257 257
random_read.total 0 0
random_read.initial 0 0
random_read.clock 9 9
random_read.context 0 0
random_read.contexta 0 0
random_read.backward 0 0
random_read.onthrash 0 0
random_read.none 256 256
io_congestion.total 0 0
io_congestion.initial 0 0
io_congestion.clock 0 0
io_congestion.context 0 0
io_congestion.contexta 0 0
io_congestion.backward 0 0
io_congestion.onthrash 0 0
io_congestion.none 0 0
io_cache_hit.total 0 0
io_cache_hit.initial 0 0
io_cache_hit.clock 43 293
io_cache_hit.context 0 0
io_cache_hit.contexta 2 28
io_cache_hit.backward 0 0
io_cache_hit.onthrash 0 0
io_cache_hit.none 0 0
io_block.total 0 0
io_block.initial 49 49
io_block.clock 13215 13215
io_block.context 0 0
io_block.contexta 4 4
io_block.backward 0 0
io_block.onthrash 0 0
io_block.none 256 256
readahead.total 0 0
readahead.initial 50 149
readahead.clock 7041 1801864
readahead.context 0 0
readahead.contexta 2 484
readahead.backward 0 0
readahead.onthrash 0 0
readahead.none 0 0
readahead_hit.total 0 0
readahead_hit.initial 125 125
readahead_hit.clock 1801884 1801884
readahead_hit.context 0 0
readahead_hit.contexta 484 484
readahead_hit.backward 0 0
readahead_hit.onthrash 0 0
readahead_hit.none 0 0
lookahead.total 0 0
lookahead.initial 3 19
lookahead.clock 7041 1802147
lookahead.context 0 0
lookahead.contexta 2 384
lookahead.backward 0 0
lookahead.onthrash 0 0
lookahead.none 0 0
lookahead_hit.total 0 0
lookahead_hit.initial 1 2
lookahead_hit.clock 7040 1801891
lookahead_hit.context 0 0
lookahead_hit.contexta 2 384
lookahead_hit.backward 0 0
lookahead_hit.onthrash 0 0
lookahead_hit.none 0 0
readahead_mmap.total 0 0
readahead_mmap.initial 0 0
readahead_mmap.clock 0 0
readahead_mmap.context 0 0
readahead_mmap.contexta 0 0
readahead_mmap.backward 0 0
readahead_mmap.onthrash 0 0
readahead_mmap.none 0 0
readahead_eof.total 0 0
readahead_eof.initial 49 133
readahead_eof.clock 2 173
readahead_eof.context 0 0
readahead_eof.contexta 0 0
readahead_eof.backward 0 0
readahead_eof.onthrash 0 0
readahead_eof.none 0 0
readahead_thrash.total 0 0
readahead_thrash.initial 0 0
readahead_thrash.clock 0 0
readahead_thrash.context 0 0
readahead_thrash.contexta 0 0
readahead_thrash.backward 0 0
readahead_thrash.onthrash 0 0
readahead_thrash.none 0 0
readahead_mutilt.total 0 0
readahead_mutilt.initial 0 0
readahead_mutilt.clock 0 0
readahead_mutilt.context 0 0
readahead_mutilt.contexta 0 0
readahead_mutilt.backward 0 0
readahead_mutilt.onthrash 0 0
readahead_mutilt.none 0 0
readahead_rescue.total 0 0
readahead_rescue.initial 0 0
readahead_rescue.clock 0 0
readahead_rescue.context 0 0
readahead_rescue.contexta 0 0
readahead_rescue.backward 0 0
readahead_rescue.onthrash 0 0
readahead_rescue.none 0 0



Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 readahead.c |  170 ++++++++++++------------------------------------------------
 1 file changed, 34 insertions(+), 136 deletions(-)


Index: linux/mm/readahead.c
===================================================================
--- linux.orig/mm/readahead.c
+++ linux/mm/readahead.c
@@ -93,7 +93,6 @@ enum ra_event {
 	RA_EVENT_READAHEAD_MUTILATE,	/* read-ahead mutilated by imbalanced aging */
 	RA_EVENT_READAHEAD_RESCUE,	/* read-ahead rescued */
 
-	RA_EVENT_READAHEAD_CUBE,
 	RA_EVENT_COUNT
 };
 
@@ -1784,9 +1783,19 @@ void readahead_cache_hit(struct file_ra_
 #ifdef CONFIG_DEBUG_READAHEAD
 
 #include <linux/init.h>
-#include <linux/jiffies.h>
 #include <linux/debugfs.h>
-#include <linux/seq_file.h>
+#include <linux/statistic.h>
+
+#define RA_STAT_COUNT		(RA_EVENT_COUNT * RA_CLASS_COUNT)
+
+static struct statistic		ra_stat[RA_STAT_COUNT];
+static struct statistic_info	ra_stat_info[RA_STAT_COUNT];
+
+static struct statistic_interface ra_stat_if = {
+	.stat = ra_stat,
+	.info = ra_stat_info,
+	.number = RA_STAT_COUNT
+};
 
 static const char * const ra_class_name[] = {
 	"total",
@@ -1816,162 +1825,51 @@ static const char * const ra_event_name[
 	"readahead_rescue"
 };
 
-static unsigned long ra_events[RA_CLASS_COUNT][RA_EVENT_COUNT][2];
+#define RA_STAT_NAME_SIZE	32
+static char 			ra_stat_name[RA_STAT_COUNT][RA_STAT_NAME_SIZE];
+
+static struct statistic_info ra_stat_info_template = {
+	.x_unit	  = "pages",
+	.y_unit	  = "request",
+	.defaults = "type=counter",
+};
 
 static void ra_account(struct file_ra_state *ra, enum ra_event e, int pages)
 {
 	enum ra_class c;
 
-	if (!readahead_debug_level)
-		return;
-
 	if (pages < 0) {
 		pages = -pages;
 		c = ra_class_old(ra);
 	} else
 		c = ra_class_new(ra);
-
 	if (!c)
 		c = RA_CLASS_NONE;
 
-	ra_events[c][e][0] += 1;
-	ra_events[c][e][1] += pages;
-
-	if (e == RA_EVENT_READAHEAD)
-		ra_events[c][RA_EVENT_READAHEAD_CUBE][1] += pages * pages;
+	statistic_inc(ra_stat, e * RA_CLASS_COUNT + c, pages);
 }
 
-static int ra_events_show(struct seq_file *s, void *_)
-{
-	int i;
-	int c;
-	int e;
-	static const char event_fmt[] = "%-16s";
-	static const char class_fmt[] = "%10s";
-	static const char item_fmt[] = "%10lu";
-	static const char percent_format[] = "%9lu%%";
-	static const char * const table_name[] = {
-		"[table requests]",
-		"[table pages]",
-		"[table summary]"};
-
-	for (i = 0; i <= 1; i++) {
-		for (e = 0; e < RA_EVENT_COUNT; e++) {
-			ra_events[RA_CLASS_ALL][e][i] = 0;
-			for (c = RA_CLASS_INITIAL; c < RA_CLASS_NONE; c++)
-				ra_events[RA_CLASS_ALL][e][i] += ra_events[c][e][i];
-		}
-
-		seq_printf(s, event_fmt, table_name[i]);
-		for (c = 0; c < RA_CLASS_COUNT; c++)
-			seq_printf(s, class_fmt, ra_class_name[c]);
-		seq_puts(s, "\n");
-
-		for (e = 0; e < RA_EVENT_COUNT; e++) {
-			if (e == RA_EVENT_READAHEAD_CUBE)
-				continue;
-			if (e == RA_EVENT_READAHEAD_HIT && i == 0)
-				continue;
-			if (e == RA_EVENT_IO_BLOCK && i == 1)
-				continue;
-
-			seq_printf(s, event_fmt, ra_event_name[e]);
-			for (c = 0; c < RA_CLASS_COUNT; c++)
-				seq_printf(s, item_fmt, ra_events[c][e][i]);
-			seq_puts(s, "\n");
-		}
-		seq_puts(s, "\n");
-	}
-
-	seq_printf(s, event_fmt, table_name[2]);
-	for (c = 0; c < RA_CLASS_COUNT; c++)
-		seq_printf(s, class_fmt, ra_class_name[c]);
-	seq_puts(s, "\n");
-
-	seq_printf(s, event_fmt, "random_rate");
-	for (c = 0; c < RA_CLASS_COUNT; c++)
-		seq_printf(s, percent_format,
-			(ra_events[c][RA_EVENT_RANDOM_READ][0] * 100) /
-			((ra_events[c][RA_EVENT_RANDOM_READ][0] +
-			  ra_events[c][RA_EVENT_READAHEAD][0]) | 1));
-	seq_puts(s, "\n");
-
-	seq_printf(s, event_fmt, "ra_hit_rate");
-	for (c = 0; c < RA_CLASS_COUNT; c++)
-		seq_printf(s, percent_format,
-			(ra_events[c][RA_EVENT_READAHEAD_HIT][1] * 100) /
-			(ra_events[c][RA_EVENT_READAHEAD][1] | 1));
-	seq_puts(s, "\n");
-
-	seq_printf(s, event_fmt, "la_hit_rate");
-	for (c = 0; c < RA_CLASS_COUNT; c++)
-		seq_printf(s, percent_format,
-			(ra_events[c][RA_EVENT_LOOKAHEAD_HIT][0] * 100) /
-			(ra_events[c][RA_EVENT_LOOKAHEAD][0] | 1));
-	seq_puts(s, "\n");
-
-	seq_printf(s, event_fmt, "var_ra_size");
-	for (c = 0; c < RA_CLASS_COUNT; c++)
-		seq_printf(s, item_fmt,
-			(ra_events[c][RA_EVENT_READAHEAD_CUBE][1] -
-			 ra_events[c][RA_EVENT_READAHEAD][1] *
-			(ra_events[c][RA_EVENT_READAHEAD][1] /
-			(ra_events[c][RA_EVENT_READAHEAD][0] | 1))) /
-			(ra_events[c][RA_EVENT_READAHEAD][0] | 1));
-	seq_puts(s, "\n");
-
-	seq_printf(s, event_fmt, "avg_ra_size");
-	for (c = 0; c < RA_CLASS_COUNT; c++)
-		seq_printf(s, item_fmt,
-			(ra_events[c][RA_EVENT_READAHEAD][1] +
-			 ra_events[c][RA_EVENT_READAHEAD][0] / 2) /
-			(ra_events[c][RA_EVENT_READAHEAD][0] | 1));
-	seq_puts(s, "\n");
-
-	seq_printf(s, event_fmt, "avg_la_size");
-	for (c = 0; c < RA_CLASS_COUNT; c++)
-		seq_printf(s, item_fmt,
-			(ra_events[c][RA_EVENT_LOOKAHEAD][1] +
-			 ra_events[c][RA_EVENT_LOOKAHEAD][0] / 2) /
-			(ra_events[c][RA_EVENT_LOOKAHEAD][0] | 1));
-	seq_puts(s, "\n");
-
-	return 0;
-}
-
-static int ra_events_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ra_events_show, NULL);
-}
-
-static ssize_t ra_events_write(struct file *file, const char __user *buf,
-						size_t size, loff_t *offset)
-{
-	memset(ra_events, 0, sizeof(ra_events));
-	return 1;
-}
-
-static struct file_operations ra_events_fops = {
-	.owner		= THIS_MODULE,
-	.open		= ra_events_open,
-	.write		= ra_events_write,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static int __init readahead_init(void)
 {
 	struct dentry *root;
+	int c, e;
 
 	root = debugfs_create_dir("readahead", NULL);
-
-	debugfs_create_file("events", 0644, root, NULL, &ra_events_fops);
-
-	debugfs_create_u32("debug_level", 0644, root, &readahead_debug_level);
 	debugfs_create_bool("disable_clock_readahead", 0644, root,
 			    &disable_clock_readahead);
 
+	for (e = 0; e < RA_EVENT_COUNT; e++) {
+		for (c = 0; c < RA_CLASS_COUNT; c++) {
+			int i = e * RA_CLASS_COUNT + c;
+			memcpy(&ra_stat_info[i], &ra_stat_info_template,
+			       sizeof(struct statistic_info));
+			scnprintf(ra_stat_name[i], RA_STAT_NAME_SIZE, "%s.%s",
+				  ra_event_name[e], ra_class_name[c]);
+			ra_stat_info[i].name = ra_stat_name[i];
+		}
+	}
+	statistic_create(&ra_stat_if, "readahead");
+
 	return 0;
 }
 
