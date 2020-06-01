Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:20602 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgFAXUQ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 1 Jun 2020 19:20:16 -0400
Subject: Re: [PATCH v2 00/33] iommu: Move iommu_group setup to IOMMU core code
References: <20200414131542.25608-1-joro@8bytes.org>
 <20200529221623.qc6twmpzryh7nkvb@cantor>
 <20200601104240.7f5xhz7gooqhaq4n@cantor>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <47711845-98ee-95b8-aa95-423a36ed9741@linux.intel.com>
Date: Tue, 2 Jun 2020 07:16:22 +0800
MIME-Version: 1.0
In-Reply-To: <20200601104240.7f5xhz7gooqhaq4n@cantor>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
Cc: baolu.lu@linux.intel.com

Hi Jerry,

On 6/1/20 6:42 PM, Jerry Snitselaar wrote:
>>
>> Hi Joerg,
>>
>> With this patchset, I have an epyc system where if I boot with
>> iommu=nopt and force a dump I will see some io page faults for a nic
>> on the system. The vmcore is harvested and the system reboots. I
>> haven't reproduced it on other systems yet, but without the patchset I
>> don't see the io page faults during the kdump.
>>
>> Regards,
>> Jerry
> 
> I just hit an issue on a separate intel based system (kdump iommu=nopt),
> where it panics in during intel_iommu_attach_device, in is_aux_domain,
> due to device_domain_info being DEFER_DEVICE_DOMAIN_INFO. That doesn't
> get set to a valid address until the domain_add_dev_info call.
> 
> Is it as simple as the following?

I guess you won't hit this issue if you use iommu/next branch of Joerg's
tree. We've changed to use a generic helper to retrieve the valid per
device iommu data or NULL (if there's no).

Best regards,
baolu

> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 29d3940847d3..f1bbeed46a4c 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5053,8 +5053,8 @@ is_aux_domain(struct device *dev, struct 
> iommu_domain *domain)
>   {
>          struct device_domain_info *info = dev->archdata.iommu;
> 
> -       return info && info->auxd_enabled &&
> -                       domain->type == IOMMU_DOMAIN_UNMANAGED;
> +       return info && info != DEFER_DEVICE_DOMAIN_INFO &&
> +               info->auxd_enabled && domain->type == 
> IOMMU_DOMAIN_UNMANAGED;
>   }
> 
>   static void auxiliary_link_device(struct dmar_domain *domain,
> 
> 
> Regards,
> Jerry
