Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 1/8] iommu/vt-d: clean up 32bit si_domain assignment
References: <20191221150402.13868-1-murphyt7@tcd.ie>
 <20191221150402.13868-2-murphyt7@tcd.ie>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e569e246-11a1-e8bd-9347-310284e96885@linux.intel.com>
Date: Mon, 23 Dec 2019 11:00:47 +0800
MIME-Version: 1.0
In-Reply-To: <20191221150402.13868-2-murphyt7@tcd.ie>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org
Cc: baolu.lu@linux.intel.com, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>, Julien Grall <julien.grall@arm.com>, Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org

Hi,

On 12/21/19 11:03 PM, Tom Murphy wrote:
> @@ -5618,9 +5583,13 @@ static int intel_iommu_add_device(struct device *dev)
>   	struct iommu_domain *domain;
>   	struct intel_iommu *iommu;
>   	struct iommu_group *group;
> +	u64 dma_mask = *dev->dma_mask;
>   	u8 bus, devfn;
>   	int ret;
>   
> +	if (dev->coherent_dma_mask && dev->coherent_dma_mask < dma_mask)
> +		dma_mask = dev->coherent_dma_mask;
> +
>   	iommu = device_to_iommu(dev, &bus, &devfn);
>   	if (!iommu)
>   		return -ENODEV;
> @@ -5640,7 +5609,12 @@ static int intel_iommu_add_device(struct device *dev)
>   	domain = iommu_get_domain_for_dev(dev);
>   	dmar_domain = to_dmar_domain(domain);
>   	if (domain->type == IOMMU_DOMAIN_DMA) {
> -		if (device_def_domain_type(dev) == IOMMU_DOMAIN_IDENTITY) {
> +		/*
> +		 * We check dma_mask >= dma_get_required_mask(dev) because
> +		 * 32 bit DMA falls back to non-identity mapping.
> +		 */
> +		if (device_def_domain_type(dev) == IOMMU_DOMAIN_IDENTITY &&
> +				dma_mask >= dma_get_required_mask(dev)) {
>   			ret = iommu_request_dm_for_dev(dev);
>   			if (ret) {
>   				dmar_remove_one_dev_info(dev);

dev->dma_mask is set to 32bit by default. During loading driver, it sets
the real dma_mask with dma_set_mask() according to the real capability.
Here you will always see 32bit dma_mask for each device.

Best regards,
baolu
