Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbgGJTS1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 10 Jul 2020 15:18:27 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD7BC08E806
        for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2020 12:18:27 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id y2so7182503ioy.3
        for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2020 12:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190908165642.22253-1-murphyt7@tcd.ie> <20190908165642.22253-5-murphyt7@tcd.ie>
 <20200710155933.GA20886@lst.de>
In-Reply-To: <20200710155933.GA20886@lst.de>
From: Tom Murphy <murphyt7@tcd.ie>
Date: Fri, 10 Jul 2020 12:18:15 -0700
Message-ID: <CALQxJuumgH9xR-J1Nj3LQsLW6k+4ie_0Ho3N9UJiN4R0JBGYoQ@mail.gmail.com>
Subject: Re: [PATCH V6 4/5] iommu/dma-iommu: Use the dev->coherent_dma_mask
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Andy Gross <agross@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org

>Btw, what is the current state of converting intel-iommu to the dma-iommu

These changes expose a bug in the i915 intel driver which hasn't been
fixed yet. I don't think anyone is actively working on it but I plan
on merging as many patches as I can so it's easier to do the
intel-iommu -> dma-iommu conversion once the bug is fixed.

You can read more about it here:
https://patchwork.kernel.org/cover/11306999/

On Fri, 10 Jul 2020 at 08:59, Christoph Hellwig <hch@lst.de> wrote:
>
> Btw, what is the current state of converting intel-iommu to the dma-iommu
> code?
