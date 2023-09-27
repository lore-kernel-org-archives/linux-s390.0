Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753C9E82CA8
	for <linux-s390@archiver.kernel.org>; Wed, 27 Sep 2023 15:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbjI0Pvn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 27 Sep 2023 11:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjI0Pvb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 27 Sep 2023 11:51:31 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CCB5BAE
        for <linux-s390@vger.kernel.org>; Wed, 27 Sep 2023 08:40:13 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-65b2463d651so23057866d6.3
        for <linux-s390@vger.kernel.org>; Wed, 27 Sep 2023 08:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695829211; x=1696434011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t9oIEXPNWkoSP0yICfThZznT48YRRSxNiQbO+UpaNXk=;
        b=REPvhS0od8YGeIuF8pH6xO7Z6Nm5hZjrPlyVdh7k+7W57+wslImmwmFDpr9Si1InPQ
         v9MKY4koSdpGP9mGG1NiWxhdKQqDUG7D5oDSypk78gCbbiG0P67vj0AzPT/AxcKejuoG
         8jdjFvm4LXJ4bZqorrR3X66+ui3ZaiaEsEa96mHzBIl5EzTTpygaN1VywN/JTi966tvF
         RFZZ4jSkT71tem9hdvKNonJ5b/2pZXxsTznO30rtUPo5hqep55nUvnsMjhyl8hI/Iy5n
         jPHsWwKXRTzW/KOFjoC9Y7qzBFFdHd1ktdahzs6YfoT5jKaqsI7/Bh5cHg5CzMLkx6Y9
         ItgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695829211; x=1696434011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9oIEXPNWkoSP0yICfThZznT48YRRSxNiQbO+UpaNXk=;
        b=jYXEbye2frCt7n/lU6zUTlJn3uBS3l1Ul3wA17HOf0ltBx3jvuA2V3Kh9MxHbGIvjG
         6tWYSnznjQ4e+8kd3qgG3KaXJ1610qv9fFLOS+D6J18yvme/HvOO5qCAHsQXamZYEJYd
         o1EGdcXiforlVTaXh49wQ4apHXhX+6TKKEBUkmgraF8nWQmY7xRXrkzbXLJcGl9ESbg9
         AYe+RHD5joE0Brf7PjVjAacfaNRdWCmUMbkFALK4rGuONFBg9ReZkEHj1LpwjLNJOZZN
         W8f+aemkBTPVpiAmtJRHLBaC1GVQxtOWXUV/bDfKwFW0dryrh+OKtmpXAuNadkghyDm5
         Znbg==
X-Gm-Message-State: AOJu0YzFjz8zqgjyQ3qExtoM66jAHcVYUtSq/WxKQuvgq6VSM8SU2qDA
        S7WvZiO6bxUmpLcDBxCft/+HIA==
X-Google-Smtp-Source: AGHT+IEBIEK8bL4oC9/JbUXAJTo9b7yotL8eHtI4zGCh9Ar0J6VaF2Vk0l+zBuzNRh2jU30sxMvEWQ==
X-Received: by 2002:a0c:de03:0:b0:64f:8d4c:1c0b with SMTP id t3-20020a0cde03000000b0064f8d4c1c0bmr2581322qvk.43.1695829210841;
        Wed, 27 Sep 2023 08:40:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id i11-20020a0cab4b000000b00655e4f57732sm3474144qvb.35.2023.09.27.08.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 08:40:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qlWe1-001Qtr-JG;
        Wed, 27 Sep 2023 12:40:09 -0300
Date:   Wed, 27 Sep 2023 12:40:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v12 0/6] iommu/dma: s390 DMA API conversion and optimized
 IOTLB flushing
Message-ID: <20230927154009.GN13795@ziepe.ca>
References: <20230825-dma_iommu-v12-0-4134455994a7@linux.ibm.com>
 <ZRLy_AaJiXxZ2AfK@8bytes.org>
 <20230926160832.GM13795@ziepe.ca>
 <cfc9e9128ed5571d2e36421e347301057662a09e.camel@linux.ibm.com>
 <ZRP8CiBui7suB5D6@8bytes.org>
 <b06a14de270a63050b0d027c24b333dba25001a4.camel@linux.ibm.com>
 <e1efbbd827e34800bd7fb0ea687645cc6c65e1ab.camel@linux.ibm.com>
 <6dab29f58ac1ccd58caaee031f98f4d0d382cbcd.camel@linux.ibm.com>
 <a672b6b122c7a5f708614346885c190a6960aaea.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a672b6b122c7a5f708614346885c190a6960aaea.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Sep 27, 2023 at 05:24:20PM +0200, Niklas Schnelle wrote:

> Ok, another update. On trying it out again this problem actually also
> occurs when applying this v12 on top of v6.6-rc3 too. Also I guess
> unlike my prior thinking it probably doesn't occur with
> iommu.forcedac=1 since that still allows IOVAs below 4 GiB and we might
> be the only ones who don't support those. From my point of view this
> sounds like a mlx5_core issue they really should call
> dma_set_mask_and_coherent() before their first call to
> dma_alloc_coherent() not after. So I guess I'll send a v13 of this
> series rebased on iommu/core and with an additional mlx5 patch and then
> let's hope we can get that merged in a way that doesn't leave us with
> broken ConnectX VFs for too long.

Yes, OK. It definitely sounds wrong that mlx5 is doing dma allocations before
setting it's dma_set_mask_and_coherent(). Please link to this thread
and we can get Leon or Saeed to ack it for Joerg.

(though wondering why s390 is the only case that ever hit this?)

Jason
