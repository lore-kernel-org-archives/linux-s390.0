Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FCAC83F14
	for <linux-s390@archiver.kernel.org>; Mon, 28 Aug 2023 23:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbjH1XWY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 28 Aug 2023 19:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjH1XWC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Aug 2023 19:22:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8F210C
        for <linux-s390@vger.kernel.org>; Mon, 28 Aug 2023 16:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693264874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2tY2O409yN5fYvGoN8/JrlRj7FUk0pOGMULUjvQaUpg=;
        b=N06XDS0skOOLW52iAoSS/H+EVv4Vrn4a6ms/JsWELquf6rkH0vKQWWneBra3DcYqtTzIzF
        tLbAVgJfjhORQfwFCJ/PiwcvGY1MRPhgwTf/wbthwIManYd0T0Y83I1GstI0EJN8UKtqRI
        Qd5PlBNegZTY26npufjX0byDPtxdWmM=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-n7M7XXUGOkqoX4eDlBIFaA-1; Mon, 28 Aug 2023 19:21:11 -0400
X-MC-Unique: n7M7XXUGOkqoX4eDlBIFaA-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6bf0d513257so1931903a34.1
        for <linux-s390@vger.kernel.org>; Mon, 28 Aug 2023 16:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693264870; x=1693869670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tY2O409yN5fYvGoN8/JrlRj7FUk0pOGMULUjvQaUpg=;
        b=EStsUAYHNR9IhxCTo92fGd7s1ceX6WHWGNkQYUAZygWumD8Bf5k/yobZUNPCWZm2LZ
         SDk3WaBcTiwjJEm2jALOcABWOgS+2Qrp7udSiD0CJE3Q69UNCWm9Gf2kIhcRkFTgqVjP
         MoViA7TLYk36N1DcrZAH0EIXiG3p8ohxUEgG8wzxdjrN+NFBlAW1q2bqEk60KErvi62t
         2WYT18Rd6jGSXuWgYCjjXw4uSLJ1ncQ67X/T9HN71PmHiTOe6FfJ23XY/0lhP41MpB4s
         M4XJQjPRy1inQ2kl8AUY2yqjwEXMazgLoOMC9n57Ahm5igpO1kyYrBjpQNdpGrEmKPIT
         eROw==
X-Gm-Message-State: AOJu0YzjztJDdTnA7ypbP8lo+M9Mre2oL2xI4U/9hOad3CJwjiGF9bdl
        BTskYo/qpxwJnVJZalG9d31ACxPpe4Sl64Ky5BxsuhyFKBbFd35r021gZWEUHwN4Y+76aCL5VOY
        ub9BZ0FkiTUMCUi6MyAOg8Q==
X-Received: by 2002:a05:6830:1e69:b0:6b9:6663:4648 with SMTP id m9-20020a0568301e6900b006b966634648mr15282034otr.3.1693264870371;
        Mon, 28 Aug 2023 16:21:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP5/EEWHTR1bez5m3Juu4cnUjVIKCsfQBSYEYoBbAOKOAwmWfu7HwgfLHfFstKObHsFOXoGQ==
X-Received: by 2002:a05:6830:1e69:b0:6b9:6663:4648 with SMTP id m9-20020a0568301e6900b006b966634648mr15282011otr.3.1693264870175;
        Mon, 28 Aug 2023 16:21:10 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id e29-20020a63371d000000b00565eb4fa8d1sm7893911pga.16.2023.08.28.16.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 16:21:09 -0700 (PDT)
Date:   Mon, 28 Aug 2023 16:21:08 -0700
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
Subject: Re: [PATCH v7 23/24] iommu: Convert simple drivers with DOMAIN_DMA
 to domain_alloc_paging()
Message-ID: <hqpyajmraabu5hwhprghy43p53f4qjwdux2job7bv3ss4mijuq@2ov4rd6ppqol>
References: <0-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
 <23-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Aug 23, 2023 at 01:47:37PM -0300, Jason Gunthorpe wrote:
> These drivers are all trivially converted since the function is only
> called if the domain type is going to be
> IOMMU_DOMAIN_UNMANAGED/DMA.
> 
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Steven Price <steven.price@arm.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 6 ++----
>  drivers/iommu/exynos-iommu.c            | 7 ++-----
>  drivers/iommu/ipmmu-vmsa.c              | 7 ++-----
>  drivers/iommu/mtk_iommu.c               | 7 ++-----
>  drivers/iommu/rockchip-iommu.c          | 7 ++-----
>  drivers/iommu/sprd-iommu.c              | 7 ++-----
>  drivers/iommu/sun50i-iommu.c            | 9 +++------
>  drivers/iommu/tegra-smmu.c              | 7 ++-----
>  8 files changed, 17 insertions(+), 40 deletions(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

