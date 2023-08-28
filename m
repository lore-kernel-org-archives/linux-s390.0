Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20E5C83F17
	for <linux-s390@archiver.kernel.org>; Mon, 28 Aug 2023 23:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjH1XTb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 28 Aug 2023 19:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjH1XTK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Aug 2023 19:19:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1310CDF
        for <linux-s390@vger.kernel.org>; Mon, 28 Aug 2023 16:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693264701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NqA+se+NtJmo6VZ6Aa5eIZ0Mw7Oak0MLDxzh66FDHNk=;
        b=d6xNKgjlS9CH+ZuDN2utM1wWpXH3ZlAI9xdkvTOfQIWcTqMw4skyDDlOOhYdAQb2p8cH3E
        HUuCIaRrcRI46Wy/wxnzsy+QF1nYctYE+NZzVopuwie0mEKBXe0xaW4PvPRsiGBaMrEWjs
        7s1JRMFM8lPK/cAnNEH/50XxrgwRQSs=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-9Nyv7WXOM8K68R3jYByLXw-1; Mon, 28 Aug 2023 19:18:19 -0400
X-MC-Unique: 9Nyv7WXOM8K68R3jYByLXw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1bf58d92bd9so38618095ad.3
        for <linux-s390@vger.kernel.org>; Mon, 28 Aug 2023 16:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693264698; x=1693869498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqA+se+NtJmo6VZ6Aa5eIZ0Mw7Oak0MLDxzh66FDHNk=;
        b=Ie7pHokmAcR840TmoGySXK72rBwplfUFz1t2O/QdypC98zwEWXH7Ex/EHgV2iceZhM
         EEFouC5VPYYlvlF9T8cXuqSEkjG8SZouUYdQra6H8CWNqOZHyilERraD5tyGGttVWX7W
         ZQoohYES+KsB0mOToUH4cEwjYX1jxHe/lo2R6W8xDdwVn1kELZtRuKE58Ehh2T9MBGu8
         oeH/Xw/B2OKYGGfwfwyxe4QpISXgPYwIA5+aIXqEFG678BZ1UEGaWXQGxetByz79BiUL
         LavGMfHtemFF40R8MKPZIzWTV6zcH+P9zRzB6sl+/dKiSUrWwaU8leOWHLONhpEG5QOn
         cLew==
X-Gm-Message-State: AOJu0Yz7u5xXuiyK96/gpj0Zf7LSi1LVo9oPFVEgDKqWwbzlLyp30lqS
        dzGRa0fko2jLedQVy5XW0CW6iJ0ZoHIoxd1QlmHMHKm1i6W0vCZsJDjSCawvTYzrG1RtGAH1E+B
        KoNtLVip2J5r2341ivuajHg==
X-Received: by 2002:a17:902:ea08:b0:1c0:a30e:2388 with SMTP id s8-20020a170902ea0800b001c0a30e2388mr17734005plg.31.1693264698537;
        Mon, 28 Aug 2023 16:18:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4PLIDBi9wZuEsVkyH1S0PFnZ5haeuWus0luN/Yrn+a4DV04N4xayoEkUTdP5JJP349iuJ+Q==
X-Received: by 2002:a17:902:ea08:b0:1c0:a30e:2388 with SMTP id s8-20020a170902ea0800b001c0a30e2388mr17733983plg.31.1693264698231;
        Mon, 28 Aug 2023 16:18:18 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902ce8b00b001b53953f306sm7947728plg.178.2023.08.28.16.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 16:18:17 -0700 (PDT)
Date:   Mon, 28 Aug 2023 16:18:16 -0700
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
Subject: Re: [PATCH v7 22/24] iommu: Add ops->domain_alloc_paging()
Message-ID: <6wbamqxazr3yxu25haul2vcbyt5da5py4i2pemga77pg74knov@htfe53txxkzx>
References: <0-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
 <22-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Aug 23, 2023 at 01:47:36PM -0300, Jason Gunthorpe wrote:
> This callback requests the driver to create only a __IOMMU_DOMAIN_PAGING
> domain, so it saves a few lines in a lot of drivers needlessly checking
> the type.
> 
> More critically, this allows us to sweep out all the
> IOMMU_DOMAIN_UNMANAGED and IOMMU_DOMAIN_DMA checks from a lot of the
> drivers, simplifying what is going on in the code and ultimately removing
> the now-unused special cases in drivers where they did not support
> IOMMU_DOMAIN_DMA.
> 
> domain_alloc_paging() should return a struct iommu_domain that is
> functionally compatible with ARM_DMA_USE_IOMMU, dma-iommu.c and iommufd.
> 
> Be forwards looking and pass in a 'struct device *' argument. We can
> provide this when allocating the default_domain. No drivers will look at
> this.
> 
> Tested-by: Steven Price <steven.price@arm.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 17 ++++++++++++++---
>  include/linux/iommu.h |  3 +++
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

