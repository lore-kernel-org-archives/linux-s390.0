Return-Path: <SRS0=Q8yj=TU=vger.kernel.org=kvm-owner@kernel.org>
Date: Mon, 20 May 2019 11:02:17 +0800
From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH] vfio: vfio_iommu_type1: vfio_iommu_type1_caps() can be
 static
Message-ID: <20190520030217.GA48406@lkp-kbuild06>
References: <1558109810-18683-5-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558109810-18683-5-git-send-email-pmorel@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kbuild-all@01.org, sebott@linux.vnet.ibm.com, gerald.schaefer@de.ibm.com, pasic@linux.vnet.ibm.com, borntraeger@de.ibm.com, walling@linux.ibm.com, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, kvm@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, robin.murphy@arm.com
List-ID: <linux-s390.vger.kernel.org>


Fixes: f10b2b74bbea ("vfio: vfio_iommu_type1: implement VFIO_IOMMU_INFO_CAPABILITIES")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 vfio_iommu_type1.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 9435647..46a4939 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1704,8 +1704,8 @@ static int vfio_iommu_type1_zpci_grp(struct iommu_domain *domain,
 	return ret;
 }
 
-int vfio_iommu_type1_caps(struct vfio_iommu *iommu, struct vfio_info_cap *caps,
-			  size_t size)
+static int vfio_iommu_type1_caps(struct vfio_iommu *iommu, struct vfio_info_cap *caps,
+				 size_t size)
 {
 	struct vfio_domain *d;
 	unsigned long total_size, fn_size, grp_size;
