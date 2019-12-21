Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34193 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfLUXqm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 21 Dec 2019 18:46:42 -0500
From: Arvind Sankar <nivedita@alum.mit.edu>
Date: Sat, 21 Dec 2019 18:46:37 -0500
Subject: Re: [PATCH 1/8] iommu/vt-d: clean up 32bit si_domain assignment
Message-ID: <20191221234635.GA99623@rani.riverdale.lan>
References: <20191221150402.13868-1-murphyt7@tcd.ie>
 <20191221150402.13868-2-murphyt7@tcd.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191221150402.13868-2-murphyt7@tcd.ie>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tom Murphy <murphyt7@tcd.ie>
Cc: iommu@lists.linux-foundation.org, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>, Julien Grall <julien.grall@arm.com>, Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org

On Sat, Dec 21, 2019 at 03:03:53PM +0000, Tom Murphy wrote:
> In the intel iommu driver devices which only support 32bit DMA can't be
> direct mapped. The implementation of this is weird. Currently we assign
> it a direct mapped domain and then remove the domain later and replace
> it with a domain of type IOMMU_DOMAIN_IDENTITY. We should just assign it
> a domain of type IOMMU_DOMAIN_IDENTITY from the begging rather than
> needlessly swapping domains.
> 
> Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
> ---
>  drivers/iommu/intel-iommu.c | 88 +++++++++++++------------------------
>  1 file changed, 31 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 0c8d81f56a30..c1ea66467918 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5640,7 +5609,12 @@ static int intel_iommu_add_device(struct device *dev)
>  	domain = iommu_get_domain_for_dev(dev);
>  	dmar_domain = to_dmar_domain(domain);
>  	if (domain->type == IOMMU_DOMAIN_DMA) {
> -		if (device_def_domain_type(dev) == IOMMU_DOMAIN_IDENTITY) {
> +		/*
> +		 * We check dma_mask >= dma_get_required_mask(dev) because
> +		 * 32 bit DMA falls back to non-identity mapping.
> +		 */
> +		if (device_def_domain_type(dev) == IOMMU_DOMAIN_IDENTITY &&
> +				dma_mask >= dma_get_required_mask(dev)) {
>  			ret = iommu_request_dm_for_dev(dev);
>  			if (ret) {
>  				dmar_remove_one_dev_info(dev);
> -- 
> 2.20.1
> 

Should this be dma_direct_get_required_mask? dma_get_required_mask may
return DMA_BIT_MASK(32) -- it callbacks into intel_get_required_mask,
but I'm not sure what iommu_no_mapping(dev) will do at this point?
