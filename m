Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52318 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S369427AbgDOM3p (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 15 Apr 2020 08:29:45 -0400
Date: Wed, 15 Apr 2020 14:29:40 +0200
From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2 13/33] iommu: Export bus_iommu_probe() and make is
 safe for re-probing
Message-ID: <20200415122940.GB21899@suse.de>
References: <20200414131542.25608-1-joro@8bytes.org>
 <20200414131542.25608-14-joro@8bytes.org>
 <1853992c-47a6-3724-812c-a52558c13732@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1853992c-47a6-3724-812c-a52558c13732@linux.intel.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org

Hi Baolu,

On Wed, Apr 15, 2020 at 02:10:03PM +0800, Lu Baolu wrote:
> On 2020/4/14 21:15, Joerg Roedel wrote:
> > > +	/* Device is probed already if in a group */
> > +	if (iommu_group_get(dev) != NULL)
> 
> Same as
> 	if (iommu_group_get(dev))
> ?
> 
> By the way, do we need to put the group if device has already been
> probed?

Right, fixed both, thank you.


Regards,

	Joerg
