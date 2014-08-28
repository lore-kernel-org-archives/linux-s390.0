From: Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v3 4/5] virtio_net: Don't set the end flag on reusable sg
	entries
Date: Thu, 28 Aug 2014 16:51:43 -0700
Message-ID: <1efdeaab3923726c34e0fbac7a6c6549e6cacff4.1409269667.git.luto@amacapital.net>
References: <cover.1409269667.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1409269667.git.luto@amacapital.net>
In-Reply-To: <cover.1409269667.git.luto@amacapital.net>
References: <cover.1409269667.git.luto@amacapital.net>
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
Cc: linux-s390@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, linux390@de.ibm.com, Andy Lutomirski <luto@amacapital.net>
List-ID: <linux-s390.vger.kernel.org>

Every time virtio_net calls skb_to_sgvec, an end flag gets set
somewhere on the queue's scatterlist and never gets cleared.  As
soon as a larger request happens, virtio_net sends the virtqueue a
scatterlist with an end mark set in the middle.  Once the vring code
starts using for_each_sg, this will blow up.

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 drivers/net/virtio_net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 960a2172b07a..25703fd2df28 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -548,7 +548,7 @@ static int add_recvbuf_small(struct receive_queue *rq, gfp_t gfp)
 	hdr = skb_vnet_hdr(skb);
 	sg_set_buf(rq->sg, &hdr->hdr, sizeof hdr->hdr);
 
-	skb_to_sgvec(skb, rq->sg + 1, 0, skb->len);
+	skb_to_sgvec_nomark(skb, rq->sg + 1, 0, skb->len);
 
 	err = virtqueue_add_inbuf(rq->vq, rq->sg, 2, skb, gfp);
 	if (err < 0)
@@ -901,12 +901,12 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 
 	if (can_push) {
 		__skb_push(skb, hdr_len);
-		num_sg = skb_to_sgvec(skb, sq->sg, 0, skb->len);
+		num_sg = skb_to_sgvec_nomark(skb, sq->sg, 0, skb->len);
 		/* Pull header back to avoid skew in tx bytes calculations. */
 		__skb_pull(skb, hdr_len);
 	} else {
 		sg_set_buf(sq->sg, hdr, hdr_len);
-		num_sg = skb_to_sgvec(skb, sq->sg + 1, 0, skb->len) + 1;
+		num_sg = skb_to_sgvec_nomark(skb, sq->sg + 1, 0, skb->len) + 1;
 	}
 	return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_ATOMIC);
 }
-- 
1.9.3
