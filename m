From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v6 6/9] virtio: Add improved queue allocation API
Date: Tue, 2 Feb 2016 10:26:02 -0800
Message-ID: <CALCETrXE9MXBCuvEG1hWFtMDWMJSyAL61bL-Kbq_p6MyAyGPDg@mail.gmail.com>
References: <cover.1454349471.git.luto@kernel.org> <5819fe5f70a5c110ab4ea58233004aafd9259d29.1454349471.git.luto@kernel.org>
 <20160202132151-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20160202132151-mutt-send-email-mst@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Woodhouse <dwmw2@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, KVM <kvm@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Vrabel <david.vrabel@citrix.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Feb 2, 2016 at 3:25 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, Feb 01, 2016 at 10:00:56AM -0800, Andy Lutomirski wrote:
>> This leaves vring_new_virtqueue alone for compatbility, but it
>> adds two new improved APIs:
>>
>> vring_create_virtqueue: Creates a virtqueue backed by automatically
>> allocated coherent memory.  (Some day it this could be extended to
>> support non-coherent memory, too, if there ends up being a platform
>> on which it's worthwhile.)
>>
>> __vring_new_virtqueue: Creates a virtqueue with a manually-specified
>> layout.  This should allow mic_virtio to work much more cleanly.
>>
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>> ---
>>  drivers/virtio/virtio_ring.c | 178 +++++++++++++++++++++++++++++++++++--------
>>  include/linux/virtio.h       |  23 +++++-
>>  include/linux/virtio_ring.h  |  35 +++++++++
>>  3 files changed, 204 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index 2f621e96b9ff..cf2840c7e500 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -95,6 +95,11 @@ struct vring_virtqueue {
>>       /* How to notify other side. FIXME: commonalize hcalls! */
>>       bool (*notify)(struct virtqueue *vq);
>>
>> +     /* DMA, allocation, and size information */
>> +     bool we_own_ring;
>> +     size_t queue_size_in_bytes;
>> +     dma_addr_t queue_dma_addr;
>> +
>>  #ifdef DEBUG
>>       /* They're supposed to lock for us. */
>>       unsigned int in_use;
>> @@ -878,36 +883,31 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
>>  }
>>  EXPORT_SYMBOL_GPL(vring_interrupt);
>>
>> -struct virtqueue *vring_new_virtqueue(unsigned int index,
>> -                                   unsigned int num,
>> -                                   unsigned int vring_align,
>> -                                   struct virtio_device *vdev,
>> -                                   bool weak_barriers,
>> -                                   void *pages,
>> -                                   bool (*notify)(struct virtqueue *),
>> -                                   void (*callback)(struct virtqueue *),
>> -                                   const char *name)
>> +struct virtqueue *__vring_new_virtqueue(unsigned int index,
>> +                                     struct vring vring,
>> +                                     struct virtio_device *vdev,
>> +                                     bool weak_barriers,
>> +                                     bool (*notify)(struct virtqueue *),
>> +                                     void (*callback)(struct virtqueue *),
>> +                                     const char *name)
>>  {
>> -     struct vring_virtqueue *vq;
>>       unsigned int i;
>> +     struct vring_virtqueue *vq;
>>
>> -     /* We assume num is a power of 2. */
>> -     if (num & (num - 1)) {
>> -             dev_warn(&vdev->dev, "Bad virtqueue length %u\n", num);
>> -             return NULL;
>> -     }
>> -
>> -     vq = kmalloc(sizeof(*vq) + num * sizeof(struct vring_desc_state),
>> +     vq = kmalloc(sizeof(*vq) + vring.num * sizeof(struct vring_desc_state),
>>                    GFP_KERNEL);
>>       if (!vq)
>>               return NULL;
>>
>> -     vring_init(&vq->vring, num, pages, vring_align);
>> +     vq->vring = vring;
>>       vq->vq.callback = callback;
>>       vq->vq.vdev = vdev;
>>       vq->vq.name = name;
>> -     vq->vq.num_free = num;
>> +     vq->vq.num_free = vring.num;
>>       vq->vq.index = index;
>> +     vq->we_own_ring = false;
>> +     vq->queue_dma_addr = 0;
>> +     vq->queue_size_in_bytes = 0;
>>       vq->notify = notify;
>>       vq->weak_barriers = weak_barriers;
>>       vq->broken = false;
>> @@ -932,18 +932,105 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
>>
>>       /* Put everything in free lists. */
>>       vq->free_head = 0;
>> -     for (i = 0; i < num-1; i++)
>> +     for (i = 0; i < vring.num-1; i++)
>>               vq->vring.desc[i].next = cpu_to_virtio16(vdev, i + 1);
>> -     memset(vq->desc_state, 0, num * sizeof(struct vring_desc_state));
>> +     memset(vq->desc_state, 0, vring.num * sizeof(struct vring_desc_state));
>>
>>       return &vq->vq;
>>  }
>> +EXPORT_SYMBOL_GPL(__vring_new_virtqueue);
>> +
>> +struct virtqueue *vring_create_virtqueue(
>> +     unsigned int index,
>> +     unsigned int num,
>> +     unsigned int vring_align,
>> +     struct virtio_device *vdev,
>> +     bool weak_barriers,
>> +     bool may_reduce_num,
>> +     bool (*notify)(struct virtqueue *),
>> +     void (*callback)(struct virtqueue *),
>> +     const char *name)
>> +{
>> +     struct virtqueue *vq;
>> +     void *queue;
>> +     dma_addr_t dma_addr;
>> +     size_t queue_size_in_bytes;
>> +     struct vring vring;
>> +
>> +     /* We assume num is a power of 2. */
>> +     if (num & (num - 1)) {
>> +             dev_warn(&vdev->dev, "Bad virtqueue length %u\n", num);
>> +             return NULL;
>> +     }
>> +
>> +     /* TODO: allocate each queue chunk individually */
>> +     for (; num && vring_size(num, vring_align) > PAGE_SIZE; num /= 2) {
>> +             queue = dma_zalloc_coherent(
>> +                     vdev->dev.parent, vring_size(num, vring_align),
>> +                     &dma_addr, GFP_KERNEL|__GFP_NOWARN);
>
> I think that we should teach this one to use regular kmalloc
> if vring_use_dma_api is cleared.
> Not a must but it seems cleaner at this stage.

Done.  It arguably makes the code simpler, too, since I can just set
dma_addr to virt_to_phys(queue).

--Andy
