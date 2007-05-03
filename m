Return-Path: <linux-kernel-owner+w=401wt.eu-S1767591AbXECR4n@vger.kernel.org>
Subject: [RFC] [Patch 1/3] readahead statistics slimmed down, statistics
	prereq
From: Martin Peschke <mp3@de.ibm.com>
Content-Type: text/plain
Date: Thu, 03 May 2007 19:56:27 +0200
Message-Id: <1178214987.5639.77.camel@dix>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fengguang Wu <fengguang.wu@gmail.com>, Fengguang Wu <wfg@mail.ustc.edu.cn>, swen@vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

The statistics infrastruture used to offer two different counter
implementations: one that just counted the number of samples, and
another one that summed up all samples. Users were required to chose
one, while it is often useful to have both pieces of information. This
patches merges them. Output looks like:

<statistic name> <samples> <total>

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 include/linux/statistic.h |   16 +++-------
 lib/statistic.c           |   72 +++++++++++++++++++++-------------------------
 2 files changed, 38 insertions(+), 50 deletions(-)

Index: linux/include/linux/statistic.h
===================================================================
--- linux.orig/include/linux/statistic.h
+++ linux/include/linux/statistic.h
@@ -75,8 +75,7 @@ enum statistic_state {
 };
 
 enum statistic_type {
-	STAT_CNTR_INC,
-	STAT_CNTR_PROD,
+	STAT_CNTR,
 	STAT_UTIL,
 	STAT_HGRAM_LIN,
 	STAT_HGRAM_LOG2,
@@ -156,8 +155,7 @@ extern void statistic_add_key(struct sta
  * The declarations are needed to allow optimisation of _statistic_add_as()
  * at compile time.
  */
-extern void statistic_add_counter_inc(struct statistic *, s64, u64);
-extern void statistic_add_counter_prod(struct statistic *, s64, u64);
+extern void statistic_add_counter(struct statistic *, s64, u64);
 extern void statistic_add_util(struct statistic *, s64, u64);
 extern void statistic_add_histogram_lin(struct statistic *, s64, u64);
 extern void statistic_add_histogram_log2(struct statistic *, s64, u64);
@@ -191,11 +189,8 @@ static inline void _statistic_add_as(int
 {
 	if (stat[i].state == STATISTIC_STATE_ON) {
 		switch (type) {
-		case STAT_CNTR_INC:
-			statistic_add_counter_inc(&stat[i], value, incr);
-			break;
-		case STAT_CNTR_PROD:
-			statistic_add_counter_prod(&stat[i], value, incr);
+		case STAT_CNTR:
+			statistic_add_counter(&stat[i], value, incr);
 			break;
 		case STAT_UTIL:
 			statistic_add_util(&stat[i], value, incr);
@@ -269,8 +264,7 @@ static inline void _statistic_add_as_key
 {
 	if (stat[i].state == STATISTIC_STATE_ON) {
 		switch (type) {
-		case STAT_CNTR_INC:
-		case STAT_CNTR_PROD:
+		case STAT_CNTR:
 		case STAT_UTIL:
 		case STAT_HGRAM_LIN:
 		case STAT_HGRAM_LOG2:
Index: linux/lib/statistic.c
===================================================================
--- linux.orig/lib/statistic.c
+++ linux/lib/statistic.c
@@ -740,57 +740,60 @@ static struct file_operations statistic_
 
 /* code concerned with single value statistics */
 
+struct statistic_entry_counter {
+	u64 num;
+	s64 acc;
+};
+
 size_t statistic_size_counter(struct statistic *stat)
 {
-	return sizeof(u64);
+	return sizeof(struct statistic_entry_counter);
 }
 
 static void statistic_reset_counter(struct statistic *stat, void *ptr)
 {
-	*(u64*)ptr = 0;
-}
+	struct statistic_entry_counter *count = ptr;
 
-void statistic_add_counter_inc(struct statistic *stat, s64 value, u64 incr)
-{
-	*(u64*)percpu_ptr(stat->data, smp_processor_id()) += incr;
+	count->num = 0;
+	count->acc = 0;
 }
-EXPORT_SYMBOL_GPL(statistic_add_counter_inc);
 
-void statistic_add_counter_prod(struct statistic *stat, s64 value, u64 incr)
+void statistic_add_counter(struct statistic *stat, s64 value, u64 incr)
 {
-	if (unlikely(value < 0))
-		value = -value;
-	*(u64*)percpu_ptr(stat->data, smp_processor_id()) += value * incr;
-}
-EXPORT_SYMBOL_GPL(statistic_add_counter_prod);
+	struct statistic_entry_counter *count;
 
-static void statistic_set_counter_inc(struct statistic *stat,
-				      s64 value, u64 total)
-{
-	*(u64*)stat->data = total;
+	count = percpu_ptr(stat->data, smp_processor_id());
+	count->num += incr;
+	count->acc += value * incr;
 }
+EXPORT_SYMBOL_GPL(statistic_add_counter);
 
-static void statistic_set_counter_prod(struct statistic *stat,
-				       s64 value, u64 total)
+static void statistic_set_counter(struct statistic *stat, s64 value, u64 total)
 {
-	if (unlikely(value < 0))
-		value = -value;
-	*(u64*)stat->data = value * total;
+	struct statistic_entry_counter *count = stat->data;
+
+	count->num = total;
+	count->acc = value * total;
 }
 
 static void statistic_merge_counter(struct statistic *stat,
-				    void *dst, void *src)
+				    void *_dst, void *_src)
 {
-	*(u64*)dst += *(u64*)src;
+	struct statistic_entry_counter *dst = _dst, *src = _src;
+
+	dst->num += src->num;
+	dst->acc += src->acc;
 }
 
 static void statistic_data_counter(struct statistic *stat, struct seq_file *seq,
 				   struct statistic_interface *interface, int i)
 {
+	struct statistic_entry_counter *count = stat->data;
 	struct statistic_info *info = &interface->info[i];
 
-	seq_printf(seq, "%s %Lu\n",
-		   info->name, *(unsigned long long *)stat->data);
+	seq_printf(seq, "%s %Lu %Ld\n", info->name,
+		   (unsigned long long)count->num,
+		   (signed long long)count->acc);
 }
 
 /* code concerned with utilisation indicator statistic */
@@ -1253,23 +1256,14 @@ static int statistic_parse_sparse(struct
 /* code mostly concerned with managing statistics */
 
 static struct statistic_discipline statistic_discs[] = {
-	[STAT_CNTR_INC] = {
-		.size	= statistic_size_counter,
-		.reset	= statistic_reset_counter,
-		.merge	= statistic_merge_counter,
-		.data	= statistic_data_counter,
-		.add	= statistic_add_counter_inc,
-		.set	= statistic_set_counter_inc,
-		.name	= "counter_inc",
-	},
-	[STAT_CNTR_PROD] = {
+	[STAT_CNTR] = {
 		.size	= statistic_size_counter,
 		.reset	= statistic_reset_counter,
 		.merge	= statistic_merge_counter,
 		.data	= statistic_data_counter,
-		.add	= statistic_add_counter_prod,
-		.set	= statistic_set_counter_prod,
-		.name	= "counter_prod",
+		.add	= statistic_add_counter,
+		.set	= statistic_set_counter,
+		.name	= "counter",
 	},
 	[STAT_UTIL] = {
 		.size	= statistic_size_util,
