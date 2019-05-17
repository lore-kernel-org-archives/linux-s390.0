Return-Path: <SRS0=60ZI=TR=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH 2/4] vfio: vfio_iommu_type1: Define
 VFIO_IOMMU_INFO_CAPABILITIES
References: <1557476555-20256-1-git-send-email-pmorel@linux.ibm.com>
 <1557476555-20256-3-git-send-email-pmorel@linux.ibm.com>
 <20190516123100.529f06be@x1.home>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 17 May 2019 10:18:33 +0200
MIME-Version: 1.0
In-Reply-To: <20190516123100.529f06be@x1.home>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <ce6c7c44-b406-00d1-cf40-0dae6a6ed563@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: sebott@linux.vnet.ibm.com, gerald.schaefer@de.ibm.com, pasic@linux.vnet.ibm.com, borntraeger@de.ibm.com, walling@linux.ibm.com, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 16/05/2019 20:31, Alex Williamson wrote:
> On Fri, 10 May 2019 10:22:33 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> To use the VFIO_IOMMU_GET_INFO to retrieve IOMMU specific information,
>> we define a new flag VFIO_IOMMU_INFO_CAPABILITIES in the
>> vfio_iommu_type1_info structure and the associated capability
>> information block.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   include/uapi/linux/vfio.h | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 8f10748..8f68e0f 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -715,6 +715,16 @@ struct vfio_iommu_type1_info {
>>   	__u32	flags;
>>   #define VFIO_IOMMU_INFO_PGSIZES (1 << 0)	/* supported page sizes info */
>>   	__u64	iova_pgsizes;		/* Bitmap of supported page sizes */
>> +#define VFIO_IOMMU_INFO_CAPABILITIES (1 << 1)  /* support capabilities info */
>> +	__u64   cap_offset;     /* Offset within info struct of first cap */
>> +};
>> +
>> +#define VFIO_IOMMU_INFO_CAP_QFN		1
>> +#define VFIO_IOMMU_INFO_CAP_QGRP	2
> 
> Descriptions?
> 
>> +
>> +struct vfio_iommu_type1_info_block {
>> +	struct vfio_info_cap_header header;
>> +	__u32 data[];
>>   };
>>   
>>   #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
> 
> This is just a blob of data, what's the API?  How do we revision it?
> How does the user know how to interpret it?  Dumping kernel internal
> structures out to userspace like this is not acceptable, define a user
> API. Thanks,
> 
> Alex
> 

Thanks Alex for the comments.
I will add the decription and the user API for the next iteration.

Regards,
Pierre




-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
