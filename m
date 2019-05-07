Return-Path: <SRS0=QM8K=TH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Date: Mon, 6 May 2019 23:40:00 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 2/4] iommu/dma-iommu: Handle deferred devices
Message-ID: <20190507064000.GB5173@infradead.org>
References: <20190506185207.31069-1-tmurphy@arista.com>
 <20190506185207.31069-3-tmurphy@arista.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190506185207.31069-3-tmurphy@arista.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: Tom Murphy <tmurphy@arista.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>, David Brown <david.brown@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org, Kukjin Kim <kgene@kernel.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Andy Gross <andy.gross@linaro.org>, linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, murphyt7@tcd.ie, Rob Clark <robdclark@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, May 06, 2019 at 07:52:04PM +0100, Tom Murphy wrote:
> +static int handle_deferred_device(struct device *dev)
> +{
> +	struct iommu_domain *domain;
> +	const struct iommu_ops *ops;
> +
> +	if (!is_kdump_kernel())
> +		return 0;
> +
> +	domain = iommu_get_domain_for_dev(dev);

> -	dma_handle =__iommu_dma_map(dev, phys, size,
> +	if (unlikely(handle_deferred_device(dev)))
> +		return DMA_MAPPING_ERROR;
> +
> +	dma_handle = __iommu_dma_map(dev, phys, size,

__iommu_dma_map already looks up the domain, and as far as I can
tell all callers need the handle_deferred_device call.  Should we
just move it to there and pass the domain from the caller?

Also shouldn't the iommu_attach_device call inside
handle_deferred_device also get an unlikely marker?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
