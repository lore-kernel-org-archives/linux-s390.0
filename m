Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:57566 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729592AbgGOJR3 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 15 Jul 2020 05:17:29 -0400
Date: Wed, 15 Jul 2020 11:17:20 +0200
From: Joerg Roedel <joro@8bytes.org>
Subject: Re: AMD IOMMU + SME + amdgpu regression
Message-ID: <20200715091720.GV27672@8bytes.org>
References: <1591915710.rakbpzst8h.none.ref@localhost>
 <1591915710.rakbpzst8h.none@localhost>
 <20200622100257.GD31822@suse.de>
 <1592839701.mxvvths2x9.none@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592839701.mxvvths2x9.none@localhost>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc: Joerg Roedel <jroedel@suse.de>, Andy Gross <agross@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Drake <drake@endlessm.com>, David Woodhouse <dwmw2@infradead.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Christoph Hellwig <hch@lst.de>, Heiko Stuebner <heiko@sntech.de>, Jean-Philippe Brucker <jean-philippe@linaro.org>, jonathan.derrick@intel.com, Jonathan Hunter <jonathanh@nvidia.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, David Rientjes <rientjes@google.com>, Rob Clark <robdclark@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Thierry Reding <thierry.reding@gmail.com>, virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>

On Mon, Jun 22, 2020 at 11:30:04AM -0400, Alex Xu (Hello71) wrote:
> Yes, it works with SME off with dbed452a078 ("dma-pool: decouple 
> DMA_REMAP from DMA_COHERENT_POOL") applied.

Okay, I can reproduce the problem on my Ryzen System, and the boot log
shows various warnings/bugs from the amdgpu driver. I think this should
be looked at by the AMDGPU folks first, as I didn't really got far
looking into the GPU drivers code.

Regards,

	Joerg
