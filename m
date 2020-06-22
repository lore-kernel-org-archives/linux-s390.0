Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from sonic310-21.consmr.mail.gq1.yahoo.com ([98.137.69.147]:33157
        "EHLO sonic310-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729247AbgFVPaL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 22 Jun 2020 11:30:11 -0400
Date: Mon, 22 Jun 2020 11:30:04 -0400
From: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: AMD IOMMU + SME + amdgpu regression
References: <1591915710.rakbpzst8h.none.ref@localhost>
        <1591915710.rakbpzst8h.none@localhost> <20200622100257.GD31822@suse.de>
In-Reply-To: <20200622100257.GD31822@suse.de>
MIME-Version: 1.0
Message-Id: <1592839701.mxvvths2x9.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Joerg Roedel <jroedel@suse.de>
Cc: Andy Gross <agross@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Drake <drake@endlessm.com>, David Woodhouse <dwmw2@infradead.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Christoph Hellwig <hch@lst.de>, Heiko Stuebner <heiko@sntech.de>, Jean-Philippe Brucker <jean-philippe@linaro.org>, jonathan.derrick@intel.com, Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, David Rientjes <rientjes@google.com>, Rob Clark <robdclark@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Thierry Reding <thierry.reding@gmail.com>, virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>

Excerpts from Joerg Roedel's message of June 22, 2020 6:02 am:
> Hi Alex,
>=20
> On Thu, Jun 11, 2020 at 07:05:21PM -0400, Alex Xu (Hello71) wrote:
>> I am using an ASRock B450 Pro4 with Ryzen 1600 and ASUS RX 480. I don't=20
>> understand this code at all, but let me know what I can do to=20
>> troubleshoot.
>=20
> Does it boot without SME enabled?
>=20
>=20
> Regards,
>=20
> 	Joerg
>=20

Yes, it works with SME off with dbed452a078 ("dma-pool: decouple=20
DMA_REMAP from DMA_COHERENT_POOL") applied.
