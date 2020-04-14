Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:35566 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502999AbgDNNRa (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Apr 2020 09:17:30 -0400
Date: Tue, 14 Apr 2020 15:17:24 +0200
From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC PATCH 33/34] iommu: Remove add_device()/remove_device()
 code-paths
Message-ID: <20200414131724.GA14731@8bytes.org>
References: <20200407183742.4344-1-joro@8bytes.org>
 <CGME20200407183806eucas1p2cf45fbce5a43a6b4fe3a623b28da0606@eucas1p2.samsung.com>
 <20200407183742.4344-34-joro@8bytes.org>
 <1a88547f-ac90-825e-e529-a56c2c4e0391@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a88547f-ac90-825e-e529-a56c2c4e0391@samsung.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>

Hi Marek,

On Fri, Apr 10, 2020 at 12:39:38PM +0200, Marek Szyprowski wrote:
> > +		if (!group->default_domain)
> > +			continue;
> 
> It doesn't look straight from the above diff, but this continue leaks 
> group->lock taken.

You are right, thanks for the review! I fixed it in v2.

Regards,

	Joerg
