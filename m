From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v4 1/6] virtio-net: Stop doing DMA from the stack
Date: Thu, 29 Oct 2015 18:09:46 -0700
Message-ID: <8d6b1fc3b5d3b6f5e8b212ef690691a52fbefaff.1446162273.git.luto@kernel.org>
References: <cover.1446162273.git.luto@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1446162273.git.luto@kernel.org>
In-Reply-To: <cover.1446162273.git.luto@kernel.org>
References: <cover.1446162273.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: Joerg Roedel <jroedel@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, dwmw2@infradead.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

From: "Michael S. Tsirkin" <mst@redhat.com>

Once virtio starts using the DMA API, we won't be able to safely DMA
from the stack.  virtio-net does a couple of config DMA requests
from small stack buffers -- switch to using dynamically-allocated
memory.

This should have no effect on any performance-critical code paths.

[I wrote the subject and commit message.  mst wrote the code. --luto]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d8838dedb7a4..f94ab786088f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -140,6 +140,12 @@ struct virtnet_info {
 
 	/* CPU hot plug notifier */
 	struct notifier_block nb;
+
+	/* Control VQ buffers: protected by the rtnl lock */
+	struct virtio_net_ctrl_hdr ctrl_hdr;
+	virtio_net_ctrl_ack ctrl_status;
+	u8 ctrl_promisc;
+	u8 ctrl_allmulti;
 };
 
 struct padded_vnet_hdr {
@@ -976,31 +982,30 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 				 struct scatterlist *out)
 {
 	struct scatterlist *sgs[4], hdr, stat;
-	struct virtio_net_ctrl_hdr ctrl;
-	virtio_net_ctrl_ack status = ~0;
 	unsigned out_num = 0, tmp;
 
 	/* Caller should know better */
 	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
 
-	ctrl.class = class;
-	ctrl.cmd = cmd;
+	vi->ctrl_status = ~0;
+	vi->ctrl_hdr.class = class;
+	vi->ctrl_hdr.cmd = cmd;
 	/* Add header */
-	sg_init_one(&hdr, &ctrl, sizeof(ctrl));
+	sg_init_one(&hdr, &vi->ctrl_hdr, sizeof(vi->ctrl_hdr));
 	sgs[out_num++] = &hdr;
 
 	if (out)
 		sgs[out_num++] = out;
 
 	/* Add return status. */
-	sg_init_one(&stat, &status, sizeof(status));
+	sg_init_one(&stat, &vi->ctrl_status, sizeof(vi->ctrl_status));
 	sgs[out_num] = &stat;
 
 	BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
 	virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, vi, GFP_ATOMIC);
 
 	if (unlikely(!virtqueue_kick(vi->cvq)))
-		return status == VIRTIO_NET_OK;
+		return vi->ctrl_status == VIRTIO_NET_OK;
 
 	/* Spin for a response, the kick causes an ioport write, trapping
 	 * into the hypervisor, so the request should be handled immediately.
@@ -1009,7 +1014,7 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 	       !virtqueue_is_broken(vi->cvq))
 		cpu_relax();
 
-	return status == VIRTIO_NET_OK;
+	return vi->ctrl_status == VIRTIO_NET_OK;
 }
 
 static int virtnet_set_mac_address(struct net_device *dev, void *p)
@@ -1151,7 +1156,6 @@ static void virtnet_set_rx_mode(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct scatterlist sg[2];
-	u8 promisc, allmulti;
 	struct virtio_net_ctrl_mac *mac_data;
 	struct netdev_hw_addr *ha;
 	int uc_count;
@@ -1163,22 +1167,22 @@ static void virtnet_set_rx_mode(struct net_device *dev)
 	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
 		return;
 
-	promisc = ((dev->flags & IFF_PROMISC) != 0);
-	allmulti = ((dev->flags & IFF_ALLMULTI) != 0);
+	vi->ctrl_promisc = ((dev->flags & IFF_PROMISC) != 0);
+	vi->ctrl_allmulti = ((dev->flags & IFF_ALLMULTI) != 0);
 
-	sg_init_one(sg, &promisc, sizeof(promisc));
+	sg_init_one(sg, &vi->ctrl_promisc, sizeof(vi->ctrl_promisc));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
 				  VIRTIO_NET_CTRL_RX_PROMISC, sg))
 		dev_warn(&dev->dev, "Failed to %sable promisc mode.\n",
-			 promisc ? "en" : "dis");
+			 vi->ctrl_promisc ? "en" : "dis");
 
-	sg_init_one(sg, &allmulti, sizeof(allmulti));
+	sg_init_one(sg, &vi->ctrl_allmulti, sizeof(vi->ctrl_allmulti));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
 				  VIRTIO_NET_CTRL_RX_ALLMULTI, sg))
 		dev_warn(&dev->dev, "Failed to %sable allmulti mode.\n",
-			 allmulti ? "en" : "dis");
+			 vi->ctrl_allmulti ? "en" : "dis");
 
 	uc_count = netdev_uc_count(dev);
 	mc_count = netdev_mc_count(dev);
-- 
2.4.3
