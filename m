Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:39738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbgDHPHl (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 8 Apr 2020 11:07:41 -0400
Subject: Re: [RFC PATCH 17/34] iommu/arm-smmu: Store device instead of group
 in arm_smmu_s2cr
References: <20200407183742.4344-1-joro@8bytes.org>
 <20200407183742.4344-18-joro@8bytes.org>
 <98c10a41-d223-e375-9742-b6471c3dc33c@arm.com>
 <20200408143707.GK3103@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f8b541c2-9271-fc48-dde6-166a2ed6679f@arm.com>
Date: Wed, 8 Apr 2020 16:07:33 +0100
MIME-Version: 1.0
In-Reply-To: <20200408143707.GK3103@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>

On 2020-04-08 3:37 pm, Joerg Roedel wrote:
> Hi Robin,
> 
> thanks for looking into this.
> 
> On Wed, Apr 08, 2020 at 01:09:40PM +0100, Robin Murphy wrote:
>> For a hot-pluggable bus where logical devices may share Stream IDs (like
>> fsl-mc), this could happen:
>>
>>    create device A
>>    iommu_probe_device(A)
>>      iommu_device_group(A) -> alloc group X
>>    create device B
>>    iommu_probe_device(B)
>>      iommu_device_group(A) -> lookup returns group X
>>    ...
>>    iommu_remove_device(A)
>>    delete device A
>>    create device C
>>    iommu_probe_device(C)
>>      iommu_device_group(C) -> use-after-free of A
>>
>> Preserving the logical behaviour here would probably look *something* like
>> the mangled diff below, but I haven't thought it through 100%.
> 
> Yeah, I think you are right. How about just moving the loop which sets
> s2crs[idx].group to arm_smmu_device_group()? In that case I can drop
> this patch and leave the group pointer in place.

Isn't that exactly what I suggested? :)

I don't recall for sure, but knowing me, that bit of group bookkeeping 
is only where it currently is because it cheekily saves iterating the 
IDs a second time. I don't think there's any technical reason.

Robin.
