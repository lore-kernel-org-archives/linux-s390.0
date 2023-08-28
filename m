Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31A0C83F11
	for <linux-s390@archiver.kernel.org>; Mon, 28 Aug 2023 23:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjH1XZI (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 28 Aug 2023 19:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbjH1XYz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Aug 2023 19:24:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0B1114
        for <linux-s390@vger.kernel.org>; Mon, 28 Aug 2023 16:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693265048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xTlRxnsNejmw67GltYX+utAoy4aZnJxgNkm5+nl9i5c=;
        b=Bi3gKJd+g2cFzeUb3xoWBbqg3PReQO0xy4NAvDXlAGc7wy/Z1J0u5hHt8AKbj/LmEAU4Ql
        5vZHLAxJf4eGIZZMHr6QdpxqwPRNdfNBQPkf3OZrXnIn0w+ubYSYKE4O7j912j/47F/UVD
        dyzXjZuQZb32WGy4M7dt97lVrPsVv4Q=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-elV-tUKTPLKwkq2DErDFoQ-1; Mon, 28 Aug 2023 19:24:06 -0400
X-MC-Unique: elV-tUKTPLKwkq2DErDFoQ-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-57013c62b3dso1180109a12.2
        for <linux-s390@vger.kernel.org>; Mon, 28 Aug 2023 16:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693265046; x=1693869846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTlRxnsNejmw67GltYX+utAoy4aZnJxgNkm5+nl9i5c=;
        b=BZqIcU7T9Ua3IgHOKJqj9TV2pXyH74J21H7yMlV9t2K7rXE6wVRBBcInkRJ6P92vAI
         aSjSNxGAPr7fzt8jabBz8rU69XNFBBGDF5uekbwaL5COTmIFmYZlSA+v8fkSgQNAVKDq
         bzJ615BdAjin6Mz4j8QTRNloO6N8pO8yJQTUgVkIN0hxqdPg+MnFfuCesQWdYEVBDCu3
         o99pGrOhwWh/0HKU99qSCzcIN0zUbd9IQcKNg0WTghKjNCzaSliFFtVm5g46ktn0iFPH
         IHSsX3U9RidhxR2kqehfW1kZJcdoCfP9ufd1SpbatPno37LzidGmkMfjdxIrKHz1NDNS
         0UDQ==
X-Gm-Message-State: AOJu0YyWc9pZ5Yvgo5deAGV/P5Gtpo54Z+Xs+ctlBoGyeHm9iUV8khMd
        kN6xiJF325mCJMFbq6GJ0bLKK3kaRgcGCHfJCnD4QP7t8yR1xOsxiciVltHRZ+zDnHRIXT4zGvZ
        Z++w3d8j/VMQ/5o5u0lXYWg==
X-Received: by 2002:a05:6a20:138f:b0:10c:7c72:bdf9 with SMTP id hn15-20020a056a20138f00b0010c7c72bdf9mr18329551pzc.29.1693265045859;
        Mon, 28 Aug 2023 16:24:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8Ty56TNbGFuBUAvk0gJFhf9IoSXDvKLMofXm6bHW4BVTeieXHXsUmxMoZ3DKq2KwFtbABPg==
X-Received: by 2002:a05:6a20:138f:b0:10c:7c72:bdf9 with SMTP id hn15-20020a056a20138f00b0010c7c72bdf9mr18329511pzc.29.1693265045554;
        Mon, 28 Aug 2023 16:24:05 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id v12-20020a170902b7cc00b001993a1fce7bsm7913930plz.196.2023.08.28.16.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 16:24:05 -0700 (PDT)
Date:   Mon, 28 Aug 2023 16:24:04 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Andy Gross <agross@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bjorn Andersson <andersson@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linuxppc-dev@lists.ozlabs.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Chen-Yu Tsai <wens@csie.org>, Will Deacon <will@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Steven Price <steven.price@arm.com>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v7 24/24] iommu: Convert remaining simple drivers to
 domain_alloc_paging()
Message-ID: <4pidxw6zc2sk2sypjdobusdrdbpwa7gddifxwnm2c2sdtfsp7t@yg3hup2mhpbr>
References: <0-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
 <24-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Aug 23, 2023 at 01:47:38PM -0300, Jason Gunthorpe wrote:
> These drivers don't support IOMMU_DOMAIN_DMA, so this commit effectively
> allows them to support that mode.
> 
> The prior work to require default_domains makes this safe because every
> one of these drivers is either compilation incompatible with dma-iommu.c,
> or already establishing a default_domain. In both cases alloc_domain()
> will never be called with IOMMU_DOMAIN_DMA for these drivers so it is safe
> to drop the test.
> 
> Removing these tests clarifies that the domain allocation path is only
> about the functionality of a paging domain and has nothing to do with
> policy of how the paging domain is used for UNMANAGED/DMA/DMA_FQ.
> 
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Tested-by: Steven Price <steven.price@arm.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/msm_iommu.c    | 7 ++-----
>  drivers/iommu/mtk_iommu_v1.c | 7 ++-----
>  drivers/iommu/omap-iommu.c   | 7 ++-----
>  drivers/iommu/s390-iommu.c   | 7 ++-----
>  4 files changed, 8 insertions(+), 20 deletions(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

