Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:58646 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbgDHPAS (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 8 Apr 2020 11:00:18 -0400
Date: Wed, 8 Apr 2020 17:00:15 +0200
From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC PATCH 31/34] iommu/exynos: Create iommu_device in struct
 exynos_iommu_owner
Message-ID: <20200408150014.GM3103@8bytes.org>
References: <20200407183742.4344-1-joro@8bytes.org>
 <CGME20200407184501eucas1p25407bc96e4345df406cf6ba061ae6a82@eucas1p2.samsung.com>
 <20200407183742.4344-32-joro@8bytes.org>
 <449e7f16-e719-9617-ec92-63b82c0bc33f@samsung.com>
 <f59b0bb3-8c08-9cc9-bb1a-e69b7b226f60@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f59b0bb3-8c08-9cc9-bb1a-e69b7b226f60@samsung.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>

Hi Marek,

On Wed, Apr 08, 2020 at 04:23:05PM +0200, Marek Szyprowski wrote:
> I need a place to initialize properly all the structures for the given 
> master (IOMMU client device, the one which performs DMA operations).

That could be in the probe_device() call-back, no?

> I tried to move all the initialization from xlate() to device_probe(), 
> but such approach doesn't work.

device_probe() is exynos_sysmmu_probe(), then yes, this is called before
any of the xlate() calls are made.

Would it work to keep the iommu_device structures in the sysmmus and
also create them for the owners? This isn't really a nice solution but
should work the the IOMMU driver until there is a better way to fix
this.

Regards,

	Joerg
