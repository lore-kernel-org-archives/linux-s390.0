Return-Path: <BATV+d8c56d9a67374e13c9b4+5014+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6/9] s390: switch topology_timer to a modern timer
Date: Tue, 16 May 2017 13:48:09 +0200
Message-Id: <20170516114812.10660-7-hch@lst.de>
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
 arch/s390/kernel/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index bb47c92476f0..4a0e867fca2b 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -289,7 +289,7 @@ void topology_schedule_update(void)
 	schedule_work(&topology_work);
 }
 
-static void topology_timer_fn(unsigned long ignored)
+static void topology_timer_fn(struct timer_list *timer)
 {
 	if (ptf(PTF_CHECK))
 		topology_schedule_update();
@@ -297,7 +297,7 @@ static void topology_timer_fn(unsigned long ignored)
 }
 
 static struct timer_list topology_timer =
-	TIMER_DEFERRED_INITIALIZER(topology_timer_fn, 0, 0);
+	INIT_TIMER(topology_timer_fn, 0, TIMER_DEFERRABLE);
 
 static atomic_t topology_poll = ATOMIC_INIT(0);
 
-- 
2.11.0
