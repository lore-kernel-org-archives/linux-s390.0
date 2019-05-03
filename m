Return-Path: <SRS0=yMf+=TD=vger.kernel.org=kvm-owner@kernel.org>
From: Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 6/7] s390/cio: Don't pin vfio pages for empty transfers
Date: Fri,  3 May 2019 15:49:11 +0200
In-Reply-To: <20190503134912.39756-1-farman@linux.ibm.com>
References: <20190503134912.39756-1-farman@linux.ibm.com>
Message-Id: <20190503134912.39756-7-farman@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

If a CCW has a count of zero, then no data will be transferred and
pinning/unpinning memory is unnecessary.

In addition to that, the skip flag of a CCW offers the possibility of
data not being transferred, but is only meaningful for certain commands.
Specifically, it is only applicable for a read, read backward, sense, or
sense ID CCW and will be ignored for any other command code
(SA22-7832-11 page 15-64, and figure 15-30 on page 15-75).

(A sense ID is xE4, while a sense is x04 with possible modifiers in the
upper four bits.  So we will cover the whole "family" of sense CCWs.)

For all those scenarios, since there is no requirement for the target
address to be valid, we should skip the call to vfio_pin_pages() and
rely on the IDAL address we have allocated/built for the channel
program.  The fact that the individual IDAWs within the IDAL are
invalid is fine, since they aren't actually checked in these cases.

Set pa_nr to zero, when skipping the pfn_array_pin() call, since it is
defined as the number of pages pinned.  This will cause the vfio unpin
logic to return -EINVAL, but since the return code is not checked it
will not harm our cleanup path.

As we do this, since the pfn_array_pin() routine returns the number of
pages pinned, and we might not be doing that, the logic for converting
a CCW from direct-addressed to IDAL needs to ensure there is room for
one IDAW in the IDAL being built since a zero-length IDAL isn't great.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 61 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index c3fffac92aa1..36d76b821209 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -285,6 +285,10 @@ static long copy_ccw_from_iova(struct channel_program *cp,
 /*
  * Helpers to operate ccwchain.
  */
+#define ccw_is_read(_ccw) (((_ccw)->cmd_code & 0x03) == 0x02)
+#define ccw_is_read_backward(_ccw) (((_ccw)->cmd_code & 0x0F) == 0x0C)
+#define ccw_is_sense(_ccw) (((_ccw)->cmd_code & 0x0F) == CCW_CMD_BASIC_SENSE)
+
 #define ccw_is_test(_ccw) (((_ccw)->cmd_code & 0x0F) == 0)
 
 #define ccw_is_noop(_ccw) ((_ccw)->cmd_code == CCW_CMD_NOOP)
@@ -292,10 +296,43 @@ static long copy_ccw_from_iova(struct channel_program *cp,
 #define ccw_is_tic(_ccw) ((_ccw)->cmd_code == CCW_CMD_TIC)
 
 #define ccw_is_idal(_ccw) ((_ccw)->flags & CCW_FLAG_IDA)
-
+#define ccw_is_skip(_ccw) ((_ccw)->flags & CCW_FLAG_SKIP)
 
 #define ccw_is_chain(_ccw) ((_ccw)->flags & (CCW_FLAG_CC | CCW_FLAG_DC))
 
+/*
+ * ccw_does_data_transfer()
+ *
+ * Determine whether a CCW will move any data, such that the guest pages
+ * would need to be pinned before performing the I/O.
+ *
+ * Returns 1 if yes, 0 if no.
+ */
+static inline int ccw_does_data_transfer(struct ccw1 *ccw)
+{
+	/* If the count field is zero, then no data will be transferred */
+	if (ccw->count == 0)
+		return 0;
+
+	/* If the skip flag is off, then data will be transferred */
+	if (!ccw_is_skip(ccw))
+		return 1;
+
+	/*
+	 * If the skip flag is on, it is only meaningful if the command
+	 * code is a read, read backward, sense, or sense ID.  In those
+	 * cases, no data will be transferred.
+	 */
+	if (ccw_is_read(ccw) || ccw_is_read_backward(ccw))
+		return 0;
+
+	if (ccw_is_sense(ccw))
+		return 0;
+
+	/* The skip flag is on, but it is ignored for this command code. */
+	return 1;
+}
+
 /*
  * is_cpa_within_range()
  *
@@ -548,11 +585,14 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,
 	unsigned long *idaws;
 	int ret;
 	int bytes = 1;
+	int idaw_nr = 1;
 
 	ccw = chain->ch_ccw + idx;
 
-	if (ccw->count)
+	if (ccw->count) {
 		bytes = ccw->count;
+		idaw_nr = idal_nr_words((void *)(u64)ccw->cda, ccw->count);
+	}
 
 	/*
 	 * Pin data page(s) in memory.
@@ -568,12 +608,16 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,
 	if (ret < 0)
 		goto out_unpin;
 
-	ret = pfn_array_pin(pat->pat_pa, cp->mdev);
-	if (ret < 0)
-		goto out_unpin;
+	if (ccw_does_data_transfer(ccw)) {
+		ret = pfn_array_pin(pat->pat_pa, cp->mdev);
+		if (ret < 0)
+			goto out_unpin;
+	} else {
+		pat->pat_pa->pa_nr = 0;
+	}
 
 	/* Translate this direct ccw to a idal ccw. */
-	idaws = kcalloc(ret, sizeof(*idaws), GFP_DMA | GFP_KERNEL);
+	idaws = kcalloc(idaw_nr, sizeof(*idaws), GFP_DMA | GFP_KERNEL);
 	if (!idaws) {
 		ret = -ENOMEM;
 		goto out_unpin;
@@ -644,6 +688,11 @@ static int ccwchain_fetch_idal(struct ccwchain *chain,
 		if (ret < 0)
 			goto out_free_idaws;
 
+		if (!ccw_does_data_transfer(ccw)) {
+			pa->pa_nr = 0;
+			continue;
+		}
+
 		ret = pfn_array_pin(pa, cp->mdev);
 		if (ret < 0)
 			goto out_free_idaws;
-- 
2.16.4
