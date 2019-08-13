Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:60956 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbfHMNHX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 13 Aug 2019 09:07:23 -0400
Date: Tue, 13 Aug 2019 06:07:11 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 0/5] iommu/amd: Convert the AMD iommu driver to the
 dma-iommu api
Message-ID: <20190813130711.GA30468@infradead.org>
References: <20190613223901.9523-1-murphyt7@tcd.ie>
 <20190624061945.GA4912@infradead.org>
 <20190810071952.GA25550@infradead.org>
 <CALQxJuvxBc3MH3_B_fZ3FvURHOM3F3dvvZ6x=GtALUAvyu7Qxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALQxJuvxBc3MH3_B_fZ3FvURHOM3F3dvvZ6x=GtALUAvyu7Qxw@mail.gmail.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tom Murphy <murphyt7@tcd.ie>
Cc: Christoph Hellwig <hch@infradead.org>, Joerg Roedel <joro@8bytes.org>, Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>, virtualization@lists.linux-foundation.org, David Brown <david.brown@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org, Kukjin Kim <kgene@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Andy Gross <agross@kernel.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>

On Tue, Aug 13, 2019 at 08:09:26PM +0800, Tom Murphy wrote:
> Hi Christoph,
> 
> I quit my job and am having a great time traveling South East Asia.

Enjoy!  I just returned from my vacation.

> I definitely don't want this work to go to waste and I hope to repost it
> later this week but I can't guarantee it.
> 
> Let me know if you need this urgently.

It isn't in any strict sense urgent.  I just have various DMA API plans
that I'd rather just implement in dma-direct and dma-iommu rather than
also in two additional commonly used iommu drivers.  So on the one had
the sooner the better, on the other hand no real urgency.
