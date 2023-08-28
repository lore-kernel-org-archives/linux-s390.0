Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C1BC83F11
	for <linux-s390@archiver.kernel.org>; Mon, 28 Aug 2023 20:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjH1Uyc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 28 Aug 2023 16:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbjH1UyK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Aug 2023 16:54:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098B0129
        for <linux-s390@vger.kernel.org>; Mon, 28 Aug 2023 13:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693256002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qzw/wSjdBQfPlF1y1vWCr8uR+Xbcc5Ojc8ATgenlbFw=;
        b=YiqLow8M4VO5h3PI3Wtcc+qEUw6HzHL00D8CaeUrey4znHtHFYpApQE0FMeUZcQoEiR89t
        1oxXwPd79A+qiTPsJvV0/lEm3CfxQWHe8ZZgBBtCauZLjbcYFpRhi7qvApYAMqhxNfehrE
        p1LU4R2uXEdJKLuPalE5xzKszxia5U0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-kBMGzTtMNc6rjCqbughAIA-1; Mon, 28 Aug 2023 16:53:21 -0400
X-MC-Unique: kBMGzTtMNc6rjCqbughAIA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4108d23b401so40722391cf.1
        for <linux-s390@vger.kernel.org>; Mon, 28 Aug 2023 13:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693255999; x=1693860799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzw/wSjdBQfPlF1y1vWCr8uR+Xbcc5Ojc8ATgenlbFw=;
        b=R0zqSEBNAGfiVxJ+ntCZ0+X2uS5KfAZW/o9A39uLb+Kz4w7GC2/wpRzUItQc1Ujh5e
         4rwSOr64k7evkznpSkpEgScvmzGPXW4sFzYisjmC9Q1//4kfKqaP27lkK7gUmkZHp6xy
         NV84n8U6A/GyYmt/VnXkNI1lEOQ3pQZ3mq5mOGlUlXFBfwWpWnh+ZHWjoCelFav8tuX+
         lyokU5PtbpLE/ssIJJbhqN7GF3feH6lB5AGucJEXf9WYl189rVsQQfx166pFQtmaEMK5
         9IN1pr3xJW1p4P0UzEjFLB5L35XfvPOGVH+xh4vsoCfBIiG1m3iSASxJqK4mapPlUEfO
         Hc6A==
X-Gm-Message-State: AOJu0Yw2gm/nhDC3ltE0ZDKPmmx0Tgg6rHWZspcA3F/QxQVU6QY6IONA
        icqCfozbR1rDR08yBe+QCZO2Pzo1gAvMteQVWhGw/tLNHFkvPbUM4b5mMPzmQS4d+bp5kVZt3pm
        7Ie6wLvC0NcnWkz00NEJspw==
X-Received: by 2002:a05:622a:13cc:b0:407:fb08:c44c with SMTP id p12-20020a05622a13cc00b00407fb08c44cmr31265796qtk.47.1693255998869;
        Mon, 28 Aug 2023 13:53:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1P7U6WABsjNUNOIrt30Nh8s3ysfvweacBVh9WudC6nYyRn08u0phTJIzmGkwySv3sSUL+sw==
X-Received: by 2002:a05:622a:13cc:b0:407:fb08:c44c with SMTP id p12-20020a05622a13cc00b00407fb08c44cmr31265764qtk.47.1693255998660;
        Mon, 28 Aug 2023 13:53:18 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id z21-20020ac84555000000b0040ff0590fd2sm2553633qtn.87.2023.08.28.13.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 13:53:18 -0700 (PDT)
Date:   Mon, 28 Aug 2023 13:53:16 -0700
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
Subject: Re: [PATCH v7 14/24] iommu/msm: Implement an IDENTITY domain
Message-ID: <37fnmzxe5cqs57gei3i6irsnnybzkbkdjf3nhertw55bb4ke6w@un2o657nczbc>
References: <0-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
 <14-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Aug 23, 2023 at 01:47:28PM -0300, Jason Gunthorpe wrote:
> What msm does during msm_iommu_set_platform_dma() is actually putting the
> iommu into identity mode.
> 
> Move to the new core support for ARM_DMA_USE_IOMMU by defining
> ops->identity_domain.
> 
> This driver does not support IOMMU_DOMAIN_DMA, however it cannot be
> compiled on ARM64 either. Most likely it is fine to support dma-iommu.c
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/msm_iommu.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

