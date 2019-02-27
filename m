From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 27 Feb 2019 10:57:10 +0000
Subject: [PULL 2/2] s390/cio: Use cpa range elsewhere within vfio-ccw
Message-Id: <20190227105710.20030-3-cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Eric Farman <farman@linux.ibm.com>

Since we have a little function to see whether a channel
program address falls within a range of CCWs, let's use
it in the other places of code that make these checks.

(Why isn't ccw_head fully removed?  Well, because this
way some longs lines don't have to be reflowed.)

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20190222183941.29596-3-farman@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 488b76cd6fb9..384b3987eeb4 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -443,13 +443,11 @@ static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
 static int tic_target_chain_exists(struct ccw1 *tic, struct channel_program *cp)
 {
 	struct ccwchain *chain;
-	u32 ccw_head, ccw_tail;
+	u32 ccw_head;
 
 	list_for_each_entry(chain, &cp->ccwchain_list, next) {
 		ccw_head = chain->ch_iova;
-		ccw_tail = ccw_head + (chain->ch_len - 1) * sizeof(struct ccw1);
-
-		if ((ccw_head <= tic->cda) && (tic->cda <= ccw_tail))
+		if (is_cpa_within_range(tic->cda, ccw_head, chain->ch_len))
 			return 1;
 	}
 
@@ -516,13 +514,11 @@ static int ccwchain_fetch_tic(struct ccwchain *chain,
 {
 	struct ccw1 *ccw = chain->ch_ccw + idx;
 	struct ccwchain *iter;
-	u32 ccw_head, ccw_tail;
+	u32 ccw_head;
 
 	list_for_each_entry(iter, &cp->ccwchain_list, next) {
 		ccw_head = iter->ch_iova;
-		ccw_tail = ccw_head + (iter->ch_len - 1) * sizeof(struct ccw1);
-
-		if ((ccw_head <= ccw->cda) && (ccw->cda <= ccw_tail)) {
+		if (is_cpa_within_range(ccw->cda, ccw_head, iter->ch_len)) {
 			ccw->cda = (__u32) (addr_t) (((char *)iter->ch_ccw) +
 						     (ccw->cda - ccw_head));
 			return 0;
@@ -864,7 +860,7 @@ void cp_update_scsw(struct channel_program *cp, union scsw *scsw)
 {
 	struct ccwchain *chain;
 	u32 cpa = scsw->cmd.cpa;
-	u32 ccw_head, ccw_tail;
+	u32 ccw_head;
 
 	/*
 	 * LATER:
@@ -874,9 +870,7 @@ void cp_update_scsw(struct channel_program *cp, union scsw *scsw)
 	 */
 	list_for_each_entry(chain, &cp->ccwchain_list, next) {
 		ccw_head = (u32)(u64)chain->ch_ccw;
-		ccw_tail = (u32)(u64)(chain->ch_ccw + chain->ch_len - 1);
-
-		if ((ccw_head <= cpa) && (cpa <= ccw_tail)) {
+		if (is_cpa_within_range(cpa, ccw_head, chain->ch_len)) {
 			/*
 			 * (cpa - ccw_head) is the offset value of the host
 			 * physical ccw to its chain head.
-- 
2.17.2
