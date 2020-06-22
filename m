Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729348AbgFVO0Y (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 22 Jun 2020 10:26:24 -0400
Date: Mon, 22 Jun 2020 12:02:57 +0200
From: Joerg Roedel <jroedel@suse.de>
Subject: Re: AMD IOMMU + SME + amdgpu regression
Message-ID: <20200622100257.GD31822@suse.de>
References: <1591915710.rakbpzst8h.none.ref@localhost>
 <1591915710.rakbpzst8h.none@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591915710.rakbpzst8h.none@localhost>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc: Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>, Christoph Hellwig <hch@lst.de>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Daniel Drake <drake@endlessm.com>, jonathan.derrick@intel.com, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org

Hi Alex,

On Thu, Jun 11, 2020 at 07:05:21PM -0400, Alex Xu (Hello71) wrote:
> I am using an ASRock B450 Pro4 with Ryzen 1600 and ASUS RX 480. I don't 
> understand this code at all, but let me know what I can do to 
> troubleshoot.

Does it boot without SME enabled?


Regards,

	Joerg
