Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] s390: protvirt: virtio: Refuse device without IOMMU
References: <1591794711-5915-1-git-send-email-pmorel@linux.ibm.com>
 <467d5b58-b70c-1c45-4130-76b6e18c05af@redhat.com>
 <f7eb1154-0f52-0f12-129f-2b511f5a4685@linux.ibm.com>
 <6356ba7f-afab-75e1-05ff-4a22b88c610e@linux.ibm.com>
 <a02b9f94-eb48-4ae2-0ade-a4ce26b61ad8@redhat.com>
 <20200615123725.13f6a8de.pasic@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <96a236da-7165-b59b-e013-919554fb1ac4@linux.ibm.com>
Date: Mon, 15 Jun 2020 13:49:54 +0200
MIME-Version: 1.0
In-Reply-To: <20200615123725.13f6a8de.pasic@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org



On 2020-06-15 12:37, Halil Pasic wrote:
> On Mon, 15 Jun 2020 11:01:55 +0800
> Jason Wang <jasowang@redhat.com> wrote:
> 
>>> hum, in between I found another way which seems to me much better:
>>>
>>> We already have the force_dma_unencrypted() function available which
>>> AFAIU is what we want for encrypted memory protection and is already
>>> used by power and x86 SEV/SME in a way that seems AFAIU compatible
>>> with our problem.
>>>
>>> Even DMA and IOMMU are different things, I think they should be used
>>> together in our case.
>>>
>>> What do you think?
>>>
>>> The patch would then be something like:
>>>
>>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>>> index a977e32a88f2..53476d5bbe35 100644
>>> --- a/drivers/virtio/virtio.c
>>> +++ b/drivers/virtio/virtio.c
>>> @@ -4,6 +4,7 @@
>>>   #include <linux/virtio_config.h>
>>>   #include <linux/module.h>
>>>   #include <linux/idr.h>
>>> +#include <linux/dma-direct.h>
>>>   #include <uapi/linux/virtio_ids.h>
>>>
>>>   /* Unique numbering for virtio devices. */
>>> @@ -179,6 +180,10 @@ int virtio_finalize_features(struct virtio_device
>>> *dev)
>>>          if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
>>>                  return 0;
>>>
>>> +       if (force_dma_unencrypted(&dev->dev) &&
>>> +           !virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM))
>>> +               return -EIO;
>>> +
>>>          virtio_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
>>>          status = dev->config->get_status(dev);
>>>          if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
>>
>>
>> I think this can work but need to listen from Michael
> 
> I don't think Christoph Hellwig will like force_dma_unencrypted()
> in virtio code:
> https://lkml.org/lkml/2020/2/20/630
> 
> Regards,
> Halil
> 

OK, then back to the first idea.
Thanks,

Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
