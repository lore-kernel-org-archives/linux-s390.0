From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH v1] iommu/s390: Declare s390 iommu reserved regions
Date: Thu, 17 Jan 2019 09:23:55 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83928BF16@lhreml524-mbs.china.huawei.com>
References: <1547573850-9459-1-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547573850-9459-1-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
To: Pierre Morel <pmorel@linux.ibm.com>, "gerald.schaefer@de.ibm.com" <gerald.schaefer@de.ibm.com>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "walling@linux.ibm.com" <walling@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Pierre,

> -----Original Message-----
> From: Pierre Morel [mailto:pmorel@linux.ibm.com]
> Sent: 15 January 2019 17:37
> To: gerald.schaefer@de.ibm.com
> Cc: joro@8bytes.org; linux-s390@vger.kernel.org;
> iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> alex.williamson@redhat.com; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; walling@linux.ibm.com
> Subject: [PATCH v1] iommu/s390: Declare s390 iommu reserved regions
> 
> The s390 iommu can only allow DMA transactions between the zPCI device
> entries start_dma and end_dma.
> 
> Let's declare the regions before start_dma and after end_dma as
> reserved regions using the appropriate callback in iommu_ops.
> 
> The reserved region may later be retrieved from sysfs or from
> the vfio iommu internal interface.

Just in case you are planning to use the sysfs interface to retrieve the valid 
regions, and intend to use that in Qemu vfio path, please see the discussion
here [1] (If you haven't seen this already)

Thanks,
Shameer

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg03651.html
 
> This seems to me related with the work Shameer has started on
> vfio_iommu_type1 so I add Alex and Shameer to the CC list.
> 
> Pierre Morel (1):
>   iommu/s390: Declare s390 iommu reserved regions
> 
>  drivers/iommu/s390-iommu.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> --
> 2.7.4
