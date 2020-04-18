Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725804AbgDRMo4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 18 Apr 2020 08:44:56 -0400
Date: Sat, 18 Apr 2020 14:44:53 +0200
From: "joro@8bytes.org" <joro@8bytes.org>
Subject: Re: [PATCH v2 00/33] iommu: Move iommu_group setup to IOMMU core code
Message-ID: <20200418124452.GE6113@8bytes.org>
References: <20200414131542.25608-1-joro@8bytes.org>
 <20200417010335.31739-1-drake@endlessm.com>
 <aafed865c0254934986528b3ce9c4d34ff2fccad.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aafed865c0254934986528b3ce9c4d34ff2fccad.camel@intel.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc: "drake@endlessm.com" <drake@endlessm.com>, "heiko@sntech.de" <heiko@sntech.de>, "kgene@kernel.org" <kgene@kernel.org>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "will@kernel.org" <will@kernel.org>, "krzk@kernel.org" <krzk@kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "robdclark@gmail.com" <robdclark@gmail.com>, "gerald.schaefer@de.ibm.com" <gerald.schaefer@de.ibm.com>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "agross@kernel.org" <agross@kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

Hi Jonathan, Hi Daniel,

On Fri, Apr 17, 2020 at 01:14:30AM +0000, Derrick, Jonathan wrote:
> Hi Daniel> I should have CCed you on this, but it should temporarily resolve that
> issue:
> https://lists.linuxfoundation.org/pipermail/iommu/2020-April/043253.html

Yes, this is an issue in the hotplug handling path which I already fixed
in my branch. With next post of this series it should work.

Regards,

	Joerg
