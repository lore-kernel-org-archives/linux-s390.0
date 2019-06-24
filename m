Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:38664 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbfFXGT5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 24 Jun 2019 02:19:57 -0400
Date: Sun, 23 Jun 2019 23:19:45 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 0/5] iommu/amd: Convert the AMD iommu driver to the
 dma-iommu api
Message-ID: <20190624061945.GA4912@infradead.org>
References: <20190613223901.9523-1-murphyt7@tcd.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613223901.9523-1-murphyt7@tcd.ie>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tom Murphy <murphyt7@tcd.ie>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>, virtualization@lists.linux-foundation.org, David Brown <david.brown@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, David Woodhouse <dwmw2@infradead.org>

Tom,

next time please cc Jerg as the AMD IOMMU maintainer.

Joerg, any chance you could review this?  Toms patches to convert the
AMD and Intel IOMMU drivers to the dma-iommu code are going to make my
life in DMA land significantly easier, so I have a vested interest
in this series moving forward :)
