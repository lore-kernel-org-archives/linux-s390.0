Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:34500 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbfHTJlv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Aug 2019 05:41:51 -0400
Date: Tue, 20 Aug 2019 02:41:43 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V5 1/5] iommu/amd: Remove unnecessary locking from AMD
 iommu driver
Message-ID: <20190820094143.GA24154@infradead.org>
References: <20190815110944.3579-1-murphyt7@tcd.ie>
 <20190815110944.3579-2-murphyt7@tcd.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190815110944.3579-2-murphyt7@tcd.ie>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tom Murphy <murphyt7@tcd.ie>
Cc: iommu@lists.linux-foundation.org, Heiko Stuebner <heiko@sntech.de>, virtualization@lists.linux-foundation.org, linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Robin Murphy <robin.murphy@arm.com>

On Thu, Aug 15, 2019 at 12:09:39PM +0100, Tom Murphy wrote:
> We can remove the mutex lock from amd_iommu_map and amd_iommu_unmap.
> iommu_map doesn’t lock while mapping and so no two calls should touch
> the same iova range. The AMD driver already handles the page table page
> allocations without locks so we can safely remove the locks.

I've been looking over the code and trying to understand how the
synchronization works.  I gues we the cmpxchg64 in free_clear_pte
is the important point here?  I have to admit I don't fully understand
the concurrency issues here, but neither do I understand what the
mutex you removed might have helped to start with.
