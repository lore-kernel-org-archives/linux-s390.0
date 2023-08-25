Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1A3C6FA8F
	for <linux-s390@archiver.kernel.org>; Fri, 25 Aug 2023 01:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbjHYBw4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 24 Aug 2023 21:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239493AbjHYBwq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 24 Aug 2023 21:52:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DC8A8
        for <linux-s390@vger.kernel.org>; Thu, 24 Aug 2023 18:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692928312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DWLhpWKTuJ/+RpYHbnTOi50aZ6LnaGdh4R08Ifp1NrU=;
        b=RqRT/ORQBbwwT6Ay4VCYEG5Un3Um36dcB7OOb44eagUoW8+Ba8Pwq5eVsRnzoYY7iotCYM
        T+qsDQ5YmeGp9u4BF8TBxmedtSCOUejHPwaCphHuoOpqfS5soRw38UDLVTaWFLT9kSOrZ1
        vDogYTMr4nMQkLN5fKoi20qULf2wQ5M=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-9ypIAyWTNCCDe93MVXnI0A-1; Thu, 24 Aug 2023 21:51:51 -0400
X-MC-Unique: 9ypIAyWTNCCDe93MVXnI0A-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-41044a474f6so13635191cf.1
        for <linux-s390@vger.kernel.org>; Thu, 24 Aug 2023 18:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692928310; x=1693533110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWLhpWKTuJ/+RpYHbnTOi50aZ6LnaGdh4R08Ifp1NrU=;
        b=MOGKlumF8/rs96xx5dwDDF1o68u1J4qvyskbZhoxcPnENkiHEoaVkFEamGc2BFCgWl
         q4PNh9wEt+P2+2GtVSI9n6xndAKEnWrrccfb+uyAvhePim7zMGrOU9mWmLWFE9F+c+yZ
         wR2Mox0YapeKf+WNz88VAOyotSQ0JahaMJewXWqamn5rI5LPO/0dCMSt31K7cAi9/aAa
         o1cqQ27D5z3hhZx+c/ShxoeLRdp+DHHz65C2kukJlQ/jJY5yiGFt3mf1KjWu3GwutrMr
         cshO2XLmZo/bssps0r+MeTEgYlbogeuoAwZO/RGWYEx6Bb2xyo3tv5NwhmygQuYjwheg
         5aJw==
X-Gm-Message-State: AOJu0Yzg5W7G28CyBQYCM+MTXJB4ESwYQySps9TlJlCHhcScU5Lg7mcW
        XZ0idNXgr0m8S5fT8X2r2t6falK+IUVPbhrYAwPYV6Xy+sppPR66j97w6zQaiIdUhRGoQOl5SLt
        2slRHYMXN7hSa309Z5QkAQw==
X-Received: by 2002:ac8:59d6:0:b0:400:8613:5378 with SMTP id f22-20020ac859d6000000b0040086135378mr20752346qtf.20.1692928310638;
        Thu, 24 Aug 2023 18:51:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSb6TqK3YZra5FavtOfFBMuLIN1bj8qAZDBsTSTbyHb3Qk54OyKXOKpdirNK5+OZKcbYX2cg==
X-Received: by 2002:ac8:59d6:0:b0:400:8613:5378 with SMTP id f22-20020ac859d6000000b0040086135378mr20752335qtf.20.1692928310369;
        Thu, 24 Aug 2023 18:51:50 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id i17-20020ac860d1000000b00405447ee5e8sm224859qtm.55.2023.08.24.18.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 18:51:49 -0700 (PDT)
Date:   Thu, 24 Aug 2023 18:51:48 -0700
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
Subject: Re: [PATCH v7 02/24] iommu: Add IOMMU_DOMAIN_PLATFORM
Message-ID: <hbmfqpq2oyjjz3loccfbslpalzhlsyr2w3bpx6qasq23kyrfso@e6kry74ifgnt>
References: <0-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
 <2-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Aug 23, 2023 at 01:47:16PM -0300, Jason Gunthorpe wrote:
> This is used when the iommu driver is taking control of the dma_ops,
> currently only on S390 and power spapr. It is designed to preserve the
> original ops->detach_dev() semantic that these S390 was built around.
> 
> Provide an opaque domain type and a 'default_domain' ops value that allows
> the driver to trivially force any single domain as the default domain.
> 
> Update iommufd selftest to use this instead of set_platform_dma_ops
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommu.c            | 13 +++++++++++++
>  drivers/iommu/iommufd/selftest.c | 14 +++++---------
>  include/linux/iommu.h            |  6 ++++++
>  3 files changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 33bd1107090720..7cedb0640290c8 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -184,6 +184,8 @@ static const char *iommu_domain_type_str(unsigned int t)
>  	case IOMMU_DOMAIN_DMA:
>  	case IOMMU_DOMAIN_DMA_FQ:
>  		return "Translated";
> +	case IOMMU_DOMAIN_PLATFORM:
> +		return "Platform";
>  	default:
>  		return "Unknown";
>  	}
> @@ -1752,6 +1754,17 @@ iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
>  
>  	lockdep_assert_held(&group->mutex);
>  
> +	/*
> +	 * Allow legacy drivers to specify the domain that will be the default
> +	 * domain. This should always be either an IDENTITY or PLATFORM domain.
> +	 * Do not use in new drivers.
> +	 */

Would it be worthwhile to mention this in iommu.h for the iommu_ops default_domain?

> +	if (bus->iommu_ops->default_domain) {
> +		if (req_type)
> +			return ERR_PTR(-EINVAL);
> +		return bus->iommu_ops->default_domain;
> +	}
> +
>  	if (req_type)
>  		return __iommu_group_alloc_default_domain(bus, group, req_type);
>  
> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
> index d48a202a7c3b81..fb981ba97c4e87 100644
> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -281,14 +281,6 @@ static bool mock_domain_capable(struct device *dev, enum iommu_cap cap)
>  	return cap == IOMMU_CAP_CACHE_COHERENCY;
>  }
>  
> -static void mock_domain_set_plaform_dma_ops(struct device *dev)
> -{
> -	/*
> -	 * mock doesn't setup default domains because we can't hook into the
> -	 * normal probe path
> -	 */
> -}
> -
>  static struct iommu_device mock_iommu_device = {
>  };
>  
> @@ -298,12 +290,16 @@ static struct iommu_device *mock_probe_device(struct device *dev)
>  }
>  
>  static const struct iommu_ops mock_ops = {
> +	/*
> +	 * IOMMU_DOMAIN_BLOCKED cannot be returned from def_domain_type()
> +	 * because it is zero.
> +	 */
> +	.default_domain = &mock_blocking_domain,
>  	.owner = THIS_MODULE,
>  	.pgsize_bitmap = MOCK_IO_PAGE_SIZE,
>  	.hw_info = mock_domain_hw_info,
>  	.domain_alloc = mock_domain_alloc,
>  	.capable = mock_domain_capable,
> -	.set_platform_dma_ops = mock_domain_set_plaform_dma_ops,
>  	.device_group = generic_device_group,
>  	.probe_device = mock_probe_device,
>  	.default_domain_ops =
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index d0920b2a9f1c0e..48a18b6e07abff 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -64,6 +64,7 @@ struct iommu_domain_geometry {
>  #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
>  
>  #define __IOMMU_DOMAIN_SVA	(1U << 4)  /* Shared process address space */
> +#define __IOMMU_DOMAIN_PLATFORM	(1U << 5)
>  
>  #define IOMMU_DOMAIN_ALLOC_FLAGS ~__IOMMU_DOMAIN_DMA_FQ
>  /*
> @@ -81,6 +82,8 @@ struct iommu_domain_geometry {
>   *				  invalidation.
>   *	IOMMU_DOMAIN_SVA	- DMA addresses are shared process addresses
>   *				  represented by mm_struct's.
> + *	IOMMU_DOMAIN_PLATFORM	- Legacy domain for drivers that do their own
> + *				  dma_api stuff. Do not use in new drivers.
>   */
>  #define IOMMU_DOMAIN_BLOCKED	(0U)
>  #define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
> @@ -91,6 +94,7 @@ struct iommu_domain_geometry {
>  				 __IOMMU_DOMAIN_DMA_API |	\
>  				 __IOMMU_DOMAIN_DMA_FQ)
>  #define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SVA)
> +#define IOMMU_DOMAIN_PLATFORM	(__IOMMU_DOMAIN_PLATFORM)
>  
>  struct iommu_domain {
>  	unsigned type;
> @@ -262,6 +266,7 @@ struct iommu_iotlb_gather {
>   * @owner: Driver module providing these ops
>   * @identity_domain: An always available, always attachable identity
>   *                   translation.
> + * @default_domain: If not NULL this will always be set as the default domain.
>   */
>  struct iommu_ops {
>  	bool (*capable)(struct device *dev, enum iommu_cap);
> @@ -297,6 +302,7 @@ struct iommu_ops {
>  	unsigned long pgsize_bitmap;
>  	struct module *owner;
>  	struct iommu_domain *identity_domain;
> +	struct iommu_domain *default_domain;
>  };
>  
>  /**
> -- 
> 2.41.0
> 

