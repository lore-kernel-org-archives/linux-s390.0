From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 3/3] virtio_pci: Use the DMA API for virtqueues
Date: Wed, 27 Aug 2014 10:35:10 -0700
Message-ID: <CALCETrV8sbqvbQk7+JRyE4FxQ=o+RoEMh4hgA3-yNUegGgF08Q@mail.gmail.com>
References: <cover.1409087794.git.luto@amacapital.net>
	<3bf33716d8c9808c91ac9f38d967f97153383375.1409087794.git.luto@amacapital.net>
	<20140827173244.GB5379@laptop.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140827173244.GB5379@laptop.dumpdata.com>
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
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "linux390@de.ibm.com" <linux390@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Aug 27, 2014 at 10:32 AM, Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
> On Tue, Aug 26, 2014 at 02:17:02PM -0700, Andy Lutomirski wrote:
>> A virtqueue is a coherent DMA mapping.  Use the DMA API for it.
>> This fixes virtio_pci on Xen.
>>
>> Signed-off-by: Andy Lutomirski <luto@amacapital.net>
>> ---
>>  drivers/virtio/virtio_pci.c | 25 ++++++++++++++++++-------
>>  1 file changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
>> index 3d1463c6b120..19039c5bec24 100644
>> --- a/drivers/virtio/virtio_pci.c
>> +++ b/drivers/virtio/virtio_pci.c
>> @@ -80,8 +80,9 @@ struct virtio_pci_vq_info
>>       /* the number of entries in the queue */
>>       int num;
>>
>> -     /* the virtual address of the ring queue */
>> -     void *queue;
>> +     /* the ring queue */
>> +     void *queue;                    /* virtual address */
>> +     dma_addr_t queue_dma_addr;      /* bus address */
>>
>>       /* the list node for the virtqueues list */
>>       struct list_head node;
>> @@ -417,15 +418,16 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
>>       info->num = num;
>>       info->msix_vector = msix_vec;
>>
>> -     size = PAGE_ALIGN(vring_size(num, VIRTIO_PCI_VRING_ALIGN));
>> -     info->queue = alloc_pages_exact(size, GFP_KERNEL|__GFP_ZERO);
>> +     size = vring_size(num, VIRTIO_PCI_VRING_ALIGN);
>> +     info->queue = dma_zalloc_coherent(vdev->dev.parent, size,
>> +                                       &info->queue_dma_addr, GFP_KERNEL);
>>       if (info->queue == NULL) {
>>               err = -ENOMEM;
>>               goto out_info;
>>       }
>>
>>       /* activate the queue */
>> -     iowrite32(virt_to_phys(info->queue) >> VIRTIO_PCI_QUEUE_ADDR_SHIFT,
>> +     iowrite32(info->queue_dma_addr >> VIRTIO_PCI_QUEUE_ADDR_SHIFT,
>>                 vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
>>
>>       /* create the vring */
>> @@ -462,7 +464,8 @@ out_assign:
>>       vring_del_virtqueue(vq);
>>  out_activate_queue:
>>       iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
>> -     free_pages_exact(info->queue, size);
>> +     dma_free_coherent(vdev->dev.parent, size,
>> +                       info->queue, info->queue_dma_addr);
>>  out_info:
>>       kfree(info);
>>       return ERR_PTR(err);
>> @@ -493,7 +496,8 @@ static void vp_del_vq(struct virtqueue *vq)
>>       iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
>>
>>       size = PAGE_ALIGN(vring_size(info->num, VIRTIO_PCI_VRING_ALIGN));
>> -     free_pages_exact(info->queue, size);
>> +     dma_free_coherent(vq->vdev->dev.parent, size,
>> +                       info->queue, info->queue_dma_addr);
>>       kfree(info);
>>  }
>>
>> @@ -712,6 +716,13 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
>>       if (err)
>>               goto out;
>>
>> +     /*
>> +      * We support 64-bit DMA.  If this fails (e.g. some bridge
>> +      * or PV code doesn't or DAC is disabled), then we're okay
>> +      * with 32-bit DMA.
>
> <scratches his head>
>
> I am having a hard time parsing that. Could you expand a bit the
> faulting use-case please?
>
>> +      */
>> +     dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64));
>
> The usual process is:
>
>         ret = dma_set_mask_and_coherent(..)
>         if (ret)
>                 ret = dma_set_mask_and_coherent(.., DMA_BIT_MASK(32))
>
>         if (ret)
>                 pr_warn("We are truly screwed. Good luck!\n");
>

I assumed that, if dma_set_mask_and_coherent(..., DMA_BIT_BASK(64))
fails, then we can still do DMA, just not 64-bit DMA.  This driver
should be fine with that -- it'll just be a bit slower.

If that's not a safe assumption, I can change it.

--Andy
