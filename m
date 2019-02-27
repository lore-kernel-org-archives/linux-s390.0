From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 27 Feb 2019 10:57:09 +0000
Subject: [PULL 1/2] s390/cio: Fix vfio-ccw handling of recursive TICs
Message-Id: <20190227105710.20030-2-cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Eric Farman <farman@linux.ibm.com>

The routine ccwchain_calc_length() is tasked with looking at a
channel program, seeing how many CCWs are chained together by
the presence of the Chain-Command flag, and returning a count
to the caller.

Previously, it also considered a Transfer-in-Channel CCW as being
an appropriate mechanism for chaining.  The problem at the time
was that the TIC CCW will almost certainly not go to the next CCW
in memory (because the CC flag would be sufficient), and so
advancing to the next 8 bytes will cause us to read potentially
invalid memory.  So that comparison was removed, and the target
of the TIC is processed as a new chain.

This is fine when a TIC goes to a new chain (consider a NOP+TIC to
a channel program that is being redriven), but there is another
scenario where this falls apart.  A TIC can be used to "rewind"
a channel program, for example to find a particular record on a
disk with various orientation CCWs.  In this case, we DO want to
consider the memory after the TIC since the TIC will be skipped
once the requested criteria is met.  This is due to the Status
Modifier presented by the device, though software doesn't need to
operate on it beyond understanding the behavior change of how the
channel program is executed.

So to handle this, we will re-introduce the check for a TIC CCW
but limit it by examining the target of the TIC.  If the TIC
doesn't go back into the current chain, then current behavior
applies; we should stop counting CCWs and let the target of the
TIC be handled as a new chain.  But, if the TIC DOES go back into
the current chain, then we need to keep looking at the memory after
the TIC for when the channel breaks out of the TIC loop.  We can't
use tic_target_chain_exists() because the chain in question hasn't
been built yet, so we will redefine that comparison with some small
functions to make it more readable and to permit refactoring later.

Fixes: 405d566f98ae ("vfio-ccw: Don't assume there are more ccws after a TIC")
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20190222183941.29596-2-farman@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 37 +++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index ba08fe137c2e..488b76cd6fb9 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -283,6 +283,33 @@ static long copy_ccw_from_iova(struct channel_program *cp,
 
 #define ccw_is_chain(_ccw) ((_ccw)->flags & (CCW_FLAG_CC | CCW_FLAG_DC))
 
+/*
+ * is_cpa_within_range()
+ *
+ * @cpa: channel program address being questioned
+ * @head: address of the beginning of a CCW chain
+ * @len: number of CCWs within the chain
+ *
+ * Determine whether the address of a CCW (whether a new chain,
+ * or the target of a TIC) falls within a range (including the end points).
+ *
+ * Returns 1 if yes, 0 if no.
+ */
+static inline int is_cpa_within_range(u32 cpa, u32 head, int len)
+{
+	u32 tail = head + (len - 1) * sizeof(struct ccw1);
+
+	return (head <= cpa && cpa <= tail);
+}
+
+static inline int is_tic_within_range(struct ccw1 *ccw, u32 head, int len)
+{
+	if (!ccw_is_tic(ccw))
+		return 0;
+
+	return is_cpa_within_range(ccw->cda, head, len);
+}
+
 static struct ccwchain *ccwchain_alloc(struct channel_program *cp, int len)
 {
 	struct ccwchain *chain;
@@ -392,7 +419,15 @@ static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
 			return -EOPNOTSUPP;
 		}
 
-		if (!ccw_is_chain(ccw))
+		/*
+		 * We want to keep counting if the current CCW has the
+		 * command-chaining flag enabled, or if it is a TIC CCW
+		 * that loops back into the current chain.  The latter
+		 * is used for device orientation, where the CCW PRIOR to
+		 * the TIC can either jump to the TIC or a CCW immediately
+		 * after the TIC, depending on the results of its operation.
+		 */
+		if (!ccw_is_chain(ccw) && !is_tic_within_range(ccw, iova, cnt))
 			break;
 
 		ccw++;
-- 
2.17.2
