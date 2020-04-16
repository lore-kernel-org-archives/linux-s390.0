Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33176 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506575AbgDPLs5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Apr 2020 07:48:57 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200416114849euoutp017b89933e1c2279a8535b23248df36905~GSmgLsXbi2574225742euoutp01g
        for <linux-s390@vger.kernel.org>; Thu, 16 Apr 2020 11:48:49 +0000 (GMT)
Subject: Re: [PATCH v2 00/33] iommu: Move iommu_group setup to IOMMU core
 code
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <551c48b8-3268-6034-2dc6-cec3dbbec250@samsung.com>
Date: Thu, 16 Apr 2020 13:48:46 +0200
MIME-Version: 1.0
In-Reply-To: <20200414131542.25608-1-joro@8bytes.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
References: <CGME20200414131600eucas1p16f1ff6aedb780eb795a770dc08e5dec5@eucas1p1.samsung.com>
        <20200414131542.25608-1-joro@8bytes.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org

Hi Joerg,

On 14.04.2020 15:15, Joerg Roedel wrote:
> here is the second version of this patch-set. The first version with
> some more introductory text can be found here:
>
> 	https://lore.kernel.org/lkml/20200407183742.4344-1-joro@8bytes.org/
>
> Changes v1->v2:
>
> 	* Rebased to v5.7-rc1
>
> 	* Re-wrote the arm-smmu changes as suggested by Robin Murphy
>
> 	* Re-worked the Exynos patches to hopefully not break the
> 	  driver anymore

Thanks for this rework. This version is much better. Works fine on 
various Exynos-based boards (ARM and ARM64).

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com> (for Exynos and 
core changes)

> 	* Fixed a missing mutex_unlock() reported by Marek Szyprowski,
> 	  thanks for that.
>
> There is also a git-branch available with these patches applied:
>
> 	https://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git/log/?h=iommu-probe-device-v2
>
> Please review.
>
> Thanks,
>
> 	Joerg
>
> Joerg Roedel (32):
>    iommu: Move default domain allocation to separate function
>    iommu/amd: Implement iommu_ops->def_domain_type call-back
>    iommu/vt-d: Wire up iommu_ops->def_domain_type
>    iommu/amd: Remove dma_mask check from check_device()
>    iommu/amd: Return -ENODEV in add_device when device is not handled by
>      IOMMU
>    iommu: Add probe_device() and remove_device() call-backs
>    iommu: Move default domain allocation to iommu_probe_device()
>    iommu: Keep a list of allocated groups in __iommu_probe_device()
>    iommu: Move new probe_device path to separate function
>    iommu: Split off default domain allocation from group assignment
>    iommu: Move iommu_group_create_direct_mappings() out of
>      iommu_group_add_device()
>    iommu: Export bus_iommu_probe() and make is safe for re-probing
>    iommu/amd: Remove dev_data->passthrough
>    iommu/amd: Convert to probe/release_device() call-backs
>    iommu/vt-d: Convert to probe/release_device() call-backs
>    iommu/arm-smmu: Convert to probe/release_device() call-backs
>    iommu/pamu: Convert to probe/release_device() call-backs
>    iommu/s390: Convert to probe/release_device() call-backs
>    iommu/virtio: Convert to probe/release_device() call-backs
>    iommu/msm: Convert to probe/release_device() call-backs
>    iommu/mediatek: Convert to probe/release_device() call-backs
>    iommu/mediatek-v1 Convert to probe/release_device() call-backs
>    iommu/qcom: Convert to probe/release_device() call-backs
>    iommu/rockchip: Convert to probe/release_device() call-backs
>    iommu/tegra: Convert to probe/release_device() call-backs
>    iommu/renesas: Convert to probe/release_device() call-backs
>    iommu/omap: Remove orphan_dev tracking
>    iommu/omap: Convert to probe/release_device() call-backs
>    iommu/exynos: Use first SYSMMU in controllers list for IOMMU core
>    iommu/exynos: Convert to probe/release_device() call-backs
>    iommu: Remove add_device()/remove_device() code-paths
>    iommu: Unexport iommu_group_get_for_dev()
>
> Sai Praneeth Prakhya (1):
>    iommu: Add def_domain_type() callback in iommu_ops
>
>   drivers/iommu/amd_iommu.c       |  97 ++++----
>   drivers/iommu/amd_iommu_types.h |   1 -
>   drivers/iommu/arm-smmu-v3.c     |  38 +--
>   drivers/iommu/arm-smmu.c        |  39 ++--
>   drivers/iommu/exynos-iommu.c    |  24 +-
>   drivers/iommu/fsl_pamu_domain.c |  22 +-
>   drivers/iommu/intel-iommu.c     |  68 +-----
>   drivers/iommu/iommu.c           | 393 +++++++++++++++++++++++++-------
>   drivers/iommu/ipmmu-vmsa.c      |  60 ++---
>   drivers/iommu/msm_iommu.c       |  34 +--
>   drivers/iommu/mtk_iommu.c       |  24 +-
>   drivers/iommu/mtk_iommu_v1.c    |  50 ++--
>   drivers/iommu/omap-iommu.c      |  99 ++------
>   drivers/iommu/qcom_iommu.c      |  24 +-
>   drivers/iommu/rockchip-iommu.c  |  26 +--
>   drivers/iommu/s390-iommu.c      |  22 +-
>   drivers/iommu/tegra-gart.c      |  24 +-
>   drivers/iommu/tegra-smmu.c      |  31 +--
>   drivers/iommu/virtio-iommu.c    |  41 +---
>   include/linux/iommu.h           |  21 +-
>   20 files changed, 533 insertions(+), 605 deletions(-)
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
