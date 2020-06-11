Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 11 Jun 2020 19:05:21 -0400
From: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: AMD IOMMU + SME + amdgpu regression
MIME-Version: 1.0
Message-Id: <1591915710.rakbpzst8h.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
References: <1591915710.rakbpzst8h.none.ref@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>, Christoph Hellwig <hch@lst.de>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Daniel Drake <drake@endlessm.com>, jonathan.derrick@intel.com, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>

Hi,

amdgpu + IOMMU + SME is now working for me on 5.7, yay! But, it is=20
broken on torvalds master, boo. On boot, depending on which exact commit=20
I test, it either hangs immediately (with built-in driver, before=20
starting initramfs), displays some errors then hangs, or spams the=20
screen with many amdgpu errors.

I bisected the black screen hang to:

commit dce8d6964ebdb333383bacf5e7ab8c27df151218
Author: Joerg Roedel <jroedel@suse.de>
Date:   Wed Apr 29 15:36:53 2020 +0200

    iommu/amd: Convert to probe/release_device() call-backs

    Convert the AMD IOMMU Driver to use the probe_device() and
    release_device() call-backs of iommu_ops, so that the iommu core code
    does the group and sysfs setup.

    Signed-off-by: Joerg Roedel <jroedel@suse.de>
    Link: https://lore.kernel.org/r/20200429133712.31431-16-joro@8bytes.org
    Signed-off-by: Joerg Roedel <jroedel@suse.de>

Testing torvalds master (623f6dc593) with the containing merge=20
(98bdc74b36) plus the DMA mapping merge (4e94d08734) reverted allows=20
amdgpu + IOMMU + SME to once again work.

I think that nobody is really working on amdgpu + SME, but it would be a=20
shame if it was supported and then incidentally broken by a small=20
change.

I am using an ASRock B450 Pro4 with Ryzen 1600 and ASUS RX 480. I don't=20
understand this code at all, but let me know what I can do to=20
troubleshoot.

Thanks,
Alex.
