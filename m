Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055A0C83F11
	for <linux-s390@archiver.kernel.org>; Mon, 28 Aug 2023 21:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbjH1VMJ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 28 Aug 2023 17:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbjH1VL5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Aug 2023 17:11:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A18132
        for <linux-s390@vger.kernel.org>; Mon, 28 Aug 2023 14:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693257067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QBbEp84s+rto5I+fSYwjc/z0wqe0V4QeOMyByDhCicY=;
        b=ie88gz2CuhiSKePrUcrp9baCJ7bmKnVkC/usWeX0348swswwAzf1VvaSwgH+f509Q8juVV
        4PMYVvQs7QS7eFK+rE/uC32MnzcMNVxRFB6xV2Nta5WaSzv/mJ3x/xTwqPy7mQ+dzx6x84
        DnnukLZu0jSdIyzooQq/WdwmNUypE48=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-84h-dEAoPA2BdpILIf3hYA-1; Mon, 28 Aug 2023 17:11:05 -0400
X-MC-Unique: 84h-dEAoPA2BdpILIf3hYA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-64f5aeb8388so43722006d6.1
        for <linux-s390@vger.kernel.org>; Mon, 28 Aug 2023 14:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693257065; x=1693861865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBbEp84s+rto5I+fSYwjc/z0wqe0V4QeOMyByDhCicY=;
        b=gU4aGsWr5Rv6EJFpCOAPPzJATpiJhy2jSWk4DB5xKw5dRtq2xY/WqRwba3ybuUl6ci
         SsmVDm7lJDBwU3ld5qFeVdjG0zwPaU9ALLow50XGhCXbmxTo3mrv0gzp0otu1xCJPL1j
         l9UEceO7SwvUSod+55MP90H0Szdn/uE03k4hfYqe0GHJvvNR02lvZzELtaGlIjIQK+Fn
         lLJNrkBo3axL9DrHl9zQqWwgROp0vJDAEyJFpb2QEoEDlODr0hBs3j5gdmv6MoL5uBcr
         BmZIq6oCoS1vSpRiZl39h0TNIM33w0InwY+0e71PfH4QJm9cnmmvzXVIlHvhMPPfV2lX
         bFEQ==
X-Gm-Message-State: AOJu0YwuWk1v05S0Vf3/kmPh7DmyHLyqr6bug+8c0313FQXkgL93UMFp
        SvQCkpLyTySmcyn9IjW1v+ZHSS7mOQrbP3ygLtxHOuaKyhaXmPohbBBnFugnRcNl1Y9D8gjnG83
        +La1WcMHnTTvOCoC+5sn3Vw==
X-Received: by 2002:a0c:b415:0:b0:621:48be:baa8 with SMTP id u21-20020a0cb415000000b0062148bebaa8mr24439921qve.48.1693257065503;
        Mon, 28 Aug 2023 14:11:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP3ObHCetgbEOQmvjiokpWFivwzRctOVNKCOPRfRNFNHOYTdYfD3DjqX8LobUdneBowBMyfw==
X-Received: by 2002:a0c:b415:0:b0:621:48be:baa8 with SMTP id u21-20020a0cb415000000b0062148bebaa8mr24439881qve.48.1693257065270;
        Mon, 28 Aug 2023 14:11:05 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id z10-20020a0cf00a000000b0064c107c9679sm2854215qvk.125.2023.08.28.14.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 14:11:04 -0700 (PDT)
Date:   Mon, 28 Aug 2023 14:11:03 -0700
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
Subject: Re: [PATCH v7 19/24] iommu/sun50i: Add an IOMMU_IDENTITIY_DOMAIN
Message-ID: <ufjped2r4se2d6whnglrwwbrjma2ufmswtjzsa2pguseya7fqb@5rnxgcwzk5zz>
References: <0-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
 <19-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Aug 23, 2023 at 01:47:33PM -0300, Jason Gunthorpe wrote:
> Prior to commit 1b932ceddd19 ("iommu: Remove detach_dev callbacks") the
> sun50i_iommu_detach_device() function was being called by
> ops->detach_dev().
> 
> This is an IDENTITY domain so convert sun50i_iommu_detach_device() into
> sun50i_iommu_identity_attach() and a full IDENTITY domain and thus hook it
> back up the same was as the old ops->detach_dev().
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/sun50i-iommu.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

