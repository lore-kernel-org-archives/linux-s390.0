From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 1/1] vfio: ccw: fix cleanup if cp_prefetch fails
Date: Tue, 24 Apr 2018 13:26:56 +0200
Message-ID: <20180424112656.10243-2-cohuck@redhat.com>
References: <20180424112656.10243-1-cohuck@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180424112656.10243-1-cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Halil Pasic <pasic@linux.vnet.ibm.com>, stable@vger.kernel.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

If the translation of a channel program fails, we may end up attempting
to clean up (free, unpin) stuff that never got translated (and allocated,
pinned) in the first place.

By adjusting the lengths of the chains accordingly (so the element that
failed, and all subsequent elements are excluded) cleanup activities
based on false assumptions can be avoided.

Let's make sure cp_free works properly after cp_prefetch returns with an
error by setting ch_len of a ccw chain to the number of the translated
CCWs on that chain.

Cc: stable@vger.kernel.org #v4.12+
Acked-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20180423110113.59385-2-bjsdjshi@linux.vnet.ibm.com>
[CH: fixed typos]
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 2c7550797ec2..dce92b2a895d 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -715,6 +715,10 @@ void cp_free(struct channel_program *cp)
  * and stores the result to ccwchain list. @cp must have been
  * initialized by a previous call with cp_init(). Otherwise, undefined
  * behavior occurs.
+ * For each chain composing the channel program:
+ * - On entry ch_len holds the count of CCWs to be translated.
+ * - On exit ch_len is adjusted to the count of successfully translated CCWs.
+ * This allows cp_free to find in ch_len the count of CCWs to free in a chain.
  *
  * The S/390 CCW Translation APIS (prefixed by 'cp_') are introduced
  * as helpers to do ccw chain translation inside the kernel. Basically
@@ -749,11 +753,18 @@ int cp_prefetch(struct channel_program *cp)
 		for (idx = 0; idx < len; idx++) {
 			ret = ccwchain_fetch_one(chain, idx, cp);
 			if (ret)
-				return ret;
+				goto out_err;
 		}
 	}
 
 	return 0;
+out_err:
+	/* Only cleanup the chain elements that were actually translated. */
+	chain->ch_len = idx;
+	list_for_each_entry_continue(chain, &cp->ccwchain_list, next) {
+		chain->ch_len = 0;
+	}
+	return ret;
 }
 
 /**
-- 
2.14.3
