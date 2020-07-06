Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] s390: virtio: let arch accept devices without
 IOMMU feature
From: Pierre Morel <pmorel@linux.ibm.com>
References: <1592390637-17441-1-git-send-email-pmorel@linux.ibm.com>
 <1592390637-17441-2-git-send-email-pmorel@linux.ibm.com>
 <20200629115651-mutt-send-email-mst@kernel.org>
 <20200629180526.41d0732b.cohuck@redhat.com>
 <26ecd4c6-837b-1ce6-170b-a0155e4dd4d4@linux.ibm.com>
Message-ID: <a677decc-5be3-8095-bc33-0f95634011f6@linux.ibm.com>
Date: Mon, 6 Jul 2020 15:37:37 +0200
MIME-Version: 1.0
In-Reply-To: <26ecd4c6-837b-1ce6-170b-a0155e4dd4d4@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com



On 2020-07-02 15:03, Pierre Morel wrote:
> 
> 
> On 2020-06-29 18:05, Cornelia Huck wrote:
>> On Mon, 29 Jun 2020 11:57:14 -0400
>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>
>>> On Wed, Jun 17, 2020 at 12:43:57PM +0200, Pierre Morel wrote:
>>>> An architecture protecting the guest memory against unauthorized host
>>>> access may want to enforce VIRTIO I/O device protection through the
>>>> use of VIRTIO_F_IOMMU_PLATFORM.
>>>>
>>>> Let's give a chance to the architecture to accept or not devices
>>>> without VIRTIO_F_IOMMU_PLATFORM.
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> Acked-by: Jason Wang <jasowang@redhat.com>
>>>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>> ---
>>>>   arch/s390/mm/init.c     |  6 ++++++
>>>>   drivers/virtio/virtio.c | 22 ++++++++++++++++++++++
>>>>   include/linux/virtio.h  |  2 ++
>>>>   3 files changed, 30 insertions(+)
>>
>>>> @@ -179,6 +194,13 @@ int virtio_finalize_features(struct 
>>>> virtio_device *dev)
>>>>       if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
>>>>           return 0;
>>>> +    if (arch_needs_virtio_iommu_platform(dev) &&
>>>> +        !virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
>>>> +        dev_warn(&dev->dev,
>>>> +             "virtio: device must provide VIRTIO_F_IOMMU_PLATFORM\n");
>>>> +        return -ENODEV;
>>>> +    }
>>>> +
>>>>       virtio_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
>>>>       status = dev->config->get_status(dev);
>>>>       if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
>>>
>>> Well don't you need to check it *before* VIRTIO_F_VERSION_1, not after?
>>
>> But it's only available with VERSION_1 anyway, isn't it? So it probably
>> also needs to fail when this feature is needed if VERSION_1 has not been
>> negotiated, I think.


would be something like:

-       if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
-               return 0;
+       if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
+               ret = arch_accept_virtio_features(dev);
+               if (ret)
+                       dev_warn(&dev->dev,
+                                "virtio: device must provide 
VIRTIO_F_VERSION_1\n");
+               return ret;
+       }


just a thought on the function name:
It becomes more general than just IOMMU_PLATFORM related.

What do you think of:

arch_accept_virtio_features()

?

Regards,
Pierre


-- 
Pierre Morel
IBM Lab Boeblingen
