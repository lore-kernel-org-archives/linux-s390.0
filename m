Return-Path: <SRS0=60ZI=TR=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v2 4/4] vfio: vfio_iommu_type1: implement
 VFIO_IOMMU_INFO_CAPABILITIES
References: <1558109810-18683-1-git-send-email-pmorel@linux.ibm.com>
 <1558109810-18683-5-git-send-email-pmorel@linux.ibm.com>
 <20190517104143.240082b5@x1.home>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 17 May 2019 20:04:33 +0200
MIME-Version: 1.0
In-Reply-To: <20190517104143.240082b5@x1.home>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <92b6ad4e-9a49-636b-9225-acca0bec4bb7@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: sebott@linux.vnet.ibm.com, gerald.schaefer@de.ibm.com, pasic@linux.vnet.ibm.com, borntraeger@de.ibm.com, walling@linux.ibm.com, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, robin.murphy@arm.com
List-ID: <linux-s390.vger.kernel.org>

On 17/05/2019 18:41, Alex Williamson wrote:
> On Fri, 17 May 2019 18:16:50 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> We implement the capability interface for VFIO_IOMMU_GET_INFO.
>>
>> When calling the ioctl, the user must specify
>> VFIO_IOMMU_INFO_CAPABILITIES to retrieve the capabilities and
>> must check in the answer if capabilities are supported.
>>
>> The iommu get_attr callback will be used to retrieve the specific
>> attributes and fill the capabilities.
>>
>> Currently two Z-PCI specific capabilities will be queried and
>> filled by the underlying Z specific s390_iommu:
>> VFIO_IOMMU_INFO_CAP_QFN for the PCI query function attributes
>> and
>> VFIO_IOMMU_INFO_CAP_QGRP for the PCI query function group.
>>
>> Other architectures may add new capabilities in the same way
>> after enhancing the architecture specific IOMMU driver.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   drivers/vfio/vfio_iommu_type1.c | 122 +++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 121 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index d0f731c..9435647 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -1658,6 +1658,97 @@ static int vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
>>   	return ret;
>>   }
>>   
>> +static int vfio_iommu_type1_zpci_fn(struct iommu_domain *domain,
>> +				    struct vfio_info_cap *caps, size_t size)
>> +{
>> +	struct vfio_iommu_type1_info_pcifn *info_fn;
>> +	int ret;
>> +
>> +	info_fn = kzalloc(size, GFP_KERNEL);
>> +	if (!info_fn)
>> +		return -ENOMEM;
>> +
>> +	ret = iommu_domain_get_attr(domain, DOMAIN_ATTR_ZPCI_FN,
>> +				    &info_fn->response);
> 
> What ensures that the 'struct clp_rsp_query_pci' returned from this
> get_attr remains consistent with a 'struct vfio_iommu_pci_function'?
> Why does the latter contains so many reserved fields (beyond simply
> alignment) for a user API?  What fields of these structures are
> actually useful to userspace?  Should any fields not be exposed to the
> user?  Aren't BAR sizes redundant to what's available through the vfio
> PCI API?  I'm afraid that simply redefining an internal structure as
> the API leaves a lot to be desired too.  Thanks,
> 
> Alex
> 
Hi Alex,

I simply used the structure returned by the firmware to be sure to be 
consistent with future evolutions and facilitate the copy from CLP and 
to userland.

If you prefer, and I understand that this is the case, I can define a 
specific VFIO_IOMMU structure with only the fields relevant to the user, 
leaving future enhancement of the user's interface being implemented in 
another kernel patch when the time has come.

In fact, the struct will have all defined fields I used but not the BAR 
size and address (at least for now because there are special cases we do 
not support yet with bars).
All the reserved fields can go away.

Is it more conform to your idea?

Also I have 2 interfaces:

s390_iommu.get_attr <-I1-> VFIO_IOMMU <-I2-> userland

Do you prefer:
- 2 different structures, no CLP raw structure
- the CLP raw structure for I1 and a VFIO specific structure for I2
- the same VFIO structure for both I1 and I2

Thank you if you could give me a direction for this.

Thanks for the comments, and thanks a lot to have answered so quickly.

Pierre







-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
