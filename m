Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731120AbgDNNUd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Apr 2020 09:20:33 -0400
Date: Tue, 14 Apr 2020 15:20:29 +0200
From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/exynos: Get rid of 'struct exynos_iommu_owner'
 exynos_iommu_owner
Message-ID: <20200414132029.GB14731@8bytes.org>
References: <20200407183742.4344-1-joro@8bytes.org>
 <CGME20200407184501eucas1p25407bc96e4345df406cf6ba061ae6a82@eucas1p2.samsung.com>
 <20200407183742.4344-32-joro@8bytes.org>
 <449e7f16-e719-9617-ec92-63b82c0bc33f@samsung.com>
 <f59b0bb3-8c08-9cc9-bb1a-e69b7b226f60@samsung.com>
 <20200409114620.GA16298@8bytes.org>
 <40af831b-d00c-0cf9-0a06-e60c048a9ab8@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40af831b-d00c-0cf9-0a06-e60c048a9ab8@samsung.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>

On Thu, Apr 09, 2020 at 03:58:00PM +0200, Marek Szyprowski wrote:
> I've checked and it works fine on top of 
> ff68eb23308e6538ec7864c83d39540f423bbe90. However I'm not a fan of 
> removing this 'owner' structure. It gave a nice abstraction for the all 
> SYSMMU controllers for the given device (although most devices in the 
> system have only one SYSMMU). Why this structure is a problem for your 
> rework?

Okay, the structure itself is not a problem, I just thought it is not
really necessary. But to keep things simple I've taken another approach
for v2 of this series: Just use the first SYSMMU of the controllers list
to link the device and the IOMMU. When the owner structure exists there
is always one entry in this list, so that should work fine.

Regards,

	Joerg
