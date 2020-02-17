Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48772 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726710AbgBQNIR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 08:08:17 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HD5QV9083940
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 08:08:16 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6dkwktf8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 08:08:15 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Mon, 17 Feb 2020 13:08:12 -0000
Date: Mon, 17 Feb 2020 14:08:05 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/2] virtio-blk: fix hw_queue stopped on arbitrary error
In-Reply-To: <d46e3fc1-9637-b82c-f986-3889fb0ca612@oracle.com>
References: <20200213123728.61216-1-pasic@linux.ibm.com>
        <20200213123728.61216-2-pasic@linux.ibm.com>
        <d46e3fc1-9637-b82c-f986-3889fb0ca612@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20200217140805.1f3fa378.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: dongli.zhang@oracle.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>

On Fri, 14 Feb 2020 10:20:44 -0800
dongli.zhang@oracle.com wrote:

> Hi Halil,
> 
> When swiotlb full is hit for virtio_blk, there is below warning for once (the
> warning is not by this patch set). Is this expected or just false positive?

The warning is kind of expected. Certainly not a false positive, but it
probably looks more dramatic than I would like it to look.

If swiotlb cmdline parameter can be chosen so that the swiotlb won't
run out of space, that is certainly preferable. But out of swiotlb space
should merely result in performance degradation (provided the device
drivers properly handle the condition).

Thanks for having a look! 

Regards,
Halil

> 
> [   54.767257] virtio-pci 0000:00:04.0: swiotlb buffer is full (sz: 16 bytes),
> total 32768 (slots), used 258 (slots)
> [   54.767260] virtio-pci 0000:00:04.0: overflow 0x0000000075770110+16 of DMA
> mask ffffffffffffffff bus limit 0
> [   54.769192] ------------[ cut here ]------------
> [   54.769200] WARNING: CPU: 3 PID: 102 at kernel/dma/direct.c:35
> report_addr+0x71/0x77
> [   54.769200] Modules linked in:
> [   54.769203] CPU: 3 PID: 102 Comm: kworker/u8:2 Not tainted 5.6.0-rc1+ #2
> [   54.769204] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> [   54.769208] Workqueue: writeback wb_workfn (flush-253:0)
> [   54.769211] RIP: 0010:report_addr+0x71/0x77
> ... ...
> [   54.769226] Call Trace:
> [   54.769241]  dma_direct_map_page+0xc9/0xe0
> [   54.769245]  virtqueue_add+0x172/0xaa0
> [   54.769248]  virtqueue_add_sgs+0x85/0xa0
> [   54.769251]  virtio_queue_rq+0x292/0x480
> [   54.769255]  __blk_mq_try_issue_directly+0x13e/0x1f0
> [   54.769257]  blk_mq_request_issue_directly+0x48/0xa0
> [   54.769259]  blk_mq_try_issue_list_directly+0x3c/0xb0
> [   54.769261]  blk_mq_sched_insert_requests+0xb6/0x100
> [   54.769263]  blk_mq_flush_plug_list+0x146/0x210
> [   54.769264]  blk_flush_plug_list+0xba/0xe0
> [   54.769266]  blk_mq_make_request+0x331/0x5b0
> [   54.769268]  generic_make_request+0x10d/0x2e0
> [   54.769270]  submit_bio+0x69/0x130
> [   54.769273]  ext4_io_submit+0x44/0x50
> [   54.769275]  ext4_writepages+0x56f/0xd30
> [   54.769278]  ? cpumask_next_and+0x19/0x20
> [   54.769280]  ? find_busiest_group+0x11a/0xa40
> [   54.769283]  do_writepages+0x15/0x70
> [   54.769288]  __writeback_single_inode+0x38/0x330
> [   54.769290]  writeback_sb_inodes+0x219/0x4c0
> [   54.769292]  __writeback_inodes_wb+0x82/0xb0
> [   54.769293]  wb_writeback+0x267/0x300
> [   54.769295]  wb_workfn+0x1aa/0x430
> [   54.769298]  process_one_work+0x156/0x360
> [   54.769299]  worker_thread+0x41/0x3b0
> [   54.769300]  kthread+0xf3/0x130
> [   54.769302]  ? process_one_work+0x360/0x360
> [   54.769303]  ? kthread_bind+0x10/0x10
> [   54.769305]  ret_from_fork+0x35/0x40
> [   54.769307] ---[ end trace 923a87a9ce0e777a ]---
> 
> Thank you very much!
> 
> Dongli Zhang
> 
> On 2/13/20 4:37 AM, Halil Pasic wrote:
> > Since nobody else is going to restart our hw_queue for us, the
> > blk_mq_start_stopped_hw_queues() is in virtblk_done() is not sufficient
> > necessarily sufficient to ensure that the queue will get started again.
> > In case of global resource outage (-ENOMEM because mapping failure,
> > because of swiotlb full) our virtqueue may be empty and we can get
> > stuck with a stopped hw_queue.
> > 
> > Let us not stop the queue on arbitrary errors, but only on -EONSPC which
> > indicates a full virtqueue, where the hw_queue is guaranteed to get
> > started by virtblk_done() before when it makes sense to carry on
> > submitting requests. Let us also remove a stale comment.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Fixes: f7728002c1c7 ("virtio_ring: fix return code on DMA mapping fails")
> > ---
> > 
> > I'm in doubt with regards to the Fixes tag. The thing is, virtio-blk
> > probably made an assumption on virtqueue_add: the failure is either
> > because the virtqueue is full, or the failure is fatal. In both cases it
> > seems acceptable to stop the queue, although the fatal case is arguable.
> > Since commit f7728002c1c7 it the dma mapping has failed returns -ENOMEM
> > and not -EIO, and thus we have a recoverable failure that ain't
> > virtqueue full. So I lean towards to a fixes tag that references that
> > commit, although it ain't broken. Alternatively one could say 'Fixes:
> > e467cde23818 ("Block driver using virtio.")', if the aforementioned
> > assumption shouldn't have made in the first place.
> > ---
> >  drivers/block/virtio_blk.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 54158766334b..adfe43f5ffe4 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -245,10 +245,12 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
> >  	err = virtblk_add_req(vblk->vqs[qid].vq, vbr, vbr->sg, num);
> >  	if (err) {
> >  		virtqueue_kick(vblk->vqs[qid].vq);
> > -		blk_mq_stop_hw_queue(hctx);
> > +		/* Don't stop the queue if -ENOMEM: we may have failed to
> > +		 * bounce the buffer due to global resource outage.
> > +		 */
> > +		if (err == -ENOSPC)
> > +			blk_mq_stop_hw_queue(hctx);
> >  		spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
> > -		/* Out of mem doesn't actually happen, since we fall back
> > -		 * to direct descriptors */
> >  		if (err == -ENOMEM || err == -ENOSPC)
> >  			return BLK_STS_DEV_RESOURCE;
> >  		return BLK_STS_IOERR;
> > 
