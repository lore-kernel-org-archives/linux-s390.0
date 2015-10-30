From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v4 1/6] virtio-net: Stop doing DMA from the stack
Date: Fri, 30 Oct 2015 14:55:30 +0100
Message-ID: <563376D2.20502@de.ibm.com>
References: <cover.1446162273.git.luto@kernel.org>
 <8d6b1fc3b5d3b6f5e8b212ef690691a52fbefaff.1446162273.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <8d6b1fc3b5d3b6f5e8b212ef690691a52fbefaff.1446162273.git.luto@kernel.org>
Sender: sparclinux-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: Joerg Roedel <jroedel@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, dwmw2@infradead.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

Am 30.10.2015 um 02:09 schrieb Andy Lutomirski:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> 
> Once virtio starts using the DMA API, we won't be able to safely DMA
> from the stack.  virtio-net does a couple of config DMA requests
> from small stack buffers -- switch to using dynamically-allocated
> memory.
> 
> This should have no effect on any performance-critical code paths.
> 
> [I wrote the subject and commit message.  mst wrote the code. --luto]
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> signed-off-by: Michael S. Tsirkin <mst@redhat.com>

I still get an error when using multiqueue:

#  ethtool -L eth0 combined 4
[   33.534686] virtio_ccw 0.0.000d: DMA-API: device driver maps memory from stack [addr=00000000629e7c06]
[   33.534704] ------------[ cut here ]------------
[   33.534705] WARNING: at lib/dma-debug.c:1169
[   33.534706] Modules linked in: dm_multipath
[   33.534709] CPU: 1 PID: 1087 Comm: ethtool Not tainted 4.3.0-rc3+ #269
[   33.534710] task: 00000000616f9978 ti: 00000000629e4000 task.ti: 00000000629e4000
[   33.534712] Krnl PSW : 0704d00180000000 00000000005869d2 (check_for_stack+0xb2/0x118)
[   33.534716]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 EA:3
Krnl GPRS: 000000000000006a 0000000000d60f44 000000000000005a 0000000064ee0870
[   33.534718]            00000000005869ce 0000000000000000 0000000000000001 00000000629e7c06
[   33.534719]            0000000000000000 0000000000000c06 0000000000000002 000000006467f800
[   33.534720]            0000000064673428 00000000629e7c06 00000000005869ce 00000000629e7928
[   33.534726] Krnl Code: 00000000005869c2: c0200024ad4e	larl	%r2,a1c45e
           00000000005869c8: c0e5ffe6d6fc	brasl	%r14,2617c0
          #00000000005869ce: a7f40001		brc	15,5869d0
          >00000000005869d2: c010003465eb	larl	%r1,c135a8
           00000000005869d8: e31010000012	lt	%r1,0(%r1)
           00000000005869de: a784000a		brc	8,5869f2
           00000000005869e2: e340f0b00004	lg	%r4,176(%r15)
           00000000005869e8: ebcff0a00004	lmg	%r12,%r15,160(%r15)
[   33.534736] Call Trace:
[   33.534737] ([<00000000005869ce>] check_for_stack+0xae/0x118)
[   33.534738]  [<0000000000586e3c>] debug_dma_map_page+0x114/0x160
[   33.534740]  [<00000000005a31f8>] vring_map_one_sg.isra.7+0x98/0xc0
[   33.534742]  [<00000000005a3b72>] virtqueue_add_sgs+0x1e2/0x788
[   33.534744]  [<0000000000618afc>] virtnet_send_command+0xcc/0x140
[   33.534745]  [<0000000000618c0c>] virtnet_set_queues+0x9c/0x110
[   33.534747]  [<0000000000619928>] virtnet_set_channels+0x78/0xe0
[   33.534748]  [<00000000006f63ea>] ethtool_set_channels+0x62/0x88
[   33.534750]  [<00000000006f8900>] dev_ethtool+0x10d8/0x1a48
[   33.534752]  [<000000000070c540>] dev_ioctl+0x190/0x510
[   33.534754]  [<00000000006cf2da>] sock_do_ioctl+0x7a/0x90
[   33.534755]  [<00000000006cf840>] sock_ioctl+0x1e8/0x2d0
[   33.534758]  [<00000000002e6c78>] do_vfs_ioctl+0x3a8/0x508
[   33.534759]  [<00000000002e6e7c>] SyS_ioctl+0xa4/0xb8
[   33.534762]  [<00000000008231ec>] system_call+0x244/0x264
[   33.534763]  [<000003ff922026d2>] 0x3ff922026d2
[   33.534764] Last Breaking-Event-Address:
[   33.534765]  [<00000000005869ce>] check_for_stack+0xae/0x118
[   33.534766] ---[ end trace 2379df65f4decfc4 ]---


> ---
>  drivers/net/virtio_net.c | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d8838dedb7a4..f94ab786088f 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -140,6 +140,12 @@ struct virtnet_info {
> 
>  	/* CPU hot plug notifier */
>  	struct notifier_block nb;
> +
> +	/* Control VQ buffers: protected by the rtnl lock */
> +	struct virtio_net_ctrl_hdr ctrl_hdr;
> +	virtio_net_ctrl_ack ctrl_status;
> +	u8 ctrl_promisc;
> +	u8 ctrl_allmulti;
>  };
> 
>  struct padded_vnet_hdr {
> @@ -976,31 +982,30 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>  				 struct scatterlist *out)
>  {
>  	struct scatterlist *sgs[4], hdr, stat;
> -	struct virtio_net_ctrl_hdr ctrl;
> -	virtio_net_ctrl_ack status = ~0;
>  	unsigned out_num = 0, tmp;
> 
>  	/* Caller should know better */
>  	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
> 
> -	ctrl.class = class;
> -	ctrl.cmd = cmd;
> +	vi->ctrl_status = ~0;
> +	vi->ctrl_hdr.class = class;
> +	vi->ctrl_hdr.cmd = cmd;
>  	/* Add header */
> -	sg_init_one(&hdr, &ctrl, sizeof(ctrl));
> +	sg_init_one(&hdr, &vi->ctrl_hdr, sizeof(vi->ctrl_hdr));
>  	sgs[out_num++] = &hdr;
> 
>  	if (out)
>  		sgs[out_num++] = out;
> 
>  	/* Add return status. */
> -	sg_init_one(&stat, &status, sizeof(status));
> +	sg_init_one(&stat, &vi->ctrl_status, sizeof(vi->ctrl_status));
>  	sgs[out_num] = &stat;
> 
>  	BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
>  	virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, vi, GFP_ATOMIC);
> 
>  	if (unlikely(!virtqueue_kick(vi->cvq)))
> -		return status == VIRTIO_NET_OK;
> +		return vi->ctrl_status == VIRTIO_NET_OK;
> 
>  	/* Spin for a response, the kick causes an ioport write, trapping
>  	 * into the hypervisor, so the request should be handled immediately.
> @@ -1009,7 +1014,7 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>  	       !virtqueue_is_broken(vi->cvq))
>  		cpu_relax();
> 
> -	return status == VIRTIO_NET_OK;
> +	return vi->ctrl_status == VIRTIO_NET_OK;
>  }
> 
>  static int virtnet_set_mac_address(struct net_device *dev, void *p)
> @@ -1151,7 +1156,6 @@ static void virtnet_set_rx_mode(struct net_device *dev)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
>  	struct scatterlist sg[2];
> -	u8 promisc, allmulti;
>  	struct virtio_net_ctrl_mac *mac_data;
>  	struct netdev_hw_addr *ha;
>  	int uc_count;
> @@ -1163,22 +1167,22 @@ static void virtnet_set_rx_mode(struct net_device *dev)
>  	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
>  		return;
> 
> -	promisc = ((dev->flags & IFF_PROMISC) != 0);
> -	allmulti = ((dev->flags & IFF_ALLMULTI) != 0);
> +	vi->ctrl_promisc = ((dev->flags & IFF_PROMISC) != 0);
> +	vi->ctrl_allmulti = ((dev->flags & IFF_ALLMULTI) != 0);
> 
> -	sg_init_one(sg, &promisc, sizeof(promisc));
> +	sg_init_one(sg, &vi->ctrl_promisc, sizeof(vi->ctrl_promisc));
> 
>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
>  				  VIRTIO_NET_CTRL_RX_PROMISC, sg))
>  		dev_warn(&dev->dev, "Failed to %sable promisc mode.\n",
> -			 promisc ? "en" : "dis");
> +			 vi->ctrl_promisc ? "en" : "dis");
> 
> -	sg_init_one(sg, &allmulti, sizeof(allmulti));
> +	sg_init_one(sg, &vi->ctrl_allmulti, sizeof(vi->ctrl_allmulti));
> 
>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
>  				  VIRTIO_NET_CTRL_RX_ALLMULTI, sg))
>  		dev_warn(&dev->dev, "Failed to %sable allmulti mode.\n",
> -			 allmulti ? "en" : "dis");
> +			 vi->ctrl_allmulti ? "en" : "dis");
> 
>  	uc_count = netdev_uc_count(dev);
>  	mc_count = netdev_mc_count(dev);
> 
