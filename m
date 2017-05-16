Return-Path: <BATV+d8c56d9a67374e13c9b4+5014+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/9] kthread: remove unused macros
Date: Tue, 16 May 2017 13:48:06 +0200
Message-Id: <20170516114812.10660-4-hch@lst.de>
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

KTHREAD_DELAYED_WORK_INIT and DEFINE_KTHREAD_DELAYED_WORK are unused
and are using a timer helper that's about to go away.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/kthread.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 4fec8b775895..acb6edb4b4b4 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -114,23 +114,12 @@ struct kthread_delayed_work {
 	.func = (fn),							\
 	}
 
-#define KTHREAD_DELAYED_WORK_INIT(dwork, fn) {				\
-	.work = KTHREAD_WORK_INIT((dwork).work, (fn)),			\
-	.timer = __TIMER_INITIALIZER(kthread_delayed_work_timer_fn,	\
-				     0, (unsigned long)&(dwork),	\
-				     TIMER_IRQSAFE),			\
-	}
-
 #define DEFINE_KTHREAD_WORKER(worker)					\
 	struct kthread_worker worker = KTHREAD_WORKER_INIT(worker)
 
 #define DEFINE_KTHREAD_WORK(work, fn)					\
 	struct kthread_work work = KTHREAD_WORK_INIT(work, fn)
 
-#define DEFINE_KTHREAD_DELAYED_WORK(dwork, fn)				\
-	struct kthread_delayed_work dwork =				\
-		KTHREAD_DELAYED_WORK_INIT(dwork, fn)
-
 /*
  * kthread_worker.lock needs its own lockdep class key when defined on
  * stack with lockdep enabled.  Use the following macros in such cases.
-- 
2.11.0
