From: Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v2 1/4] virtio_ring: Remove sg_next indirection
Date: Wed, 27 Aug 2014 14:50:54 -0700
Message-ID: <37f797f9f79ae57f88b6b5ca9d0b28ce56f7e701.1409176034.git.luto@amacapital.net>
References: <cover.1409176034.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1409176034.git.luto@amacapital.net>
In-Reply-To: <cover.1409176034.git.luto@amacapital.net>
References: <cover.1409176034.git.luto@amacapital.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/virtualization/>
List-Post: <mailto:virtualization@lists.linuxfoundation.org>
To: Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-s390@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Andy Lutomirski <luto@amacapital.net>, virtio-dev@lists.oasis-open.org
List-ID: <linux-s390.vger.kernel.org>

The only unusual thing about virtio's use of scatterlists is that
two of the APIs accept scatterlists that might not be terminated.
Using function pointers to handle this case is overkill; for_each_sg
can do it.

There's a small subtlely here: for_each_sg assumes that the provided
count is correct, but, because of the way that virtio_ring handles
multiple scatterlists at once, the count is only an upper bound if
there is more than one scatterlist.  This is easily solved by
checking the sg pointer for NULL on each iteration.

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 drivers/virtio/virtio_ring.c | 46 +++++++++++++++++---------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 4d08f45a9c29..d356a701c9c2 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -99,25 +99,9 @@ struct vring_virtqueue
 
 #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
 
-static inline struct scatterlist *sg_next_chained(struct scatterlist *sg,
-						  unsigned int *count)
-{
-	return sg_next(sg);
-}
-
-static inline struct scatterlist *sg_next_arr(struct scatterlist *sg,
-					      unsigned int *count)
-{
-	if (--(*count) == 0)
-		return NULL;
-	return sg + 1;
-}
-
 /* Set up an indirect table of descriptors and add it to the queue. */
 static inline int vring_add_indirect(struct vring_virtqueue *vq,
 				     struct scatterlist *sgs[],
-				     struct scatterlist *(*next)
-				       (struct scatterlist *, unsigned int *),
 				     unsigned int total_sg,
 				     unsigned int total_out,
 				     unsigned int total_in,
@@ -128,7 +112,7 @@ static inline int vring_add_indirect(struct vring_virtqueue *vq,
 	struct vring_desc *desc;
 	unsigned head;
 	struct scatterlist *sg;
-	int i, n;
+	int i, j, n;
 
 	/*
 	 * We require lowmem mappings for the descriptors because
@@ -144,7 +128,9 @@ static inline int vring_add_indirect(struct vring_virtqueue *vq,
 	/* Transfer entries from the sg lists into the indirect page */
 	i = 0;
 	for (n = 0; n < out_sgs; n++) {
-		for (sg = sgs[n]; sg; sg = next(sg, &total_out)) {
+		for_each_sg(sgs[n], sg, total_out, j) {
+			if (!sg)
+				break;
 			desc[i].flags = VRING_DESC_F_NEXT;
 			desc[i].addr = sg_phys(sg);
 			desc[i].len = sg->length;
@@ -153,7 +139,9 @@ static inline int vring_add_indirect(struct vring_virtqueue *vq,
 		}
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
-		for (sg = sgs[n]; sg; sg = next(sg, &total_in)) {
+		for_each_sg(sgs[n], sg, total_in, j) {
+			if (!sg)
+				break;
 			desc[i].flags = VRING_DESC_F_NEXT|VRING_DESC_F_WRITE;
 			desc[i].addr = sg_phys(sg);
 			desc[i].len = sg->length;
@@ -186,8 +174,6 @@ static inline int vring_add_indirect(struct vring_virtqueue *vq,
 
 static inline int virtqueue_add(struct virtqueue *_vq,
 				struct scatterlist *sgs[],
-				struct scatterlist *(*next)
-				  (struct scatterlist *, unsigned int *),
 				unsigned int total_out,
 				unsigned int total_in,
 				unsigned int out_sgs,
@@ -197,7 +183,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct scatterlist *sg;
-	unsigned int i, n, avail, uninitialized_var(prev), total_sg;
+	unsigned int i, j, n, avail, uninitialized_var(prev), total_sg;
 	int head;
 
 	START_USE(vq);
@@ -227,7 +213,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	/* If the host supports indirect descriptor tables, and we have multiple
 	 * buffers, then go indirect. FIXME: tune this threshold */
 	if (vq->indirect && total_sg > 1 && vq->vq.num_free) {
-		head = vring_add_indirect(vq, sgs, next, total_sg, total_out,
+		head = vring_add_indirect(vq, sgs, total_sg, total_out,
 					  total_in,
 					  out_sgs, in_sgs, gfp);
 		if (likely(head >= 0))
@@ -254,7 +240,9 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 
 	head = i = vq->free_head;
 	for (n = 0; n < out_sgs; n++) {
-		for (sg = sgs[n]; sg; sg = next(sg, &total_out)) {
+		for_each_sg(sgs[n], sg, total_out, j) {
+			if (!sg)
+				break;
 			vq->vring.desc[i].flags = VRING_DESC_F_NEXT;
 			vq->vring.desc[i].addr = sg_phys(sg);
 			vq->vring.desc[i].len = sg->length;
@@ -263,7 +251,9 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 		}
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
-		for (sg = sgs[n]; sg; sg = next(sg, &total_in)) {
+		for_each_sg(sgs[n], sg, total_in, j) {
+			if (!sg)
+				break;
 			vq->vring.desc[i].flags = VRING_DESC_F_NEXT|VRING_DESC_F_WRITE;
 			vq->vring.desc[i].addr = sg_phys(sg);
 			vq->vring.desc[i].len = sg->length;
@@ -337,7 +327,7 @@ int virtqueue_add_sgs(struct virtqueue *_vq,
 		for (sg = sgs[i]; sg; sg = sg_next(sg))
 			total_in++;
 	}
-	return virtqueue_add(_vq, sgs, sg_next_chained,
+	return virtqueue_add(_vq, sgs,
 			     total_out, total_in, out_sgs, in_sgs, data, gfp);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
@@ -360,7 +350,7 @@ int virtqueue_add_outbuf(struct virtqueue *vq,
 			 void *data,
 			 gfp_t gfp)
 {
-	return virtqueue_add(vq, &sg, sg_next_arr, num, 0, 1, 0, data, gfp);
+	return virtqueue_add(vq, &sg, num, 0, 1, 0, data, gfp);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
 
@@ -382,7 +372,7 @@ int virtqueue_add_inbuf(struct virtqueue *vq,
 			void *data,
 			gfp_t gfp)
 {
-	return virtqueue_add(vq, &sg, sg_next_arr, 0, num, 0, 1, data, gfp);
+	return virtqueue_add(vq, &sg, 0, num, 0, 1, data, gfp);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
 
-- 
1.9.3
