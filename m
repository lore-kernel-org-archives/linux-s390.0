Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838BAEE49A0
	for <linux-s390@archiver.kernel.org>; Fri, 25 Aug 2023 21:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjHYVQn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 25 Aug 2023 17:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjHYVQl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 25 Aug 2023 17:16:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A48211E
        for <linux-s390@vger.kernel.org>; Fri, 25 Aug 2023 14:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692998155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RNGvpBuIiKL3Cl4QX+janawTefek15UWSwqXPvpbHmo=;
        b=RblqpsP5As6DNMM0DFb07ibechcPArr9ltecTkvAUIlZ2SoHL89vo1vrNVLOQTpCMey2+B
        3x8OZLmHnEelev/irEXRtWpX8yMUns6R1e2FIu2i35egjzs8PE8jB72U9mCwSvYLg+DOHZ
        W7St8O7vkY2lsfIoTg+aW2kYJ/5cNIQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-fmlDn4vmPFOsbQ9KkJn16Q-1; Fri, 25 Aug 2023 17:15:54 -0400
X-MC-Unique: fmlDn4vmPFOsbQ9KkJn16Q-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-411f7e77b44so13781651cf.3
        for <linux-s390@vger.kernel.org>; Fri, 25 Aug 2023 14:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692998154; x=1693602954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNGvpBuIiKL3Cl4QX+janawTefek15UWSwqXPvpbHmo=;
        b=kqB4K09Eux2PI6vqLjvYXnfl2vxVI9VfZJUOm4DHTH77KWZUksn+rkmdd1ABH7QCit
         ieHWiM7bmqapNIloiu16OUNTB1UN5GrT8VS8xtd3esfKc/YQSRfQaIBt6okwUlcVrSrY
         s3PqBAaFHwFD9wq8kC+KO+Tu7L20ZuCfrHfVnjlG4zULL+CIgQvMiVbbid7jTJ/pGcrr
         JRgJQku+NVMJvY1G1md8gA1nRXN9bMzpR+Ro3Z7gAHWhuSY9VFMf5bbQK0e14Z5LSTf7
         zbYjoHNKbBslxSPfZTHp7eerETqP6yZDOA1gC5O79UQJLValnP9zGQ26NTtOZYqVhSE0
         3+/Q==
X-Gm-Message-State: AOJu0YyGE2ORLMqBrF2JEpai0q2nWzantfLYmtwifnqOq9APs83i09al
        VmpAZhOLobA/KTsdDvaBYRMGTzcFg/M22OPI10Fvy67nhwJ69SRk9rIA1/FB42kSn844j9Lvcfj
        cAC8UdCVLjR46S/CNP1dryw==
X-Received: by 2002:a05:622a:138c:b0:411:fc77:5863 with SMTP id o12-20020a05622a138c00b00411fc775863mr9742826qtk.34.1692998153917;
        Fri, 25 Aug 2023 14:15:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGkTdJ1PESb45xmKP1IyMr0VhacrVsFun4AHO5ghG+vkiiDrIbNOg/oEp2bfPugUDBb4fzHQ==
X-Received: by 2002:a05:622a:138c:b0:411:fc77:5863 with SMTP id o12-20020a05622a138c00b00411fc775863mr9742803qtk.34.1692998153629;
        Fri, 25 Aug 2023 14:15:53 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id i3-20020ae9ee03000000b0076745f352adsm759948qkg.59.2023.08.25.14.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 14:15:53 -0700 (PDT)
Date:   Fri, 25 Aug 2023 14:15:51 -0700
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
Subject: Re: [PATCH v7 04/24] iommu: Add IOMMU_DOMAIN_PLATFORM for S390
Message-ID: <qlgsyftnpb55wn6jcsdx27u3vnc66h5dmtcuelw4y5wgk3vorf@ctgykaa5wp7d>
References: <0-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
 <4-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Aug 23, 2023 at 01:47:18PM -0300, Jason Gunthorpe wrote:
> The PLATFORM domain will be set as the default domain and attached as
> normal during probe. The driver will ignore the initial attach from a NULL
> domain to the PLATFORM domain.
> 
> After this, the PLATFORM domain's attach_dev will be called whenever we
> detach from an UNMANAGED domain (eg for VFIO). This is the same time the
> original design would have called op->detach_dev().
> 
> This is temporary until the S390 dma-iommu.c conversion is merged.
> 
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

