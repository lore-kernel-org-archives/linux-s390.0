Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37432 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgE2VLz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 29 May 2020 17:11:55 -0400
Subject: Re: [PATCH 0/8] Convert the intel iommu driver to the dma-iommu api
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <ef2150d5-7b6a-df25-c10d-e43316fe7812@samsung.com>
Date: Fri, 29 May 2020 23:11:49 +0200
MIME-Version: 1.0
In-Reply-To: <33137cfb-603c-86e8-1091-f36117ecfaf3@deltatee.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
References: <20191221150402.13868-1-murphyt7@tcd.ie>
        <465815ae-9292-f37a-59b9-03949cb68460@deltatee.com>
        <20200529124523.GA11817@infradead.org>
        <CGME20200529190523eucas1p2c086133e707257c0cdc002f502d4f51d@eucas1p2.samsung.com>
        <33137cfb-603c-86e8-1091-f36117ecfaf3@deltatee.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@infradead.org>
Cc: Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Julien Grall <julien.grall@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-samsung-soc@vger.kernel.org, Marc Zyngier <maz@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, Alex Williamson <alex.williamson@redhat.com>, linux-mediatek@lists.infradead.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-tegra@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, virtualization@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

Hi Logan,

On 29.05.2020 21:05, Logan Gunthorpe wrote:
> On 2020-05-29 6:45 a.m., Christoph Hellwig wrote:
>> On Thu, May 28, 2020 at 06:00:44PM -0600, Logan Gunthorpe wrote:
>>>> This issue is most likely in the i915 driver and is most likely caused by the driver not respecting the return value of the dma_map_ops::map_sg function. You can see the driver ignoring the return value here:
>>>> https://protect2.fireeye.com/url?k=ca25a34b-97f7b813-ca242804-0cc47a31c8b4-0ecdffc9f56851e1&q=1&u=https%3A%2F%2Fgithub.com%2Ftorvalds%2Flinux%2Fblob%2F7e0165b2f1a912a06e381e91f0f4e495f4ac3736%2Fdrivers%2Fgpu%2Fdrm%2Fi915%2Fgem%2Fi915_gem_dmabuf.c%23L51
>>>>
>>>> Previously this didn’t cause issues because the intel map_sg always returned the same number of elements as the input scatter gather list but with the change to this dma-iommu api this is no longer the case. I wasn’t able to track the bug down to a specific line of code unfortunately.
>> Mark did a big audit into the map_sg API abuse and initially had
>> some i915 patches, but then gave up on them with this comment:
>>
>> "The biggest TODO is DRM/i915 driver and I don't feel brave enough to fix
>>   it fully. The driver creatively uses sg_table->orig_nents to store the
>>   size of the allocate scatterlist and ignores the number of the entries
>>   returned by dma_map_sg function. In this patchset I only fixed the
>>   sg_table objects exported by dmabuf related functions. I hope that I
>>   didn't break anything there."
>>
>> it would be really nice if the i915 maintainers could help with sorting
>> that API abuse out.
>>
> I agree completely that the API abuse should be sorted out, but I think
> that's much larger than just the i915 driver. Pretty much every dma-buf
> map_dma_buf implementation I looked at ignores the returned nents of
> sg_attrs. This sucks, but I don't think it's the bug Tom ran into. See:
>
> amdgpu_dma_buf_map
> armada_gem_prime_map_dma_buf
> drm_gem_map_dma_buf
> i915_gem_map_dma_buf
> tegra_gem_prime_map_dma_buf
>
> So this should probably be addressed by the whole GPU community.

Patches are pending:
https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/

> However, as Robin pointed out, there are other ugly tricks like stopping
> iterating through the SGL when sg_dma_len() is zero. For example, the
> AMD driver appears to use drm_prime_sg_to_page_addr_arrays() which does
> this trick and thus likely isn't buggy (otherwise, I'd expect someone to
> have complained by now seeing AMD has already switched to IOMMU-DMA.

I'm not sure that this is a trick. Stopping at zero sg_dma_len() was 
somewhere documented.

> As I tried to point out in my previous email, i915 does not do this
> trick. In fact, it completely ignores sg_dma_len() and is thus
> completely broken. See i915_scatterlist.h and the __sgt_iter() function.
> So it doesn't sound to me like Mark's fix would address the issue at
> all. Per my previous email, I'd guess that it can be fixed simply by
> adjusting the __sgt_iter() function to do something more sensible.
> (Better yet, if possible, ditch __sgt_iter() and use the common DRM
> function that AMD uses).
>
> This would at least allow us to make progress with Tom's IOMMU-DMA patch
> set and once that gets in, it will be harder for other drivers to make
> the same mistake.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
