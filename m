From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/3] virtio_ring: Remove sg_next indirection
Date: Mon, 01 Sep 2014 10:28:55 +0930
Message-ID: <87fvgckvg0.fsf@rustcorp.com.au>
References: <cover.1409087794.git.luto@amacapital.net>
	<37f797f9f79ae57f88b6b5ca9d0b28ce56f7e701.1409087794.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <37f797f9f79ae57f88b6b5ca9d0b28ce56f7e701.1409087794.git.luto@amacapital.net>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-s390@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, virtualization@lists.linux-foundation.org, linux390@de.ibm.com, Andy Lutomirski <luto@amacapital.net>
List-ID: <linux-s390.vger.kernel.org>

Andy Lutomirski <luto@amacapital.net> writes:
> The only unusual thing about virtio's use of scatterlists is that
> two of the APIs accept scatterlists that might not be terminated.
> Using function pointers to handle this case is overkill; for_each_sg
> can do it.
>
> There's a small subtlely here: for_each_sg assumes that the provided
> count is correct, but, because of the way that virtio_ring handles
> multiple scatterlists at once, the count is only an upper bound if
> there is more than one scatterlist.  This is easily solved by
> checking the sg pointer for NULL on each iteration.

Hi Andy,

        (Sorry for the delayed response; I was still catching up from
my week at KS.)

Unfortunately the reason we dance through so many hoops here is that
it has a measurable performance impact :(  Those indirect calls get inlined.  

There's only one place which actually uses a weirdly-formed sg now,
and that's virtio_net.  It's pretty trivial to fix.

However, vring_bench drops 15% when we do this.  There's a larger
question as to how much difference that makes in Real Life, of course.
I'll measure that today.

Here are my two patches, back-to-back (it cam out of of an earlier
concern about reducing stack usage, hence the stack measurements).

Cheers,
Rusty.

Subject: virtio_net: pass well-formed sg to virtqueue_add_inbuf()

This is the only place which doesn't hand virtqueue_add_inbuf or
virtqueue_add_outbuf a well-formed, well-terminated sg.  Fix it,
so we can make virtio_add_* simpler.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8a852b5f215f..63299b04cdf2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -590,6 +590,8 @@ static int add_recvbuf_big(struct receive_queue *rq, gfp_t gfp)
 	offset = sizeof(struct padded_vnet_hdr);
 	sg_set_buf(&rq->sg[1], p + offset, PAGE_SIZE - offset);
 
+	sg_mark_end(&rq->sg[MAX_SKB_FRAGS + 2 - 1]);
+
 	/* chain first in list head */
 	first->private = (unsigned long)list;
 	err = virtqueue_add_inbuf(rq->vq, rq->sg, MAX_SKB_FRAGS + 2,

Subject: virtio_ring: assume sgs are always well-formed.

We used to have several callers which just used arrays.  They're
gone, so we can use sg_next() everywhere, simplifying the code.

Before:
	gcc 4.8.2: virtio_blk: stack used = 392
	gcc 4.6.4: virtio_blk: stack used = 528

After:
	gcc 4.8.2: virtio_blk: stack used = 392
	gcc 4.6.4: virtio_blk: stack used = 480

vring_bench before:
	936153354-967745359(9.44739e+08+/-6.1e+06)ns
vring_bench after:
	1061485790-1104800648(1.08254e+09+/-6.6e+06)ns

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 8e531578065f..a6cdb52ae9b2 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -107,28 +107,10 @@ struct vring_virtqueue
 
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
-				     unsigned int total_out,
-				     unsigned int total_in,
 				     unsigned int out_sgs,
 				     unsigned int in_sgs,
 				     gfp_t gfp)
@@ -155,7 +137,7 @@ static inline int vring_add_indirect(struct vring_virtqueue *vq,
 	/* Transfer entries from the sg lists into the indirect page */
 	i = 0;
 	for (n = 0; n < out_sgs; n++) {
-		for (sg = sgs[n]; sg; sg = next(sg, &total_out)) {
+		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
 			desc[i].flags = VRING_DESC_F_NEXT;
 			desc[i].addr = sg_phys(sg);
 			desc[i].len = sg->length;
@@ -164,7 +146,7 @@ static inline int vring_add_indirect(struct vring_virtqueue *vq,
 		}
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
-		for (sg = sgs[n]; sg; sg = next(sg, &total_in)) {
+		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
 			desc[i].flags = VRING_DESC_F_NEXT|VRING_DESC_F_WRITE;
 			desc[i].addr = sg_phys(sg);
 			desc[i].len = sg->length;
@@ -197,10 +179,7 @@ static inline int vring_add_indirect(struct vring_virtqueue *vq,
 
 static inline int virtqueue_add(struct virtqueue *_vq,
 				struct scatterlist *sgs[],
-				struct scatterlist *(*next)
-				  (struct scatterlist *, unsigned int *),
-				unsigned int total_out,
-				unsigned int total_in,
+				unsigned int total_sg,
 				unsigned int out_sgs,
 				unsigned int in_sgs,
 				void *data,
@@ -208,7 +187,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct scatterlist *sg;
-	unsigned int i, n, avail, uninitialized_var(prev), total_sg;
+	unsigned int i, n, avail, uninitialized_var(prev);
 	int head;
 
 	START_USE(vq);
@@ -233,13 +212,10 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	}
 #endif
 
-	total_sg = total_in + total_out;
-
 	/* If the host supports indirect descriptor tables, and we have multiple
 	 * buffers, then go indirect. FIXME: tune this threshold */
 	if (vq->indirect && total_sg > 1 && vq->vq.num_free) {
-		head = vring_add_indirect(vq, sgs, next, total_sg, total_out,
-					  total_in,
+		head = vring_add_indirect(vq, sgs, total_sg, 
 					  out_sgs, in_sgs, gfp);
 		if (likely(head >= 0))
 			goto add_head;
@@ -265,7 +241,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 
 	head = i = vq->free_head;
 	for (n = 0; n < out_sgs; n++) {
-		for (sg = sgs[n]; sg; sg = next(sg, &total_out)) {
+		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
 			vq->vring.desc[i].flags = VRING_DESC_F_NEXT;
 			vq->vring.desc[i].addr = sg_phys(sg);
 			vq->vring.desc[i].len = sg->length;
@@ -274,7 +250,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 		}
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
-		for (sg = sgs[n]; sg; sg = next(sg, &total_in)) {
+		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
 			vq->vring.desc[i].flags = VRING_DESC_F_NEXT|VRING_DESC_F_WRITE;
 			vq->vring.desc[i].addr = sg_phys(sg);
 			vq->vring.desc[i].len = sg->length;
@@ -335,29 +311,23 @@ int virtqueue_add_sgs(struct virtqueue *_vq,
 		      void *data,
 		      gfp_t gfp)
 {
-	unsigned int i, total_out, total_in;
+	unsigned int i, total_sg = 0;
 
 	/* Count them first. */
-	for (i = total_out = total_in = 0; i < out_sgs; i++) {
-		struct scatterlist *sg;
-		for (sg = sgs[i]; sg; sg = sg_next(sg))
-			total_out++;
-	}
-	for (; i < out_sgs + in_sgs; i++) {
+	for (i = 0; i < out_sgs + in_sgs; i++) {
 		struct scatterlist *sg;
 		for (sg = sgs[i]; sg; sg = sg_next(sg))
-			total_in++;
+			total_sg++;
 	}
-	return virtqueue_add(_vq, sgs, sg_next_chained,
-			     total_out, total_in, out_sgs, in_sgs, data, gfp);
+	return virtqueue_add(_vq, sgs, total_sg, out_sgs, in_sgs, data, gfp);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
 
 /**
  * virtqueue_add_outbuf - expose output buffers to other end
  * @vq: the struct virtqueue we're talking about.
- * @sgs: array of scatterlists (need not be terminated!)
- * @num: the number of scatterlists readable by other side
+ * @sg: scatterlist (must be well-formed and terminated!)
+ * @num: the number of entries in @sg readable by other side
  * @data: the token identifying the buffer.
  * @gfp: how to do memory allocations (if necessary).
  *
@@ -367,19 +337,19 @@ EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
  * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
  */
 int virtqueue_add_outbuf(struct virtqueue *vq,
-			 struct scatterlist sg[], unsigned int num,
+			 struct scatterlist *sg, unsigned int num,
 			 void *data,
 			 gfp_t gfp)
 {
-	return virtqueue_add(vq, &sg, sg_next_arr, num, 0, 1, 0, data, gfp);
+	return virtqueue_add(vq, &sg, num, 1, 0, data, gfp);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
 
 /**
  * virtqueue_add_inbuf - expose input buffers to other end
  * @vq: the struct virtqueue we're talking about.
- * @sgs: array of scatterlists (need not be terminated!)
- * @num: the number of scatterlists writable by other side
+ * @sg: scatterlist (must be well-formed and terminated!)
+ * @num: the number of entries in @sg writable by other side
  * @data: the token identifying the buffer.
  * @gfp: how to do memory allocations (if necessary).
  *
@@ -389,11 +359,11 @@ EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
  * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
  */
 int virtqueue_add_inbuf(struct virtqueue *vq,
-			struct scatterlist sg[], unsigned int num,
+			struct scatterlist *sg, unsigned int num,
 			void *data,
 			gfp_t gfp)
 {
-	return virtqueue_add(vq, &sg, sg_next_arr, 0, num, 0, 1, data, gfp);
+	return virtqueue_add(vq, &sg, num, 0, 1, data, gfp);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
