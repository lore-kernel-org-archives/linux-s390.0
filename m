From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v1] iommu/s390: Declare s390 iommu reserved regions
Date: Thu, 17 Jan 2019 13:02:12 +0000
Message-ID: <cc070df1-e7dc-8cce-f443-879e0e5e2903@arm.com>
References: <1547573850-9459-1-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547573850-9459-1-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
To: Pierre Morel <pmorel@linux.ibm.com>, gerald.schaefer@de.ibm.com
Cc: linux-s390@vger.kernel.org, walling@linux.ibm.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
List-ID: <linux-s390.vger.kernel.org>

On 15/01/2019 17:37, Pierre Morel wrote:
> The s390 iommu can only allow DMA transactions between the zPCI device
> entries start_dma and end_dma.
> 
> Let's declare the regions before start_dma and after end_dma as
> reserved regions using the appropriate callback in iommu_ops.
> 
> The reserved region may later be retrieved from sysfs or from
> the vfio iommu internal interface.

For this particular case, I think the best solution is to give VFIO the 
ability to directly interrogate the domain geometry (which s390 appears 
to set correctly already). The idea of reserved regions was really for 
'unexpected' holes inside the usable address space - using them to also 
describe places that are entirely outside that address space rather 
confuses things IMO.

Furthermore, even if we *did* end up going down the route of actively 
reserving addresses beyond the usable aperture, it doesn't seem sensible 
for individual drivers to do it themselves when the core API already 
describes the relevant information generically.

Robin.

> 
> This seems to me related with the work Shameer has started on
> vfio_iommu_type1 so I add Alex and Shameer to the CC list.
> 
> 
> Pierre Morel (1):
>    iommu/s390: Declare s390 iommu reserved regions
> 
>   drivers/iommu/s390-iommu.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
