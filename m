From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 4/4] s390/virtio: use noop dma ops
Date: Fri, 30 Oct 2015 13:26:09 +0100
Message-ID: <563361E1.2040605@de.ibm.com>
References: <1445986131-239566-1-git-send-email-borntraeger@de.ibm.com>
 <1445986131-239566-5-git-send-email-borntraeger@de.ibm.com>
 <20151030131746.49f6b129.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20151030131746.49f6b129.cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Andy Lutomirski <luto@kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, dwmw2@infradead.org, Joerg Roedel <jroedel@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Am 30.10.2015 um 13:17 schrieb Cornelia Huck:
> On Tue, 27 Oct 2015 23:48:51 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> With all infrastructure in place, lets provide dma_ops for virtio
>> devices on s390.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  drivers/s390/virtio/kvm_virtio.c | 2 ++
>>  drivers/s390/virtio/virtio_ccw.c | 2 ++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/s390/virtio/kvm_virtio.c b/drivers/s390/virtio/kvm_virtio.c
>> index 53fb975..05adaa9 100644
>> --- a/drivers/s390/virtio/kvm_virtio.c
>> +++ b/drivers/s390/virtio/kvm_virtio.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/kernel_stat.h>
>>  #include <linux/init.h>
>>  #include <linux/bootmem.h>
>> +#include <linux/dma-mapping.h>
>>  #include <linux/err.h>
>>  #include <linux/virtio.h>
>>  #include <linux/virtio_config.h>
>> @@ -318,6 +319,7 @@ static void add_kvm_device(struct kvm_device_desc *d, unsigned int offset)
>>  		return;
>>  	}
>>
>> +	kdev->vdev.dev.archdata.dma_ops = &dma_noop_ops;
> 
> This provides dma_ops for the vdev, while Andy's virtio code looks for
> dma_ops in the vdev's parent (in the ccw and pci cases, the proxy
> device; in this case, it would be our root device).
> 
> With
> 
> diff --git a/drivers/s390/virtio/kvm_virtio.c b/drivers/s390/virtio/kvm_virtio.c
> index 05adaa9..5f79c52 100644
> --- a/drivers/s390/virtio/kvm_virtio.c
> +++ b/drivers/s390/virtio/kvm_virtio.c
> @@ -319,7 +319,6 @@ static void add_kvm_device(struct kvm_device_desc *d, unsigned int offset)
>  		return;
>  	}
> 
> -	kdev->vdev.dev.archdata.dma_ops = &dma_noop_ops;
>  	kdev->vdev.dev.parent = kvm_root;
>  	kdev->vdev.id.device = d->type;
>  	kdev->vdev.config = &kvm_vq_configspace_ops;
> @@ -473,6 +472,7 @@ static int __init kvm_devices_init(void)
>  		vmem_remove_mapping(total_memory_size, PAGE_SIZE);
>  		return rc;
>  	}
> +	kvm_root->archdata.dma_ops = &dma_noop_ops;
> 
>  	INIT_WORK(&hotplug_work, hotplug_devices);
> 
> applied (and the endianness fix in the virtio code), I can boot a
> s390-virtio guest as well.

I am currently reworking this to 

 static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 {
	if (dev && dev->archdata.dma_ops)
		return dev->archdata.dma_ops;
	return &dma_noop_ops;
 }


Which uses the dma_noop_ops for everything unless the device overrides (PCI does)
