From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v1] iommu/s390: Declare s390 iommu reserved regions
Date: Tue, 15 Jan 2019 18:37:29 +0100
Message-ID: <1547573850-9459-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
To: gerald.schaefer@de.ibm.com
Cc: joro@8bytes.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com, walling@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

The s390 iommu can only allow DMA transactions between the zPCI device
entries start_dma and end_dma.

Let's declare the regions before start_dma and after end_dma as
reserved regions using the appropriate callback in iommu_ops.

The reserved region may later be retrieved from sysfs or from
the vfio iommu internal interface.

This seems to me related with the work Shameer has started on
vfio_iommu_type1 so I add Alex and Shameer to the CC list.


Pierre Morel (1):
  iommu/s390: Declare s390 iommu reserved regions

 drivers/iommu/s390-iommu.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

-- 
2.7.4
