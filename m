Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBE1C3DA66
	for <linux-s390@archiver.kernel.org>; Fri, 25 Aug 2023 20:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjHYUZf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 25 Aug 2023 16:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjHYUZ2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 25 Aug 2023 16:25:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC242130
        for <linux-s390@vger.kernel.org>; Fri, 25 Aug 2023 13:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692995084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T9GaVO4jGruWR+C5Izp9D7v0Lmi9Kx5kTKgCOaeAvTc=;
        b=USbQCScXGh10jkYMkDH8IK1zZhsPkdUjB7Mh2pLKrvGjebskKGKPKRXVUI10k/8lLhK7UG
        T92HtPEV3kn/S3VvO+nHI9OT15y/J7jqi2vyKDuO7u01kLc3XltUXv4SHMstDF+xm7hYQ4
        iZHelGuqH9mtQTiv6t2Eq9cxWpo2EOU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-mkcj3HPAMaWB156KT-bMQg-1; Fri, 25 Aug 2023 16:24:28 -0400
X-MC-Unique: mkcj3HPAMaWB156KT-bMQg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76de9c1d13cso136374085a.2
        for <linux-s390@vger.kernel.org>; Fri, 25 Aug 2023 13:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692995068; x=1693599868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9GaVO4jGruWR+C5Izp9D7v0Lmi9Kx5kTKgCOaeAvTc=;
        b=hwgnz7oXUyoyK2RFjTGTpvJioSgzTqz29UfzUA2bPuug1e+1Mx+CU+/HV0kw7iHFGr
         hrFhmBskGPcd7eiPiXKhMNOcFFXggUjWfdUdq3h4N2dOh8peK9dGZkwkQmjQJOH2bGtt
         Oqkyb/8W0oQBHN+56sjVvti3LGdit55tpUBqwmgkUcPRA21s887AMr88HShiM9P2kXCx
         nhcqx3S9XL+DkdI0bg7kROstQ0MRlYhRPFELf5zj/1LWba1zJX10atpb9TpfTKpUw+wV
         Ll5q+Z95g9s6x/o4nFyq/zSOJUilxhJpiieYsAIZIdr6bMQxXEIHGnW4DQmQQpvAMStn
         L+qg==
X-Gm-Message-State: AOJu0Yye827dCNlVxCROFOSPyNmXeUkl/N2cpnpBAKm6HtiRywfR3ZWn
        oXItb2x3od56DUXPKLIvlVKbq1cqR0MqzwOc+/oiU3kpYM2MFWs57xOk6E4XFTFkz8hcgeIbLId
        UO6vEl49LpsttdjlVP5C+dw==
X-Received: by 2002:a05:620a:4009:b0:76e:eeaa:a079 with SMTP id h9-20020a05620a400900b0076eeeaaa079mr7880719qko.10.1692995067934;
        Fri, 25 Aug 2023 13:24:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLBKI1XGw7s6CbX7jhIzTvhmgnGyxca1Jm6YHCiJ3dxbM+m70gQmthLg44868T29Hr/JESWg==
X-Received: by 2002:a05:620a:4009:b0:76e:eeaa:a079 with SMTP id h9-20020a05620a400900b0076eeeaaa079mr7880679qko.10.1692995067632;
        Fri, 25 Aug 2023 13:24:27 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id g7-20020a37e207000000b0075cd80fde9esm741104qki.89.2023.08.25.13.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 13:24:27 -0700 (PDT)
Date:   Fri, 25 Aug 2023 13:24:25 -0700
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
Subject: Re: [PATCH v7 03/24] powerpc/iommu: Setup a default domain and
 remove set_platform_dma_ops
Message-ID: <zbmf64fbpp5zsolyqd74px3hpgvvorc3xal6pvaxdw3uoccb6c@epcqhetd6n6l>
References: <0-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
 <3-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Aug 23, 2023 at 01:47:17PM -0300, Jason Gunthorpe wrote:
> POWER is using the set_platform_dma_ops() callback to hook up its private
> dma_ops, but this is buired under some indirection and is weirdly
> happening for a BLOCKED domain as well.
> 
> For better documentation create a PLATFORM domain to manage the dma_ops,
> since that is what it is for, and make the BLOCKED domain an alias for
> it. BLOCKED is required for VFIO.
> 
> Also removes the leaky allocation of the BLOCKED domain by using a global
> static.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  arch/powerpc/kernel/iommu.c | 38 +++++++++++++++++--------------------
>  1 file changed, 17 insertions(+), 21 deletions(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

