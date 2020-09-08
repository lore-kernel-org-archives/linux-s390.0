Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730187AbgIHWnh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Sep 2020 18:43:37 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7EFC061786
        for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2020 15:43:32 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id h11so480364ilj.11
        for <linux-s390@vger.kernel.org>; Tue, 08 Sep 2020 15:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191221150402.13868-1-murphyt7@tcd.ie> <465815ae-9292-f37a-59b9-03949cb68460@deltatee.com>
 <20200529124523.GA11817@infradead.org> <CGME20200529190523eucas1p2c086133e707257c0cdc002f502d4f51d@eucas1p2.samsung.com>
 <33137cfb-603c-86e8-1091-f36117ecfaf3@deltatee.com> <ef2150d5-7b6a-df25-c10d-e43316fe7812@samsung.com>
 <b9140772-0370-a858-578c-af503a06d8e9@deltatee.com> <CALQxJuutRaeX89k2o4ffTKYRMizmMu0XbRnzpFuSSrkQR02jKg@mail.gmail.com>
 <766525c3-4da9-6db7-cd90-fb4b82cd8083@deltatee.com> <60a82319-cbee-4cd1-0d5e-3c407cc51330@linux.intel.com>
 <e598fb31-ef7a-c2ee-8a54-bf62d50c480c@deltatee.com> <b27cae1f-07ff-bef2-f125-a5f0d968016d@linux.intel.com>
In-Reply-To: <b27cae1f-07ff-bef2-f125-a5f0d968016d@linux.intel.com>
From: Tom Murphy <murphyt7@tcd.ie>
Date: Tue, 8 Sep 2020 23:43:19 +0100
Message-ID: <CALQxJut5c=cWdi+SVkN3JnbkhPSYmLkOyRUhduL-UJ9gyKn9Ow@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH 0/8] Convert the intel iommu driver to the
 dma-iommu api
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, kvm@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-tegra@vger.kernel.org, Julien Grall <julien.grall@arm.com>, Will Deacon <will@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-samsung-soc@vger.kernel.org, Marc Zyngier <maz@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>, linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, virtualization@lists.linux-foundation.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>, David Woodhouse <dwmw2@infradead.org>, Cornelia Huck <cohuck@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, Kukjin Kim <kgene@kernel.org>, Robin Murphy <robin.murphy@arm.com>

On Tue, 8 Sep 2020 at 16:56, Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
>
> On 08/09/2020 16:44, Logan Gunthorpe wrote:
> > On 2020-09-08 9:28 a.m., Tvrtko Ursulin wrote:
> >>>
> >>> diff --git a/drivers/gpu/drm/i915/i915_scatterlist.h
> >>> b/drivers/gpu/drm/i915/i915
> >>> index b7b59328cb76..9367ac801f0c 100644
> >>> --- a/drivers/gpu/drm/i915/i915_scatterlist.h
> >>> +++ b/drivers/gpu/drm/i915/i915_scatterlist.h
> >>> @@ -27,13 +27,19 @@ static __always_inline struct sgt_iter {
> >>>    } __sgt_iter(struct scatterlist *sgl, bool dma) {
> >>>           struct sgt_iter s = { .sgp = sgl };
> >>>
> >>> +       if (sgl && !sg_dma_len(s.sgp))
> >>
> >> I'd extend the condition to be, just to be safe:
> >>      if (dma && sgl && !sg_dma_len(s.sgp))
> >>
> >
> > Right, good catch, that's definitely necessary.
> >
> >>> +               s.sgp = NULL;
> >>> +
> >>>           if (s.sgp) {
> >>>                   s.max = s.curr = s.sgp->offset;
> >>> -               s.max += s.sgp->length;
> >>> -               if (dma)
> >>> +
> >>> +               if (dma) {
> >>> +                       s.max += sg_dma_len(s.sgp);
> >>>                           s.dma = sg_dma_address(s.sgp);
> >>> -               else
> >>> +               } else {
> >>> +                       s.max += s.sgp->length;
> >>>                           s.pfn = page_to_pfn(sg_page(s.sgp));
> >>> +               }
> >>
> >> Otherwise has this been tested or alternatively how to test it? (How to
> >> repro the issue.)
> >
> > It has not been tested. To test it, you need Tom's patch set without the
> > last "DO NOT MERGE" patch:
> >
> > https://lkml.kernel.org/lkml/20200907070035.GA25114@infradead.org/T/
>
> Tom, do you have a branch somewhere I could pull from? (Just being lazy
> about downloading a bunch of messages from the archives.)

I don't unfortunately. I'm working locally with poor internet.

>
> What GPU is in your Lenovo x1 carbon 5th generation and what
> graphical/desktop setup I need to repro?


Is this enough info?:

$ lspci -vnn | grep VGA -A 12
00:02.0 VGA compatible controller [0300]: Intel Corporation HD
Graphics 620 [8086:5916] (rev 02) (prog-if 00 [VGA controller])
    Subsystem: Lenovo ThinkPad X1 Carbon 5th Gen [17aa:224f]
    Flags: bus master, fast devsel, latency 0, IRQ 148
    Memory at eb000000 (64-bit, non-prefetchable) [size=16M]
    Memory at 60000000 (64-bit, prefetchable) [size=256M]
    I/O ports at e000 [size=64]
    [virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
    Capabilities: [40] Vendor Specific Information: Len=0c <?>
    Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
    Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable- 64bit-
    Capabilities: [d0] Power Management version 2
    Capabilities: [100] Process Address Space ID (PASID)
    Capabilities: [200] Address Translation Service (ATS)


>
> Regards,
>
> Tvrtko
