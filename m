Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F330C83F12
	for <linux-s390@archiver.kernel.org>; Mon, 28 Aug 2023 19:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjH1T5f (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 28 Aug 2023 15:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbjH1T5V (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Aug 2023 15:57:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6138188
        for <linux-s390@vger.kernel.org>; Mon, 28 Aug 2023 12:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693252592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+aPLP5Dvqf88CiJMFQl9Auucq47ZaEdR+LnhUOVMwHI=;
        b=F6eWE2XfSec0Gf/5CMCgTQkpFPmrbGAwyzJg2PfLzbTfAJ9TOOutp1kw8w/aVdJLXPJv8p
        Aow5GyiUoW96lSj2GUazw5bL4FBboc/qvsrESVcd4qL8HUVO/gK8e5v9Xvl1J8i8rbvArz
        IxYUTKOTxcCfKYojjdotUqLfCtEYofM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-dajK0ZYTPeWaI3bRrYLAsA-1; Mon, 28 Aug 2023 15:56:30 -0400
X-MC-Unique: dajK0ZYTPeWaI3bRrYLAsA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-64a5264b91eso38334736d6.1
        for <linux-s390@vger.kernel.org>; Mon, 28 Aug 2023 12:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693252590; x=1693857390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aPLP5Dvqf88CiJMFQl9Auucq47ZaEdR+LnhUOVMwHI=;
        b=Fhw5AvxgN9RV532OFrBXRgOo4wm7DFvTHhHoneCnU+vWsoUyZEK7HSKD5V8Y4N7dBf
         VlVNEpgAL9a7bknnG1iCclOr667zBAApKBccmJ1xVN07qxYp3Kjtah0I52eZg/y1Vex9
         QbBaqILWaaQTSun4vw3a7uUhVazHmbzKV7+B2wu9YHICJ1g3354g2YLyZcq60W9SndZm
         WYO5n0gLmqECZdRvxl6PAVMc3KwGAK6Z7DQkNL4oLyflcdWurZLrF+XDk+9vRlSfc8kD
         IScspEIeCdHF6v/8HYPPF4H3M9Rn5oZFkex20ZnCnVukaCHfX2OmCtc3c5IE7ZyX5M5s
         j9IQ==
X-Gm-Message-State: AOJu0YxHe9i+85sX7EoYZy0zd0mZ02hRWl2jT/l2G7qyBzbgGxWcBoYQ
        oavM4uv26VbAVjFD9azhbWcJkdp7Pn1ThsYhvgXJG3tLuq+gH6HkIGi53QOy5AhFaooet/JSwJ2
        7pniuf4+ZxEdesL4ImBkPXw==
X-Received: by 2002:a05:622a:1b92:b0:403:fd62:ce75 with SMTP id bp18-20020a05622a1b9200b00403fd62ce75mr28216003qtb.5.1693252590256;
        Mon, 28 Aug 2023 12:56:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsYP9ZZ2CsJhUv0f/7ePOTXR8lCjq1Is30niybYFTHi0Enn8YltRs8yVE4tVH5Ow+UhbE98A==
X-Received: by 2002:a05:622a:1b92:b0:403:fd62:ce75 with SMTP id bp18-20020a05622a1b9200b00403fd62ce75mr28215977qtb.5.1693252589954;
        Mon, 28 Aug 2023 12:56:29 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id d4-20020ac86144000000b0040ff25d8712sm2559692qtm.18.2023.08.28.12.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 12:56:29 -0700 (PDT)
Date:   Mon, 28 Aug 2023 12:56:28 -0700
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
Subject: Re: [PATCH v7 08/24] iommu: Reorganize
 iommu_get_default_domain_type() to respect def_domain_type()
Message-ID: <3pxd6d44iejlvlijiyd65ze3wfsvvjtgrvstwhgp423uwutrz6@dak5ytcxcspv>
References: <0-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
 <8-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Aug 23, 2023 at 01:47:22PM -0300, Jason Gunthorpe wrote:
> Except for dart (which forces IOMMU_DOMAIN_DMA) every driver returns 0 or
> IDENTITY from ops->def_domain_type().
> 
> The drivers that return IDENTITY have some kind of good reason, typically
> that quirky hardware really can't support anything other than IDENTITY.
> 
> Arrange things so that if the driver says it needs IDENTITY then
> iommu_get_default_domain_type() either fails or returns IDENTITY.  It will
> not ignore the driver's override to IDENTITY.
> 
> Split the function into two steps, reducing the group device list to the
> driver's def_domain_type() and the untrusted flag.
> 
> Then compute the result based on those two reduced variables. Fully reject
> combining untrusted with IDENTITY.
> 
> Remove the debugging print on the iommu_group_store_type() failure path,
> userspace should not be able to trigger kernel prints.
> 
> This makes the next patch cleaner that wants to force IDENTITY always for
> ARM_IOMMU because there is no support for DMA.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 117 ++++++++++++++++++++++++++++--------------
>  1 file changed, 79 insertions(+), 38 deletions(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

