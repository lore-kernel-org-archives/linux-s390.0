Return-Path: <SRS0=fZwd=TA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Subject: Re: [PATCH v2 3/4] iommu/dma-iommu: Use the dev->coherent_dma_mask
References: <20190430002952.18909-1-tmurphy@arista.com>
 <20190430002952.18909-4-tmurphy@arista.com>
 <20190430111222.GA3191@infradead.org>
 <da835ce2-f73e-3035-e1d7-d3028cc1a838@arm.com>
 <20190430113253.GA23210@infradead.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <96ebb6fc-a889-fa94-09ba-65d505b85724@arm.com>
Date: Tue, 30 Apr 2019 13:04:55 +0100
MIME-Version: 1.0
In-Reply-To: <20190430113253.GA23210@infradead.org>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: Christoph Hellwig <hch@infradead.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>, David Brown <david.brown@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org, Kukjin Kim <kgene@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tom Murphy <tmurphy@arista.com>, linux-kernel@vger.kernel.org, murphyt7@tcd.ie, iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On 30/04/2019 12:32, Christoph Hellwig wrote:
> On Tue, Apr 30, 2019 at 12:27:02PM +0100, Robin Murphy wrote:
>>> Hmm, I don't think we need the DMA mask for the MSI mapping, this
>>> should probably always use a 64-bit mask.
>>
>> If that were true then we wouldn't need DMA masks for regular mappings
>> either. If we have to map the MSI doorbell at all, then we certainly have to
>> place it at an IOVA that the relevant device is actually capable of
>> addressing.
> 
> Well, as shown by the patch below we don't even look at the DMA mask
> for the MSI page - we just allocate from bottom to top.

In the trivial cookie for unmanaged domains, yes, but in that case the 
responsibility is on VFIO to provide a suitable (i.e. sub-32-bit) 
address range for that cookie in the first place. In the managed case, 
allocation uses the streaming mask via iommu_dma_get_msi_page() calling 
__iommu_dma_map(). Admittedly the mask can then get overlooked when 
reusing an existing mapping, which strictly could pose a problem if you 
have multiple devices with incompatible masks in the same group (and 
such that the PCI stuff doesn't already mitigate it), but that's such an 
obscure corner case that I'm reticent to introduce the complication to 
handle it until it's actually proven necessary.

Robin.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
