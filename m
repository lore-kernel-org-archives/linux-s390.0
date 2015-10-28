From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 2/3] virtio_ring: Support DMA APIs
Date: Tue, 27 Oct 2015 22:09:07 -0700
Message-ID: <CALCETrVKCnhBX+BxLiHJOrV76fAkXW2-q7caw8Sm622vAP5BOg@mail.gmail.com>
References: <cover.1445994839.git.luto@kernel.org> <6b42014d04258c706c7c43ae739efb30e32496b9.1445994839.git.luto@kernel.org>
 <563032AB.7000601@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <563032AB.7000601@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Andy Lutomirski <luto@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, KVM <kvm@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Oct 27, 2015 at 7:27 PM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
> Am 28.10.2015 um 10:17 schrieb Andy Lutomirski:
> @@ -423,27 +522,42 @@ EXPORT_SYMBOL_GPL(virtqueue_kick);
>>
>>  static void detach_buf(struct vring_virtqueue *vq, unsigned int head)
>>  {
>> -     unsigned int i;
>> +     unsigned int i, j;
>> +     u16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
>>
>>       /* Clear data ptr. */
>> -     vq->data[head] = NULL;
>> +     vq->desc_state[head].data = NULL;
>>
>> -     /* Put back on free list: find end */
>> +     /* Put back on free list: unmap first-level descriptors and find end */
>>       i = head;
>>
>> -     /* Free the indirect table */
>> -     if (vq->vring.desc[i].flags & cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_INDIRECT))
>> -             kfree(phys_to_virt(virtio64_to_cpu(vq->vq.vdev, vq->vring.desc[i].addr)));
>> -
>> -     while (vq->vring.desc[i].flags & cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT)) {
>> +     while (vq->vring.desc[i].flags & nextflag) {
>> +             vring_unmap_one(vq, &vq->vring.desc[i]);
>>               i = virtio16_to_cpu(vq->vq.vdev, vq->vring.desc[i].next);
>>               vq->vq.num_free++;
>>       }
>>
>> +     vring_unmap_one(vq, &vq->vring.desc[i]);
>>       vq->vring.desc[i].next = cpu_to_virtio16(vq->vq.vdev, vq->free_head);
>>       vq->free_head = head;
>> +
>>       /* Plus final descriptor */
>>       vq->vq.num_free++;
>> +
>> +     /* Free the indirect table, if any, now that it's unmapped. */
>> +     if (vq->desc_state[head].indir_desc) {
>> +             struct vring_desc *indir_desc = vq->desc_state[head].indir_desc;
>> +             u32 len = vq->vring.desc[head].len;
>> +
>> +             BUG_ON(!(vq->vring.desc[head].flags & VRING_DESC_F_INDIRECT));
>> +             BUG_ON(len == 0 || len % sizeof(struct vring_desc));
>> +
>> +             for (j = 0; j < len / sizeof(struct vring_desc); j++)
>> +                     vring_unmap_one(vq, &indir_desc[j]);
>> +
>> +             kfree(vq->desc_state[head].indir_desc);
>> +             vq->desc_state[head].indir_desc = NULL;
>> +     }
>>  }
>
> something seems to be broken with indirect descriptors with that change

You're big endian, right?  I had an endian handling bug, and I'll fix it in v2.

--Andy
