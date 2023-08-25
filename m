Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01D3EE49B7
	for <linux-s390@archiver.kernel.org>; Fri, 25 Aug 2023 22:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjHYWQn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 25 Aug 2023 18:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjHYWQi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 25 Aug 2023 18:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785C626AF
        for <linux-s390@vger.kernel.org>; Fri, 25 Aug 2023 15:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693001752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kso0bHAJbNi7PoOyIay86CVNgj3x+jo0WkAZo3ICUzc=;
        b=I/b1eeDSrtzINZmmsMuwwvD/o4MHLL81h0N+3E+bVBBHsT/99GKvHzwVtcQhFDKGY5ZUh2
        aNuluPA5ks13R9sOsdrpDZKOKEF8WFMtBCof+T0rTADWLjazWUK6S++HE4L1abuAgURUBH
        XbcZJTwYz5PMETA+3+NSmJaQtaWAibA=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-Xd5GZyu-MjyxSCybyXBDwg-1; Fri, 25 Aug 2023 18:15:51 -0400
X-MC-Unique: Xd5GZyu-MjyxSCybyXBDwg-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5735a879147so315989eaf.3
        for <linux-s390@vger.kernel.org>; Fri, 25 Aug 2023 15:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693001750; x=1693606550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kso0bHAJbNi7PoOyIay86CVNgj3x+jo0WkAZo3ICUzc=;
        b=FzGm88+j0aCTWkc4v4t0dkceWZQ4JD+eBW0Il4GYQdRWnnXbMnBcgV0LkFDWMU4mGd
         q84fPpDCD6K82G9F6dH+RxJ/JIieJ2mZCsBv6vFkVZSfC+km0dL5GDd4Dp0yKrXv4axx
         a+L1EbyCNIz0Q+hHwI0ovYTtw4vvsyVZF3YNbwD/vj7VvP2XoMtrfursmOBPllqB/I5P
         iTLm2yqzud72U0S1O3kGZCqRXNsQSjS0KGkWSDqhbesJYBtmU5C2HrCE9syx8BDaMnw3
         aiwHl/UyoXeyOuBvGfYVgAAIVf7TYWHYukzCrqqXA/gTrtCB2VEVwDG0iCVvrPo20a43
         aX5g==
X-Gm-Message-State: AOJu0YxuPyyu1axjukTUkpAADTEf9S/FA1qRcH5VGkk70ka+wTPjoWT3
        kH/9APR9dnaJeVtootvOVLCaozV8+QBL6KDGV4KpdkYBX4o7g2jfnOwoShZp0HHYrFAwbCpHkt2
        WYNeMnZRVaUjHmsbOMtbhIQ==
X-Received: by 2002:a05:6358:7e53:b0:139:d0bc:acfa with SMTP id p19-20020a0563587e5300b00139d0bcacfamr20095496rwm.23.1693001750542;
        Fri, 25 Aug 2023 15:15:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkY4Kv1xGxroqOwtsL16yLvAJMOO7lHXk5XmHI00VwDkZfKODP2FZnPBehYOmoTkQvGLsKdQ==
X-Received: by 2002:a05:6358:7e53:b0:139:d0bc:acfa with SMTP id p19-20020a0563587e5300b00139d0bcacfamr20095448rwm.23.1693001750156;
        Fri, 25 Aug 2023 15:15:50 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id v19-20020a0cdd93000000b0064f3b0d0143sm816749qvk.142.2023.08.25.15.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 15:15:49 -0700 (PDT)
Date:   Fri, 25 Aug 2023 15:15:48 -0700
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
Subject: Re: [PATCH v7 07/24] iommu/mtk_iommu_v1: Implement an IDENTITY domain
Message-ID: <yentwv7rhnjolgvcdq23e2tizhpduwbpgaojrmaqnsuzvsrlsh@ey75l3ffixok>
References: <0-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
 <7-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Aug 23, 2023 at 01:47:21PM -0300, Jason Gunthorpe wrote:
> What mtk does during mtk_iommu_v1_set_platform_dma() is actually putting
> the iommu into identity mode. Make this available as a proper IDENTITY
> domain.
> 
> The mtk_iommu_v1_def_domain_type() from
> commit 8bbe13f52cb7 ("iommu/mediatek-v1: Add def_domain_type") explains
> this was needed to allow probe_finalize() to be called, but now the
> IDENTITY domain will do the same job so change the returned
> def_domain_type.
> 
> mkt_v1 is the only driver that returns IOMMU_DOMAIN_UNMANAGED from
> def_domain_type().  This allows the next patch to enforce an IDENTITY
> domain policy for this driver.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/mtk_iommu_v1.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

