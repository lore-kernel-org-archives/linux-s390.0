Return-Path: <linux-kernel-owner+w=401wt.eu-S965494AbXDNKJ6@vger.kernel.org>
Subject: [RFC] [Patch 1/4] timer_stats slimmed down: statistics prereq,
	cleanup
From: Martin Peschke <mp3@de.ibm.com>
Content-Type: text/plain
Date: Sat, 14 Apr 2007 12:09:50 +0200
Message-Id: <1176545390.5462.109.camel@dix>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-s390@vger.kernel.org, tglx@timesys.com, d.pensator@gmail.com, mingo@redhat.com
List-ID: <linux-s390.vger.kernel.org>

Small cleanup

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 include/linux/statistic.h |    6 +++---
 lib/statistic.c           |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: linux/include/linux/statistic.h
===================================================================
--- linux.orig/include/linux/statistic.h
+++ linux/include/linux/statistic.h
@@ -106,7 +106,7 @@ struct statistic {
  * @info: a struct statistic_info array describing the struct statistic array
  * @number: number of entries in both arrays
  * @pull: an optional function called when user reads data from file
- * @pull_private: optional data pointer passed to pull function
+ * @private: optional data pointer reserved for use by clients
  *
  * Exploiters must setup a struct statistic_interface prior to calling
  * statistic_create().
@@ -121,8 +121,8 @@ struct statistic_interface {
 	struct statistic	*stat;
 	struct statistic_info	*info;
 	int			 number;
-	int			(*pull)(void*);
-	void			*pull_private;
+	int			(*pull)(struct statistic_interface *interface);
+	void			*private;
 };
 
 #ifdef CONFIG_STATISTICS
Index: linux/lib/statistic.c
===================================================================
--- linux.orig/lib/statistic.c
+++ linux/lib/statistic.c
@@ -663,7 +663,7 @@ static int statistic_open_data(struct in
 	int size, i, j, retval = -ENOMEM;
 
 	if (interface->pull)
-		interface->pull(interface->pull_private);
+		interface->pull(interface);
 
 	size = interface->number * sizeof(struct statistic);
 	seq_priv = kzalloc(sizeof(struct statistic_seq_private), GFP_KERNEL);
