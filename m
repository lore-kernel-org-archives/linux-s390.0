Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <20191221150402.13868-1-murphyt7@tcd.ie>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <465815ae-9292-f37a-59b9-03949cb68460@deltatee.com>
Date: Thu, 28 May 2020 18:00:44 -0600
MIME-Version: 1.0
In-Reply-To: <20191221150402.13868-1-murphyt7@tcd.ie>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/8] Convert the intel iommu driver to the dma-iommu api
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org
Cc: kvm@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-tegra@vger.kernel.org, Julien Grall <julien.grall@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-samsung-soc@vger.kernel.org, Marc Zyngier <maz@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, Eric Auger <eric.auger@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, linux-mediatek@lists.infradead.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, virtualization@lists.linux-foundation.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>, David Woodhouse <dwmw2@infradead.org>, Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Lu Baolu <baolu.lu@linux.intel.com>

Hi Tom,

On 2019-12-21 8:03 a.m., Tom Murphy wrote:
> This patchset converts the intel iommu driver to the dma-iommu api.

Just wanted to note that I've rebased your series on recent kernels and
have done some testing on my old Sandybridge machine (without the DO NOT
MERGE patch) and have found no issues. I hope this can make progress
soon and get merged soon. If you like you can add:

Tested-By: Logan Gunthorpe <logang@deltatee.com>

> While converting the driver I exposed a bug in the intel i915 driver which causes a huge amount of artifacts on the screen of my laptop. You can see a picture of it here:
> https://github.com/pippy360/kernelPatches/blob/master/IMG_20191219_225922.jpg
> 
> This issue is most likely in the i915 driver and is most likely caused by the driver not respecting the return value of the dma_map_ops::map_sg function. You can see the driver ignoring the return value here:
> https://github.com/torvalds/linux/blob/7e0165b2f1a912a06e381e91f0f4e495f4ac3736/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c#L51
> 
> Previously this didn’t cause issues because the intel map_sg always returned the same number of elements as the input scatter gather list but with the change to this dma-iommu api this is no longer the case. I wasn’t able to track the bug down to a specific line of code unfortunately.  

I did some digging into this myself and while I don't have full patch, I
think I traced it closer to the problem.

Sadly, ignoring the number of nents returned by map_sg() is endemic to
dma-buf users, but AMD's GPU driver seems to do the same thing,
presumably without issues.

Digging a bit further, I found that the i915 has an "innovative" way of
iterating through SGLs, see [1]. I suspect if __sgt_iter is changed to
increment with sg_dma_len() and return NULL when there is no length
left, it may fix the issue.

But, sorry, I don't really have the means or time to fix and test this
myself.

Thanks,

Logan

[1]
https://elixir.bootlin.com/linux/v5.7-rc7/source/drivers/gpu/drm/i915/i915_scatterlist.h#L76
