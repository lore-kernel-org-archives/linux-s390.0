From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 2/3] virtio_ring: Support DMA APIs
Date: Wed, 28 Oct 2015 14:52:48 +0900
Message-ID: <563062B0.5070608@de.ibm.com>
References: <cover.1446009834.git.luto@kernel.org>
 <ef92832ae3e58afb161a92858dc8428e6a0f63b5.1446009834.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ef92832ae3e58afb161a92858dc8428e6a0f63b5.1446009834.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <jroedel@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, dwmw2@infradead.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Am 28.10.2015 um 14:30 schrieb Andy Lutomirski:

> +static void vring_unmap_one(const struct vring_virtqueue *vq,
> +			    struct vring_desc *desc)
> +{
> +	u16 flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
> +
> +	if (flags & VRING_DESC_F_INDIRECT) {
> +		dma_unmap_single(vring_dma_dev(vq),
> +				 virtio64_to_cpu(vq->vq.vdev, desc->addr),
> +				 virtio32_to_cpu(vq->vq.vdev, desc->len),
> +				 (flags & VRING_DESC_F_WRITE) ?
> +				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +	} else {
> +		dma_unmap_page(vring_dma_dev(vq),
> +			       virtio64_to_cpu(vq->vq.vdev, desc->addr),
> +			       virtio32_to_cpu(vq->vq.vdev, desc->len),
> +			       (flags & VRING_DESC_F_WRITE) ?
> +			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +	}
> +}
> +



I still have a failure in this:

[    1.913040] Unable to handle kernel pointer dereference in virtual kernel address space
[    1.913044] failing address: 000000000c800000 TEID: 000000000c800803
[    1.913045] Fault in home space mode while using kernel ASCE.
[    1.913048] AS:0000000000d56007 R3:000000000c7f0007 S:0000000000000020 
[    1.913099] Oops: 0010 ilc:2 [#1] SMP 
[    1.913142] Modules linked in:
[    1.913144] CPU: 4 PID: 50 Comm: kworker/u18:1 Not tainted 4.3.0-rc3+ #252
[    1.913150] Workqueue: events_unbound call_usermodehelper_exec_work
[    1.913152] task: 000000000bb8b310 ti: 000000000bba8000 task.ti: 000000000bba8000
[    1.913154] Krnl PSW : 0404e00180000000 000000000059b266 (vring_unmap_one+0x46/0x8d0)
[    1.913158]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 EA:3
Krnl GPRS: 0000000000000000 000000000c800000 000000000c036800 000000000c800000
[    1.913161]            00000000005a21a8 0000000000000000 0000000000000000 0000000000000000
[    1.913162]            0704c00180000000 040000000bdbfce8 000000000c082000 000000000bdbf6e8
[    1.913164]            0000000000000400 0000000000000000 000000000bdbf988 000000000bdbf6e8
[    1.913170] Krnl Code: 000000000059b254: e310b0a80004	lg	%r1,168(%r11)
           000000000059b25a: e32010200004	lg	%r2,32(%r1)
          #000000000059b260: e310b0a00004	lg	%r1,160(%r11)
          >000000000059b266: 4810100c		lh	%r1,12(%r1)
           000000000059b26a: e320b2a80024	stg	%r2,680(%r11)
           000000000059b270: 4010b2a6		sth	%r1,678(%r11)
           000000000059b274: e310b2a80004	lg	%r1,680(%r11)
           000000000059b27a: e310b2980024	stg	%r1,664(%r11)
[    1.913183] Call Trace:
[    1.913185] ([<000000000059b74c>] vring_unmap_one+0x52c/0x8d0)
[    1.913187]  [<00000000005a21a8>] detach_buf+0x720/0x788
[    1.913188]  [<00000000005a2830>] virtqueue_get_buf+0x620/0x908
[    1.913191]  [<00000000005e5336>] virtblk_done+0xa6/0x120
[    1.913192]  [<00000000005a3e46>] vring_interrupt+0x2a6/0x2c0
[    1.913224]  [<00000000006c9bdc>] virtio_airq_handler+0x7c/0x120
[    1.913226]  [<000000000065f88c>] do_airq_interrupt+0xa4/0xc8
[    1.913229]  [<00000000001b79a0>] handle_irq_event_percpu+0x60/0x1f0
[    1.913230]  [<00000000001bbbea>] handle_percpu_irq+0x72/0xa0
[    1.913232]  [<00000000001b6fa4>] generic_handle_irq+0x4c/0x78
[    1.913234]  [<000000000010cc7c>] do_IRQ+0x64/0x88
[    1.913236]  [<0000000000815d42>] io_int_handler+0x10a/0x218
[    1.913238]  [<0000000000104268>] copy_thread+0x78/0x1a0
[    1.913240] ([<00000000001548f8>] copy_process.isra.11+0x750/0x1a80)
[    1.913242]  [<0000000000156122>] _do_fork+0x9a/0x338
[    1.913243]  [<000000000015644e>] kernel_thread+0x4e/0x60
[    1.913245]  [<000000000016da7a>] call_usermodehelper_exec_work+0x7a/0xf0
[    1.913247]  [<0000000000171c06>] process_one_work+0x1b6/0x490
[    1.913248]  [<0000000000171f38>] worker_thread+0x58/0x588
[    1.913250]  [<00000000001788fa>] kthread+0x10a/0x110
[    1.913252]  [<0000000000815a8e>] kernel_thread_starter+0x6/0xc
[    1.913254]  [<0000000000815a88>] kernel_thread_starter+0x0/0xc
[    1.913255] Last Breaking-Event-Address:
[    1.913256]  [<00000000005a21a2>] detach_buf+0x71a/0x788
[    1.913258]  
[    1.913263] Kernel panic - not syncing: Fatal exception in interrupt
