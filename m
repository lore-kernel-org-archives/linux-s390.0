Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v3 04/34] iommu/vt-d: Wire up iommu_ops->def_domain_type
References: <20200429133712.31431-1-joro@8bytes.org>
 <20200429133712.31431-5-joro@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b091a9e0-4bbb-2cd9-861e-e958bc691f73@linux.intel.com>
Date: Thu, 30 Apr 2020 07:58:18 +0800
MIME-Version: 1.0
In-Reply-To: <20200429133712.31431-5-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: baolu.lu@linux.intel.com, Daniel Drake <drake@endlessm.com>, jonathan.derrick@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>

On 2020/4/29 21:36, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The Intel VT-d driver already has a matching function to determine the
> default domain type for a device. Wire it up in intel_iommu_ops.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel-iommu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index ef0a5246700e..b9f905a55dda 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -6209,6 +6209,7 @@ const struct iommu_ops intel_iommu_ops = {
>   	.dev_enable_feat	= intel_iommu_dev_enable_feat,
>   	.dev_disable_feat	= intel_iommu_dev_disable_feat,
>   	.is_attach_deferred	= intel_iommu_is_attach_deferred,
> +	.def_domain_type	= device_def_domain_type,
>   	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
>   };
>   
> 
