From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 2/3] virtio_ring: Support DMA APIs
Date: Wed, 28 Oct 2015 11:27:55 +0900
Message-ID: <563032AB.7000601@de.ibm.com>
References: <cover.1445994839.git.luto@kernel.org>
 <6b42014d04258c706c7c43ae739efb30e32496b9.1445994839.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6b42014d04258c706c7c43ae739efb30e32496b9.1445994839.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <jroedel@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, dwmw2@infradead.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>
List-ID: <linux-s390.vger.kernel.org>

Am 28.10.2015 um 10:17 schrieb Andy Lutomirski:
@@ -423,27 +522,42 @@ EXPORT_SYMBOL_GPL(virtqueue_kick);
> 
>  static void detach_buf(struct vring_virtqueue *vq, unsigned int head)
>  {
> -	unsigned int i;
> +	unsigned int i, j;
> +	u16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
> 
>  	/* Clear data ptr. */
> -	vq->data[head] = NULL;
> +	vq->desc_state[head].data = NULL;
> 
> -	/* Put back on free list: find end */
> +	/* Put back on free list: unmap first-level descriptors and find end */
>  	i = head;
> 
> -	/* Free the indirect table */
> -	if (vq->vring.desc[i].flags & cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_INDIRECT))
> -		kfree(phys_to_virt(virtio64_to_cpu(vq->vq.vdev, vq->vring.desc[i].addr)));
> -
> -	while (vq->vring.desc[i].flags & cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT)) {
> +	while (vq->vring.desc[i].flags & nextflag) {
> +		vring_unmap_one(vq, &vq->vring.desc[i]);
>  		i = virtio16_to_cpu(vq->vq.vdev, vq->vring.desc[i].next);
>  		vq->vq.num_free++;
>  	}
> 
> +	vring_unmap_one(vq, &vq->vring.desc[i]);
>  	vq->vring.desc[i].next = cpu_to_virtio16(vq->vq.vdev, vq->free_head);
>  	vq->free_head = head;
> +
>  	/* Plus final descriptor */
>  	vq->vq.num_free++;
> +
> +	/* Free the indirect table, if any, now that it's unmapped. */
> +	if (vq->desc_state[head].indir_desc) {
> +		struct vring_desc *indir_desc = vq->desc_state[head].indir_desc;
> +		u32 len = vq->vring.desc[head].len;
> +
> +		BUG_ON(!(vq->vring.desc[head].flags & VRING_DESC_F_INDIRECT));
> +		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
> +
> +		for (j = 0; j < len / sizeof(struct vring_desc); j++)
> +			vring_unmap_one(vq, &indir_desc[j]);
> +
> +		kfree(vq->desc_state[head].indir_desc);
> +		vq->desc_state[head].indir_desc = NULL;
> +	}
>  }

something seems to be broken with indirect descriptors with that change

[    1.885451] ------------[ cut here ]------------
[    1.885454] kernel BUG at drivers/virtio/virtio_ring.c:552!
[    1.885487] illegal operation: 0001 ilc:1 [#1] SMP 
[    1.885489] Modules linked in:
[    1.885491] CPU: 0 PID: 2 Comm: kthreadd Not tainted 4.3.0-rc3+ #250
[    1.885493] task: 000000000be49988 ti: 000000000be54000 task.ti: 000000000be54000
[    1.885514] Krnl PSW : 0404c00180000000 000000000059b9d2 (detach_buf+0x1ca/0x1d0)
[    1.885519]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 EA:3
Krnl GPRS: 0000000000000000 0000000030000000 000000000c0c8c00 000000000a89c000
[    1.885522]            000000000059b8fa 0000000000000001 0000000000000000 0000000000000000
[    1.885523]            0000000000000000 0000000000000000 0000000000000100 000000000a89c000
[    1.885525]            000000000c082000 000000000c082000 000000000059b8fa 000000000c7fbc88
[    1.885531] Krnl Code: 000000000059b9c6: a7f4ff40		brc	15,59b846
           000000000059b9ca: a7f40001		brc	15,59b9cc
          #000000000059b9ce: a7f40001		brc	15,59b9d0
          >000000000059b9d2: 0707		bcr	0,%r7
           000000000059b9d4: 0707		bcr	0,%r7
           000000000059b9d6: 0707		bcr	0,%r7
           000000000059b9d8: c00400000000	brcl	0,59b9d8
           000000000059b9de: ebcff0780024	stmg	%r12,%r15,120(%r15)
[    1.885542] Call Trace:
[    1.885544] ([<000000000059b8fa>] detach_buf+0xf2/0x1d0)
[    1.885546]  [<000000000059bbb4>] virtqueue_get_buf+0xcc/0x218
[    1.885549]  [<00000000005dd8fe>] virtblk_done+0xa6/0x120
[    1.885550]  [<000000000059b66e>] vring_interrupt+0x7e/0x108
[    1.885552]  [<00000000006c21a4>] virtio_airq_handler+0x7c/0x120
[    1.885554]  [<0000000000657e54>] do_airq_interrupt+0xa4/0xc8
[    1.885558]  [<00000000001b79a0>] handle_irq_event_percpu+0x60/0x1f0
[    1.885560]  [<00000000001bbbea>] handle_percpu_irq+0x72/0xa0
[    1.885561]  [<00000000001b6fa4>] generic_handle_irq+0x4c/0x78
[    1.885564]  [<000000000010cc7c>] do_IRQ+0x64/0x88
[    1.885566] Btrfs loaded
[    1.885600]  [<000000000080e30a>] io_int_handler+0x10a/0x218
[    1.885603]  [<0000000000186b9e>] wake_up_new_task+0x1be/0x260
[    1.885604] ([<0000000000186b6a>] wake_up_new_task+0x18a/0x260)
[    1.885606]  [<0000000000156182>] _do_fork+0xfa/0x338
[    1.885608]  [<000000000015644e>] kernel_thread+0x4e/0x60
[    1.885609]  [<0000000000179202>] kthreadd+0x1a2/0x238
[    1.885611]  [<000000000080e056>] kernel_thread_starter+0x6/0xc
[    1.885613]  [<000000000080e050>] kernel_thread_starter+0x0/0xc
[    1.885614] Last Breaking-Event-Address:
[    1.885615]  [<000000000059b9ce>] detach_buf+0x1c6/0x1d0
[    1.885617]  
[    1.885618] Kernel panic - not syncing: Fatal exception in interrupt
