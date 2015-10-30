From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v4 2/6] virtio_ring: Support DMA APIs
Date: Fri, 30 Oct 2015 13:05:11 +0100
Message-ID: <56335CF7.2050101@de.ibm.com>
References: <cover.1446162273.git.luto@kernel.org>
	<7c590bf685f5cbc3f01e42bdbc1dbe3ffd83420f.1446162273.git.luto@kernel.org>
	<20151030130116.52a87922.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20151030130116.52a87922.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, Andy Lutomirski <luto@kernel.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, benh@kernel.crashing.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, dwmw2@infradead.org, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-s390.vger.kernel.org>

Am 30.10.2015 um 13:01 schrieb Cornelia Huck:
> On Thu, 29 Oct 2015 18:09:47 -0700
> Andy Lutomirski <luto@kernel.org> wrote:
> 
>> virtio_ring currently sends the device (usually a hypervisor)
>> physical addresses of its I/O buffers.  This is okay when DMA
>> addresses and physical addresses are the same thing, but this isn't
>> always the case.  For example, this never works on Xen guests, and
>> it is likely to fail if a physical "virtio" device ever ends up
>> behind an IOMMU or swiotlb.
>>
>> The immediate use case for me is to enable virtio on Xen guests.
>> For that to work, we need vring to support DMA address translation
>> as well as a corresponding change to virtio_pci or to another
>> driver.
>>
>> With this patch, if enabled, virtfs survives kmemleak and
>> CONFIG_DMA_API_DEBUG.
>>
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>> ---
>>  drivers/virtio/Kconfig           |   2 +-
>>  drivers/virtio/virtio_ring.c     | 190 +++++++++++++++++++++++++++++++--------
>>  tools/virtio/linux/dma-mapping.h |  17 ++++
>>  3 files changed, 172 insertions(+), 37 deletions(-)
>>  create mode 100644 tools/virtio/linux/dma-mapping.h
> 
>>  static void detach_buf(struct vring_virtqueue *vq, unsigned int head)
>>  {
>> -	unsigned int i;
>> +	unsigned int i, j;
>> +	u16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
>>
>>  	/* Clear data ptr. */
>> -	vq->data[head] = NULL;
>> +	vq->desc_state[head].data = NULL;
>>
>> -	/* Put back on free list: find end */
>> +	/* Put back on free list: unmap first-level descriptors and find end */
>>  	i = head;
>>
>> -	/* Free the indirect table */
>> -	if (vq->vring.desc[i].flags & cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_INDIRECT))
>> -		kfree(phys_to_virt(virtio64_to_cpu(vq->vq.vdev, vq->vring.desc[i].addr)));
>> -
>> -	while (vq->vring.desc[i].flags & cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT)) {
>> +	while (vq->vring.desc[i].flags & nextflag) {
>> +		vring_unmap_one(vq, &vq->vring.desc[i]);
>>  		i = virtio16_to_cpu(vq->vq.vdev, vq->vring.desc[i].next);
>>  		vq->vq.num_free++;
>>  	}
>>
>> +	vring_unmap_one(vq, &vq->vring.desc[i]);
>>  	vq->vring.desc[i].next = cpu_to_virtio16(vq->vq.vdev, vq->free_head);
>>  	vq->free_head = head;
>> +
>>  	/* Plus final descriptor */
>>  	vq->vq.num_free++;
>> +
>> +	/* Free the indirect table, if any, now that it's unmapped. */
>> +	if (vq->desc_state[head].indir_desc) {
>> +		struct vring_desc *indir_desc = vq->desc_state[head].indir_desc;
>> +		u32 len = vq->vring.desc[head].len;
> 
> This one needs to be virtio32_to_cpu(...) as well.

Yes, just did the exact same change
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index f269e1c..f2249df 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -556,7 +556,7 @@ static void detach_buf(struct vring_virtqueue *vq, unsigned int head)
        /* Free the indirect table, if any, now that it's unmapped. */
        if (vq->desc_state[head].indir_desc) {
                struct vring_desc *indir_desc = vq->desc_state[head].indir_desc;
-               u32 len = vq->vring.desc[head].len;
+               u32 len = virtio32_to_cpu(vq->vq.vdev, vq->vring.desc[head].len);
 
                BUG_ON(!(vq->vring.desc[head].flags &
                         cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_INDIRECT)));


now it boots.
> 
>> +
>> +		BUG_ON(!(vq->vring.desc[head].flags &
>> +			 cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_INDIRECT)));
>> +		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
>> +
>> +		for (j = 0; j < len / sizeof(struct vring_desc); j++)
>> +			vring_unmap_one(vq, &indir_desc[j]);
>> +
>> +		kfree(vq->desc_state[head].indir_desc);
>> +		vq->desc_state[head].indir_desc = NULL;
>> +	}
>>  }
> 
> With that change on top of your current branch, I can boot (root on
> virtio-blk, either virtio-1 or legacy virtio) on current qemu master
> with kvm enabled on s390. Haven't tried anything further.
> 
