Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:51614 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfFEFub (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Jun 2019 01:50:31 -0400
Date: Tue, 4 Jun 2019 22:50:21 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 1/4] iommu: Add gfp parameter to iommu_ops::map
Message-ID: <20190605055021.GA15036@infradead.org>
References: <20190506185207.31069-1-tmurphy@arista.com>
 <20190506185207.31069-2-tmurphy@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190506185207.31069-2-tmurphy@arista.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tom Murphy <tmurphy@arista.com>
Cc: iommu@lists.linux-foundation.org, Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>, David Brown <david.brown@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org, Kukjin Kim <kgene@kernel.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Andy Gross <andy.gross@linaro.org>, linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, murphyt7@tcd.ie, David Woodhouse <dwmw2@infradead.org>

On Mon, May 06, 2019 at 07:52:03PM +0100, Tom Murphy via iommu wrote:
> We can remove the mutex lock from amd_iommu_map and amd_iommu_unmap.
> iommu_map doesn’t lock while mapping and so no two calls should touch
> the same iova range. The AMD driver already handles the page table page
> allocations without locks so we can safely remove the locks.

Btw, this really should be a separate patch.
