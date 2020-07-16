Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726350AbgGPLUM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jul 2020 07:20:12 -0400
Subject: Re: [PATCH v7 2/2] s390: virtio: PV needs VIRTIO I/O device
 protection
References: <1594801869-13365-1-git-send-email-pmorel@linux.ibm.com>
 <1594801869-13365-3-git-send-email-pmorel@linux.ibm.com>
 <20200715054807-mutt-send-email-mst@kernel.org>
 <bc5e09ad-faaf-8b38-83e0-5f4a4b1daeb0@redhat.com>
 <20200715074917-mutt-send-email-mst@kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <3782338a-6491-dc35-7c66-97b91a20df0d@de.ibm.com>
Date: Thu, 16 Jul 2020 13:19:55 +0200
MIME-Version: 1.0
In-Reply-To: <20200715074917-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, linux-kernel@vger.kernel.org, pasic@linux.ibm.com, frankja@linux.ibm.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com



On 15.07.20 13:51, Michael S. Tsirkin wrote:
> On Wed, Jul 15, 2020 at 06:16:59PM +0800, Jason Wang wrote:
>>
>> On 2020/7/15 下午5:50, Michael S. Tsirkin wrote:
>>> On Wed, Jul 15, 2020 at 10:31:09AM +0200, Pierre Morel wrote:
>>>> If protected virtualization is active on s390, the virtio queues are
>>>> not accessible to the host, unless VIRTIO_F_IOMMU_PLATFORM has been
>>>> negotiated. Use the new arch_validate_virtio_features() interface to
>>>> fail probe if that's not the case, preventing a host error on access
>>>> attempt.
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>>> Acked-by: Halil Pasic <pasic@linux.ibm.com>
>>>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>> ---
>>>>   arch/s390/mm/init.c | 28 ++++++++++++++++++++++++++++
>>>>   1 file changed, 28 insertions(+)
>>>>
>>>> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
>>>> index 6dc7c3b60ef6..d39af6554d4f 100644
>>>> --- a/arch/s390/mm/init.c
>>>> +++ b/arch/s390/mm/init.c
>>>> @@ -45,6 +45,7 @@
>>>>   #include <asm/kasan.h>
>>>>   #include <asm/dma-mapping.h>
>>>>   #include <asm/uv.h>
>>>> +#include <linux/virtio_config.h>
>>>>   pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
>>>> @@ -161,6 +162,33 @@ bool force_dma_unencrypted(struct device *dev)
>>>>   	return is_prot_virt_guest();
>>>>   }
>>>> +/*
>>>> + * arch_validate_virtio_features
>>>> + * @dev: the VIRTIO device being added
>>>> + *
>>>> + * Return an error if required features are missing on a guest running
>>>> + * with protected virtualization.
>>>> + */
>>>> +int arch_validate_virtio_features(struct virtio_device *dev)
>>>> +{
>>>> +	if (!is_prot_virt_guest())
>>>> +		return 0;
>>>> +
>>>> +	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
>>>> +		dev_warn(&dev->dev,
>>>> +			 "legacy virtio not supported with protected virtualization\n");
>>>> +		return -ENODEV;
>>>> +	}
>>>> +
>>>> +	if (!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
>>>> +		dev_warn(&dev->dev,
>>>> +			 "support for limited memory access required for protected virtualization\n");
>>>> +		return -ENODEV;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>   /* protected virtualization */
>>>>   static void pv_init(void)
>>>>   {
>>> What bothers me here is that arch code depends on virtio now.
>>> It works even with a modular virtio when functions are inline,
>>> but it seems fragile: e.g. it breaks virtio as an out of tree module,
>>> since layout of struct virtio_device can change.
>>

If you prefer that, we can simply create an arch/s390/kernel/virtio.c ?
