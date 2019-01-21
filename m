From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v1] iommu/s390: Declare s390 iommu reserved regions
Date: Mon, 21 Jan 2019 15:50:48 +0000
Message-ID: <c189fe32-3cbe-0294-8950-e29bce606679@arm.com>
References: <1547573850-9459-1-git-send-email-pmorel@linux.ibm.com>
 <cc070df1-e7dc-8cce-f443-879e0e5e2903@arm.com>
 <3cd790d6-aa6f-e817-27ce-56d7a9b6b6e5@linux.ibm.com>
 <668fe734-e4bf-0342-ab8c-df54d9022db4@arm.com>
 <d180bb2d-354f-0d05-8773-7a196a4de3cb@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d180bb2d-354f-0d05-8773-7a196a4de3cb@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
To: pmorel@linux.ibm.com, Robin Murphy <robin.murphy@arm.com>, gerald.schaefer@de.ibm.com
Cc: linux-s390@vger.kernel.org, walling@linux.ibm.com, alex.williamson@redhat.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "eric.auger@redhat.com" <eric.auger@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On 21/01/2019 11:51, Pierre Morel wrote:
> On 18/01/2019 14:51, Jean-Philippe Brucker wrote:
>> Hi Pierre,
>>
>> On 18/01/2019 13:29, Pierre Morel wrote:
>>> On 17/01/2019 14:02, Robin Murphy wrote:
>>>> On 15/01/2019 17:37, Pierre Morel wrote:
>>>>> The s390 iommu can only allow DMA transactions between the zPCI device
>>>>> entries start_dma and end_dma.
>>>>>
> 
> ...
> 
>>>
>>> I already posted a patch retrieving the geometry through
>>> VFIO_IOMMU_GET_INFO using a specific capability for the geometry [1],
>>> and AFAIU, Alex did not agree with this.
>>
>> On arm we also need to report the IOMMU geometry to userspace (max IOVA
>> size in particular). Shameer has been working on a solution [2] that
>> presents a unified view of both geometry and reserved regions into the
>> VFIO_IOMMU_GET_INFO call, and I think we should go with that. If I
>> understand correctly it's currently blocked on the RMRR problem and
>> we're waiting for Jacob or Ashok to take a look at it, as Kevin pinged
>> them on thread [1]?
>>
>> [2] https://lkml.org/lkml/2018/4/18/293
>>
>> Thanks,
>> Jean
>>
> 
> Hi Jean,
> 
> I hopped that this proposition went in the same direction based on the
> following assumptions:
> 
> 
> - The goal of the get_resv_region is defined in iommu.h as:
> -----
> * @get_resv_regions: Request list of reserved regions for a device
> -----
> 
> - A iommu reserve region is a region which should not be mapped.
> Isn't it exactly what happens outside the aperture?
> Shouldn't it be reported by the iommu reserved region?
> 
> - If we use VFIO and want to get all reserved region we will have the
> VFIO_IOMMU_GET_INFO call provided by Shameer and it can get all reserved
> regions depending from the iommu driver itself at once by calling the
> get_reserved_region callback instead of having to merge them with the
> aperture.
> 
> - If there are other reserved region, depending on the system
> configuration and not on the IOMMU itself, the VFIO_IOMMU_GET_INFO call
> will have to merge them with the region gotten from the iommu driver.

I guess that would only happen if VFIO wanted to reserve IOVA regions
for its own use. But I don't see how that relates to the aperture

> - If we do not use QEMU nor VFIO at all, AFAIU, the standard way to
> retrieve the reserved regions associated with a device is to call the
> get_reserved_region callback from the associated iommu.
> 
> Please tell me were I am wrong.

Those are good points in my opinion (assuming the new reserved regions
for aperture is done in the core API)

To be reliable though, userspace can't get the aperture from sysfs
reserved_regions, it will have to get it from VFIO. If a new application
expects the aperture to be described in reserved_regions but is running
under an old kernel, it will just assume a 64-bit aperture by mistake.
Unless we introduce a new IOMMU_RESV_* type to distinguish the aperture?

Another thing to note is that we're currently adding nested support to
VFIO for Arm and x86 archs. It requires providing low-level and
sometimes arch-specific information about the IOMMU to userspace,
information that is easier to describe using sysfs (e.g.
/sys/class/iommu/<iommu>/*) than a VFIO ioctl. Among them is the input
address size of the IOMMU, so we'll end up with redundant information in
sysfs on x86 and Arm sides, but that's probably harmless.

Thanks,
Jean
