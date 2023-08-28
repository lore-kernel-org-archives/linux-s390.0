Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335DFC83F11
	for <linux-s390@archiver.kernel.org>; Mon, 28 Aug 2023 21:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjH1VDy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 28 Aug 2023 17:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbjH1VDb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Aug 2023 17:03:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5A5139
        for <linux-s390@vger.kernel.org>; Mon, 28 Aug 2023 14:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693256564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P4Hc7lOVUb37Hr8DSGTvFTUMZzvNY/pqjNxxEvyeHyI=;
        b=M8r6rZBU9LrEhYHADcGLbqegvB5OrT+yqsmTY6nOHKHxLQ1nrGK2/uEQXIXFEHg8Q3driv
        pyAtaFjvSwVxaudrN5ZnqTOU51V4wqVUi6EHEJrsVE8xYRAF+SB0PXX16b4vtbsseUfjlH
        Jwpws3KdZAnsQdz9VaC5nCMkUUToLs8=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-bSJsIs1-Pp6oHyzbOPBT_g-1; Mon, 28 Aug 2023 17:02:42 -0400
X-MC-Unique: bSJsIs1-Pp6oHyzbOPBT_g-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-44d46b22e9eso1614807137.1
        for <linux-s390@vger.kernel.org>; Mon, 28 Aug 2023 14:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693256562; x=1693861362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4Hc7lOVUb37Hr8DSGTvFTUMZzvNY/pqjNxxEvyeHyI=;
        b=DDr5mo48s6H42TZapn4BOBJEK3GLHEq/4fYb9kRJ6E2iiOGZlcKGJaEGy5lnW1lnf6
         mLKpIqQNNRt5o2pZGXBQmQ+q9Bmd7JC9PhD2FLZvvlh3VKejpbRy91V8bEnxKrfnbPis
         y9z8zqx6GQXIVVG4fXCrc75Bf94p+RLUsbXtqkTFas6uKyxDHQ/Xw6/YAEqJ8715VCzf
         jxMNc2qert7amHId1edHPM62CPUD8iLdJea314APykLRJGK3KfyNWUdvAjY8Cdx3tFz/
         7Zdwx+EpBjjdNi0dZeRzbNHumi5pxIhABLSbMMmW7NszvMUVGbFhIyDpW06RN40XJjKa
         gMKg==
X-Gm-Message-State: AOJu0YzxUrculPwfnW8J293eGF8b0KXLtrTOJEeVkX4AZFsx0nBcK8yB
        1TiOEoVDdEqS8rlANNTvHyWnx/WPO4pycdGIbuWHz81/HAJae/QpjsjrN1Gt3fTFwEe+DGmHEFf
        BBek7huM3N8gMy3Ni0AT6mA==
X-Received: by 2002:a67:ad1a:0:b0:44d:4196:f374 with SMTP id t26-20020a67ad1a000000b0044d4196f374mr21657372vsl.14.1693256562234;
        Mon, 28 Aug 2023 14:02:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1O+ulqQs16fLrviLhIDcWj2NFGLF73P8fTFl1IfopkK1Ei1hjIoNJD//dyDhnkd8Fjfj6aA==
X-Received: by 2002:a67:ad1a:0:b0:44d:4196:f374 with SMTP id t26-20020a67ad1a000000b0044d4196f374mr21657332vsl.14.1693256561816;
        Mon, 28 Aug 2023 14:02:41 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id j10-20020a0cf50a000000b0064f732aa45csm2873129qvm.133.2023.08.28.14.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 14:02:41 -0700 (PDT)
Date:   Mon, 28 Aug 2023 14:02:40 -0700
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
Subject: Re: [PATCH v7 17/24] iommu/ipmmu: Add an IOMMU_IDENTITIY_DOMAIN
Message-ID: <ftxla3xdnxqknqg4k6qxwh6nquhdpzfmzyuvkzg7gwjxf42p6w@7ek73gnk5mue>
References: <0-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
 <17-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Aug 23, 2023 at 01:47:31PM -0300, Jason Gunthorpe wrote:
> This brings back the ops->detach_dev() code that commit
> 1b932ceddd19 ("iommu: Remove detach_dev callbacks") deleted and turns it
> into an IDENTITY domain.
> 
> Also reverts commit 584d334b1393 ("iommu/ipmmu-vmsa: Remove
> ipmmu_utlb_disable()")
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 43 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

