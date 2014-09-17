From: Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v5 3/3] virtio_net: Stop doing DMA from the stack
Date: Tue, 16 Sep 2014 22:22:28 -0700
Message-ID: <7c8855d4d09135119738d042ef396b4903998292.1410931077.git.luto@amacapital.net>
References: <cover.1410931077.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1410931077.git.luto@amacapital.net>
In-Reply-To: <cover.1410931077.git.luto@amacapital.net>
References: <cover.1410931077.git.luto@amacapital.net>
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

Now that virtio supports real DMA, drivers should play by the rules.
For virtio_net, that means that DMA should be done to and from
dynamically-allocated memory, not the kernel stack.

This should have no effect on any performance-critical code paths.

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 drivers/net/virtio_net.c | 53 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3d0ce4468ce6..0bda62be5fe0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -971,31 +971,43 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 				 struct scatterlist *out)
 {
 	struct scatterlist *sgs[4], hdr, stat;
-	struct virtio_net_ctrl_hdr ctrl;
-	virtio_net_ctrl_ack status = ~0;
+
+	struct {
+		struct virtio_net_ctrl_hdr ctrl;
+		virtio_net_ctrl_ack status;
+	} *buf;
+
 	unsigned out_num = 0, tmp;
+	bool ret;
 
 	/* Caller should know better */
 	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
 
-	ctrl.class = class;
-	ctrl.cmd = cmd;
+	buf = kmalloc(sizeof(*buf), GFP_ATOMIC);
+	if (!buf)
+		return false;
+	buf->status = ~0;
+
+	buf->ctrl.class = class;
+	buf->ctrl.cmd = cmd;
 	/* Add header */
-	sg_init_one(&hdr, &ctrl, sizeof(ctrl));
+	sg_init_one(&hdr, &buf->ctrl, sizeof(buf->ctrl));
 	sgs[out_num++] = &hdr;
 
 	if (out)
 		sgs[out_num++] = out;
 
 	/* Add return status. */
-	sg_init_one(&stat, &status, sizeof(status));
+	sg_init_one(&stat, &buf->status, sizeof(buf->status));
 	sgs[out_num] = &stat;
 
 	BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
 	virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, vi, GFP_ATOMIC);
 
-	if (unlikely(!virtqueue_kick(vi->cvq)))
-		return status == VIRTIO_NET_OK;
+	if (unlikely(!virtqueue_kick(vi->cvq))) {
+		ret = (buf->status == VIRTIO_NET_OK);
+		goto out;
+	}
 
 	/* Spin for a response, the kick causes an ioport write, trapping
 	 * into the hypervisor, so the request should be handled immediately.
@@ -1004,7 +1016,11 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 	       !virtqueue_is_broken(vi->cvq))
 		cpu_relax();
 
-	return status == VIRTIO_NET_OK;
+	ret = (buf->status == VIRTIO_NET_OK);
+
+out:
+	kfree(buf);
+	return ret;
 }
 
 static int virtnet_set_mac_address(struct net_device *dev, void *p)
@@ -1145,7 +1161,7 @@ static void virtnet_set_rx_mode(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct scatterlist sg[2];
-	u8 promisc, allmulti;
+	u8 *cmdbyte;
 	struct virtio_net_ctrl_mac *mac_data;
 	struct netdev_hw_addr *ha;
 	int uc_count;
@@ -1157,22 +1173,25 @@ static void virtnet_set_rx_mode(struct net_device *dev)
 	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
 		return;
 
-	promisc = ((dev->flags & IFF_PROMISC) != 0);
-	allmulti = ((dev->flags & IFF_ALLMULTI) != 0);
+	cmdbyte = kmalloc(sizeof(*cmdbyte), GFP_ATOMIC);
+	if (!cmdbyte)
+		return;
 
-	sg_init_one(sg, &promisc, sizeof(promisc));
+	sg_init_one(sg, cmdbyte, sizeof(*cmdbyte));
 
+	*cmdbyte = ((dev->flags & IFF_PROMISC) != 0);
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
 				  VIRTIO_NET_CTRL_RX_PROMISC, sg))
 		dev_warn(&dev->dev, "Failed to %sable promisc mode.\n",
-			 promisc ? "en" : "dis");
-
-	sg_init_one(sg, &allmulti, sizeof(allmulti));
+			 *cmdbyte ? "en" : "dis");
 
+	*cmdbyte = ((dev->flags & IFF_ALLMULTI) != 0);
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
 				  VIRTIO_NET_CTRL_RX_ALLMULTI, sg))
 		dev_warn(&dev->dev, "Failed to %sable allmulti mode.\n",
-			 allmulti ? "en" : "dis");
+			 *cmdbyte ? "en" : "dis");
+
+	kfree(cmdbyte);
 
 	uc_count = netdev_uc_count(dev);
 	mc_count = netdev_mc_count(dev);
-- 
1.9.3
