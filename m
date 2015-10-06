From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 3/3] s390/qdio: fix WARN_ON_ONCE condition
Date: Tue,  6 Oct 2015 15:12:29 +0200
Message-ID: <1444137149-919-4-git-send-email-ubraun@linux.vnet.ibm.com>
References: <1444137149-919-1-git-send-email-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1444137149-919-1-git-send-email-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org, ursula.braun@de.ibm.com, ubraun@linux.vnet.ibm.com, Eugene Crosser <Eugene.Crosser@ru.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Eugene Crosser <Eugene.Crosser@ru.ibm.com

If HiperSockets Completion Queueing is enabled, qdio always
issues a warning, since the condition is always met.
This patch fixes the condition in WARN_ON_ONCE that was always
true.

Signed-off-by: Eugene Crosser <Eugene.Crosser@ru.ibm.com>
Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
---
 drivers/s390/cio/qdio_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index 848e3b6..4bb5262 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -319,6 +319,8 @@ static int qdio_siga_output(struct qdio_q *q, unsigned int *busy_bit,
 	int retries = 0, cc;
 	unsigned long laob = 0;
 
+	WARN_ON_ONCE(aob && ((queue_type(q) != QDIO_IQDIO_QFMT) ||
+			     !q->u.out.use_cq));
 	if (q->u.out.use_cq && aob != 0) {
 		fc = QDIO_SIGA_WRITEQ;
 		laob = aob;
@@ -329,8 +331,6 @@ static int qdio_siga_output(struct qdio_q *q, unsigned int *busy_bit,
 		fc |= QDIO_SIGA_QEBSM_FLAG;
 	}
 again:
-	WARN_ON_ONCE((aob && queue_type(q) != QDIO_IQDIO_QFMT) ||
-		(aob && fc != QDIO_SIGA_WRITEQ));
 	cc = do_siga_output(schid, q->mask, busy_bit, fc, laob);
 
 	/* hipersocket busy condition */
-- 
2.3.9
