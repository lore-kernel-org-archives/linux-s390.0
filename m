Return-Path: <SRS0=60ZI=TR=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH 4/4] vfio: vfio_iommu_type1: implement
 VFIO_IOMMU_INFO_CAPABILITIES
References: <1557476555-20256-1-git-send-email-pmorel@linux.ibm.com>
 <1557476555-20256-5-git-send-email-pmorel@linux.ibm.com>
 <20190516124026.415bf671@x1.home>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 17 May 2019 10:17:17 +0200
MIME-Version: 1.0
In-Reply-To: <20190516124026.415bf671@x1.home>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <29209ea1-be49-47bc-c258-6e87da055fac@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: sebott@linux.vnet.ibm.com, gerald.schaefer@de.ibm.com, pasic@linux.vnet.ibm.com, borntraeger@de.ibm.com, walling@linux.ibm.com, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 16/05/2019 20:40, Alex Williamson wrote:
> On Fri, 10 May 2019 10:22:35 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> We implement a capability intercafe for VFIO_IOMMU_GET_INFO and add the
>> first capability: VFIO_IOMMU_INFO_CAPABILITIES.
>>
>> When calling the ioctl, the user must specify
>> VFIO_IOMMU_INFO_CAPABILITIES to retrieve the capabilities and must check
>> in the answer if capabilities are supported.
>> Older kernel will not check nor set the VFIO_IOMMU_INFO_CAPABILITIES in
>> the flags of vfio_iommu_type1_info.
>>
>> The iommu get_attr callback will be called to retrieve the specific
>> attributes and fill the capabilities, VFIO_IOMMU_INFO_CAP_QFN for the
>> PCI query function attributes and VFIO_IOMMU_INFO_CAP_QGRP for the
>> PCI query function group.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   drivers/vfio/vfio_iommu_type1.c | 95 ++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 94 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index d0f731c..f7f8120 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -1658,6 +1658,70 @@ static int vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
>>   	return ret;
>>   }
>>   
>> +int vfio_iommu_type1_caps(struct vfio_iommu *iommu, struct vfio_info_cap *caps,
>> +			  size_t size)
>> +{
>> +	struct vfio_domain *d;
>> +	struct vfio_iommu_type1_info_block *info_fn;
>> +	struct vfio_iommu_type1_info_block *info_grp;
>> +	unsigned long total_size, fn_size, grp_size;
>> +	int ret;
>> +
>> +	d = list_first_entry(&iommu->domain_list, struct vfio_domain, next);
>> +	if (!d)
>> +		return -ENODEV;
>> +	/* The size of these capabilities are device dependent */
>> +	fn_size = iommu_domain_get_attr(d->domain,
>> +					DOMAIN_ATTR_ZPCI_FN_SIZE, NULL);
>> +	if (fn_size < 0)
>> +		return fn_size;
> 
> What if non-Z archs want to use this?  The function is architected
> specifically for this one use case, fail if any component is not there
> which means it requires a re-write to add further support.  If
> ZPCI_FN_SIZE isn't support, move on to the next thing.

yes, clear.

> 
>> +	fn_size +=  sizeof(struct vfio_info_cap_header);
>> +	total_size = fn_size;
> 
> Here too, total_size should be initialized to zero and each section +=
> the size they'd like to add.

thanks, clear too.

> 
>> +
>> +	grp_size = iommu_domain_get_attr(d->domain,
>> +					 DOMAIN_ATTR_ZPCI_GRP_SIZE, NULL);
>> +	if (grp_size < 0)
>> +		return grp_size;
>> +	grp_size +=  sizeof(struct vfio_info_cap_header);
>> +	total_size += grp_size;
>> +
>> +	/* Tell caller to call us with a greater buffer */
>> +	if (total_size > size) {
>> +		caps->size = total_size;
>> +		return 0;
>> +	}
>> +
>> +	info_fn = kzalloc(fn_size, GFP_KERNEL);
>> +	if (!info_fn)
>> +		return -ENOMEM;
> 
> Maybe fn_size was zero because we're not on Z.
> 
>> +	ret = iommu_domain_get_attr(d->domain,
>> +				    DOMAIN_ATTR_ZPCI_FN, &info_fn->data);
> 
> Kernel internal structures != user api.  Thanks,
> 
> Alex

Thanks a lot Alex,
I understand the concerns, I was too focussed on Z, I will rework this 
as you said:
- definition of the user API and
- take care that another architecture may want to use the interface.

Regards,
Pierre



-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
