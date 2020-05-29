Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <20191221150402.13868-1-murphyt7@tcd.ie>
 <465815ae-9292-f37a-59b9-03949cb68460@deltatee.com>
 <20200529124523.GA11817@infradead.org>
 <CGME20200529190523eucas1p2c086133e707257c0cdc002f502d4f51d@eucas1p2.samsung.com>
 <33137cfb-603c-86e8-1091-f36117ecfaf3@deltatee.com>
 <ef2150d5-7b6a-df25-c10d-e43316fe7812@samsung.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b9140772-0370-a858-578c-af503a06d8e9@deltatee.com>
Date: Fri, 29 May 2020 15:21:04 -0600
MIME-Version: 1.0
In-Reply-To: <ef2150d5-7b6a-df25-c10d-e43316fe7812@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/8] Convert the intel iommu driver to the dma-iommu api
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Christoph Hellwig <hch@infradead.org>
Cc: Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Julien Grall <julien.grall@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-samsung-soc@vger.kernel.org, Marc Zyngier <maz@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, Alex Williamson <alex.williamson@redhat.com>, linux-mediatek@lists.infradead.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-tegra@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, virtualization@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>



On 2020-05-29 3:11 p.m., Marek Szyprowski wrote:
> Patches are pending:
> https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/

Cool, nice! Though, I still don't think that fixes the issue in
i915_scatterlist.h given it still ignores sg_dma_len() and strictly
relies on sg_next()/sg_is_last() to stop iterating -- and I suspect this
is the bug that got in Tom's way.

>> However, as Robin pointed out, there are other ugly tricks like stopping
>> iterating through the SGL when sg_dma_len() is zero. For example, the
>> AMD driver appears to use drm_prime_sg_to_page_addr_arrays() which does
>> this trick and thus likely isn't buggy (otherwise, I'd expect someone to
>> have complained by now seeing AMD has already switched to IOMMU-DMA.
> 
> I'm not sure that this is a trick. Stopping at zero sg_dma_len() was 
> somewhere documented.

Well whatever you want to call it, it is ugly to have some drivers doing
one thing with the returned value and others assuming there's an extra
zero at the end. It just causes confusion for people reading/copying the
code. It would be better if they are all consistent. However, I concede
stopping at zero should not be broken, presently.

Logan
