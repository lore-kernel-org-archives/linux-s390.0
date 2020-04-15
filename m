Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:33899 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393565AbgDOGg0 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 15 Apr 2020 02:36:26 -0400
Subject: Re: [PATCH v2 07/33] iommu: Add probe_device() and remove_device()
 call-backs
References: <20200414131542.25608-1-joro@8bytes.org>
 <20200414131542.25608-8-joro@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0ad37581-b464-30ac-c503-4c0daaf43867@linux.intel.com>
Date: Wed, 15 Apr 2020 14:36:20 +0800
MIME-Version: 1.0
In-Reply-To: <20200414131542.25608-8-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>

On 2020/4/14 21:15, Joerg Roedel wrote:
> From: Joerg Roedel<jroedel@suse.de>
> 
> Add call-backs to 'struct iommu_ops' as an alternative to the
> add_device() and remove_device() call-backs, which will be removed when
> all drivers are converted.
> 
> The new call-backs will not setupt IOMMU groups and domains anymore,
> so also add a probe_finalize() call-back where the IOMMU driver can do
> per-device setup work which require the device to be set up with a
> group and a domain.

The subject is inaccurate. probe_device() and release_device() are
added to replace the add and remove pair.

Best regards,
baolu
