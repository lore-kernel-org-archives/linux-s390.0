Return-Path: <BATV+d8c56d9a67374e13c9b4+5014+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 9/9] timers: remove old timer initialization macros
Date: Tue, 16 May 2017 13:48:12 +0200
Message-Id: <20170516114812.10660-10-hch@lst.de>
In-Reply-To: <20170516114812.10660-1-hch@lst.de>
References: <20170516114812.10660-1-hch@lst.de>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Gross <mark.gross@intel.com>, Tejun Heo <tj@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/timer.h | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 87afe52c8349..9c6694d3f66a 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -80,35 +80,19 @@ struct timer_list {
 	struct timer_list _name = INIT_TIMER(_func, _expires, _flags)
 
 /*
- * Don't use the macros below, use DECLARE_TIMER and INIT_TIMER with their
+ * Don't use the macro below, use DECLARE_TIMER and INIT_TIMER with their
  * improved callback signature above.
  */
-#define __TIMER_INITIALIZER(_function, _expires, _data, _flags) { \
+#define DEFINE_TIMER(_name, _function, _expires, _data)		\
+	struct timer_list _name = {				\
 		.entry = { .next = TIMER_ENTRY_STATIC },	\
 		.function = (_function),			\
 		.expires = (_expires),				\
 		.data = (_data),				\
-		.flags = (_flags),				\
 		__TIMER_LOCKDEP_MAP_INITIALIZER(		\
 			__FILE__ ":" __stringify(__LINE__))	\
 	}
 
-#define TIMER_INITIALIZER(_function, _expires, _data)		\
-	__TIMER_INITIALIZER((_function), (_expires), (_data), 0)
-
-#define TIMER_PINNED_INITIALIZER(_function, _expires, _data)	\
-	__TIMER_INITIALIZER((_function), (_expires), (_data), TIMER_PINNED)
-
-#define TIMER_DEFERRED_INITIALIZER(_function, _expires, _data)	\
-	__TIMER_INITIALIZER((_function), (_expires), (_data), TIMER_DEFERRABLE)
-
-#define TIMER_PINNED_DEFERRED_INITIALIZER(_function, _expires, _data)	\
-	__TIMER_INITIALIZER((_function), (_expires), (_data), TIMER_DEFERRABLE | TIMER_PINNED)
-
-#define DEFINE_TIMER(_name, _function, _expires, _data)		\
-	struct timer_list _name =				\
-		TIMER_INITIALIZER(_function, _expires, _data)
-
 void init_timer_key(struct timer_list *timer, unsigned int flags,
 		    const char *name, struct lock_class_key *key);
 
-- 
2.11.0
