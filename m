Return-Path: <SRS0=yMf+=TD=vger.kernel.org=kvm-owner@kernel.org>
From: Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 5/7] s390/cio: Allow zero-length CCWs in vfio-ccw
Date: Fri,  3 May 2019 15:49:10 +0200
In-Reply-To: <20190503134912.39756-1-farman@linux.ibm.com>
References: <20190503134912.39756-1-farman@linux.ibm.com>
Message-Id: <20190503134912.39756-6-farman@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

It is possible that a guest might issue a CCW with a length of zero,
and will expect a particular response.  Consider this chain:

   Address   Format-1 CCW
   --------  -----------------
 0 33110EC0  346022CC 33177468
 1 33110EC8  CF200000 3318300C

CCW[0] moves a little more than two pages, but also has the
Suppress Length Indication (SLI) bit set to handle the expectation
that considerably less data will be moved.  CCW[1] also has the SLI
bit set, and has a length of zero.  Once vfio-ccw does its magic,
the kernel issues a start subchannel on behalf of the guest with this:

   Address   Format-1 CCW
   --------  -----------------
 0 021EDED0  346422CC 021F0000
 1 021EDED8  CF240000 3318300C

Both CCWs were converted to an IDAL and have the corresponding flags
set (which is by design), but only the address of the first data
address is converted to something the host is aware of.  The second
CCW still has the address used by the guest, which happens to be (A)
(probably) an invalid address for the host, and (B) an invalid IDAW
address (doubleword boundary, etc.).

While the I/O fails, it doesn't fail correctly.  In this example, we
would receive a program check for an invalid IDAW address, instead of
a unit check for an invalid command.

To fix this, revert commit 4cebc5d6a6ff ("vfio: ccw: validate the
count field of a ccw before pinning") and allow the individual fetch
routines to process them like anything else.  We'll make a slight
adjustment to our allocation of the pfn_array (for direct CCWs) or
IDAL (for IDAL CCWs) memory, so that we have room for at least one
address even though no data will be transferred.

Note that this doesn't provide us with a channel program that will
fail in the expected way.  Since our length is zero, vfio_pin_pages()
returns -EINVAL and cp_prefetch() will thus fail.  This will be fixed
in the next patch.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 43c6d1cf1653..c3fffac92aa1 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -70,9 +70,6 @@ static int pfn_array_alloc(struct pfn_array *pa, u64 iova, unsigned int len)
 {
 	int i;
 
-	if (!len)
-		return 0;
-
 	if (pa->pa_nr || pa->pa_iova_pfn)
 		return -EINVAL;
 
@@ -366,8 +363,6 @@ static void ccwchain_cda_free(struct ccwchain *chain, int idx)
 
 	if (ccw_is_test(ccw) || ccw_is_noop(ccw) || ccw_is_tic(ccw))
 		return;
-	if (!ccw->count)
-		return;
 
 	kfree((void *)(u64)ccw->cda);
 }
@@ -552,18 +547,12 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,
 	struct pfn_array_table *pat;
 	unsigned long *idaws;
 	int ret;
+	int bytes = 1;
 
 	ccw = chain->ch_ccw + idx;
 
-	if (!ccw->count) {
-		/*
-		 * We just want the translation result of any direct ccw
-		 * to be an IDA ccw, so let's add the IDA flag for it.
-		 * Although the flag will be ignored by firmware.
-		 */
-		ccw->flags |= CCW_FLAG_IDA;
-		return 0;
-	}
+	if (ccw->count)
+		bytes = ccw->count;
 
 	/*
 	 * Pin data page(s) in memory.
@@ -575,7 +564,7 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,
 	if (ret)
 		goto out_init;
 
-	ret = pfn_array_alloc(pat->pat_pa, ccw->cda, ccw->count);
+	ret = pfn_array_alloc(pat->pat_pa, ccw->cda, bytes);
 	if (ret < 0)
 		goto out_unpin;
 
@@ -614,17 +603,18 @@ static int ccwchain_fetch_idal(struct ccwchain *chain,
 	u64 idaw_iova;
 	unsigned int idaw_nr, idaw_len;
 	int i, ret;
+	int bytes = 1;
 
 	ccw = chain->ch_ccw + idx;
 
-	if (!ccw->count)
-		return 0;
+	if (ccw->count)
+		bytes = ccw->count;
 
 	/* Calculate size of idaws. */
 	ret = copy_from_iova(cp->mdev, &idaw_iova, ccw->cda, sizeof(idaw_iova));
 	if (ret)
 		return ret;
-	idaw_nr = idal_nr_words((void *)(idaw_iova), ccw->count);
+	idaw_nr = idal_nr_words((void *)(idaw_iova), bytes);
 	idaw_len = idaw_nr * sizeof(*idaws);
 
 	/* Pin data page(s) in memory. */
-- 
2.16.4
