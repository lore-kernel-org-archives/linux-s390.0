Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:57020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729892AbgGAKxN (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 1 Jul 2020 06:53:13 -0400
Subject: Re: [PATCH v3 00/34] iommu: Move iommu_group setup to IOMMU core code
References: <20200429133712.31431-1-joro@8bytes.org>
 <20200701004020.GA6221@lca.pw>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <9b0ef27a-f249-a90b-9899-e53b946f83cc@arm.com>
Date: Wed, 1 Jul 2020 11:53:07 +0100
MIME-Version: 1.0
In-Reply-To: <20200701004020.GA6221@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Qian Cai <cai@lca.pw>, Joerg Roedel <joro@8bytes.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Daniel Drake <drake@endlessm.com>, Will Deacon <will@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>, jonathan.derrick@intel.com, linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, virtualization@lists.linux-foundation.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>

On 2020-07-01 01:40, Qian Cai wrote:
> Looks like this patchset introduced an use-after-free on arm-smmu-v3.
> 
> Reproduced using mlx5,
> 
> # echo 1 > /sys/class/net/enp11s0f1np1/device/sriov_numvfs
> # echo 0 > /sys/class/net/enp11s0f1np1/device/sriov_numvfs
> 
> The .config,
> https://github.com/cailca/linux-mm/blob/master/arm64.config
> 
> Looking at the free stack,
> 
> iommu_release_device->iommu_group_remove_device
> 
> was introduced in 07/34 ("iommu: Add probe_device() and release_device()
> call-backs").

Right, iommu_group_remove_device can tear down the group and call 
->domain_free before the driver has any knowledge of the last device 
going away via the ->release_device call.

I guess the question is do we simply flip the call order in 
iommu_release_device() so drivers can easily clean up their internal 
per-device state first, or do we now want them to be robust against 
freeing domains with devices still nominally attached?

Robin.
