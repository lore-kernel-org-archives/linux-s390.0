Return-Path: <BATV+d8c56d9a67374e13c9b4+5014+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 7/9] s390: switch lgr timer to a modern timer
Date: Tue, 16 May 2017 13:48:10 +0200
Message-Id: <20170516114812.10660-8-hch@lst.de>
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
 arch/s390/kernel/lgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/lgr.c b/arch/s390/kernel/lgr.c
index ae7dff110054..147124c05f28 100644
--- a/arch/s390/kernel/lgr.c
+++ b/arch/s390/kernel/lgr.c
@@ -153,14 +153,14 @@ static void lgr_timer_set(void);
 /*
  * LGR timer callback
  */
-static void lgr_timer_fn(unsigned long ignored)
+static void lgr_timer_fn(struct timer_list *timer)
 {
 	lgr_info_log();
 	lgr_timer_set();
 }
 
 static struct timer_list lgr_timer =
-	TIMER_DEFERRED_INITIALIZER(lgr_timer_fn, 0, 0);
+	INIT_TIMER(lgr_timer_fn, 0, TIMER_DEFERRABLE);
 
 /*
  * Setup next LGR timer
-- 
2.11.0
