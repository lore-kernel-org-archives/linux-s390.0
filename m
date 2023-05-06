Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972A4C7EE2D
	for <linux-s390@archiver.kernel.org>; Sat,  6 May 2023 11:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjEFLuJ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 6 May 2023 07:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjEFLuH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 6 May 2023 07:50:07 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E945293CD
        for <linux-s390@vger.kernel.org>; Sat,  6 May 2023 04:50:04 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-ba1cde4ee59so1523357276.1
        for <linux-s390@vger.kernel.org>; Sat, 06 May 2023 04:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683373804; x=1685965804;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W0CQW1o+U6+NILna+LXJ6vdvZ0BkUTno5y+llmnMQyo=;
        b=dPe2CSLoV7+FcVOrSoBizhbLXI/ZLBJ7RTaokfwOtGBTZeSTeYLGxR5uo9fELcry5s
         LjhkhKLm24iZteGxoktGLRgmELDQgh5dNlcPeyGuk5sDq1G+uRRCrDjHus72ClJr/jlN
         Ygj8wwQxJkpI0NiUvyWR8zSEsmn7rI8HLRq7PX54EoRwn1p+A3gFgHEi+yB4uztdr1JV
         /96WWH4Ph/4/DsPGZSncbenn9NXikntnF6iXN69jEyqz0Zn+JG/vxusicCalOspcWmzA
         pyHRt+NJNNIdW6RHALL/qgR/rI2RWyrjE1x52v0lj5qHj31p4GSzyvfrDe74ngZyKJ/8
         RRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683373804; x=1685965804;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W0CQW1o+U6+NILna+LXJ6vdvZ0BkUTno5y+llmnMQyo=;
        b=I8Lljt8cakk1XFjVKWGImG0crVKj58o6GQWDDMlznsz3s3WcVdTuKIFuz1T7/9uiF2
         R7pjFLXIzxEHvjMIDvrNC9hsvfWybgt8aQdIKv/9T0wIF8ucayRLDFnb1LZnOySXFkb2
         wqFokKjxdvTwkUlGG6soo433fypkwiVv7wfrpHD/JTWsvMrGPdkCuMPaimfx4Kiu2op/
         oIb8Gra1//g3iR52T3Ml2PttOzDgYD4mzjzHOLQZT8I6gs7PUVeWN3ycq9zfPgjpWIiT
         0d1h2cVNxPGDuJou/25VKOzuFMPNKrVQKXPaphpQkJUcoKeLLSwMhjIubKreQo+cgbtK
         Y2FA==
X-Gm-Message-State: AC+VfDwVtx82un7DlbM4YlUQCEUzajYtmBOXPBcYS8yi+4FIwanpIM5X
        le9getnLPYDoTm7xTmBGwwlqZDAI1hV9FWfNtWQ+KyOm0cdZQUereog=
X-Google-Smtp-Source: ACHHUZ4FLSZFOD5iz4AdA7hPnjx4FpdcbO5UyUNag9PEgw0B19CDn88OXA+iOtElC4PtdoFYeYS+cG2LAV28KYiPCHE=
X-Received: by 2002:a81:6d04:0:b0:55a:abf7:636e with SMTP id
 i4-20020a816d04000000b0055aabf7636emr4510017ywc.24.1683373804150; Sat, 06 May
 2023 04:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230506111628.712316-1-bhe@redhat.com> <20230506111628.712316-3-bhe@redhat.com>
In-Reply-To: <20230506111628.712316-3-bhe@redhat.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 6 May 2023 14:49:53 +0300
Message-ID: <CAA8EJppqxN6WktBJYou+xCbb4HOy7=yre5DXkLy9F5AA5_UQzg@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/2] dmaengine: make QCOM_HIDMA depend on HAS_IOMEM
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, 6 May 2023 at 14:17, Baoquan He <bhe@redhat.com> wrote:
>
> On s390 systems (aka mainframes), it has classic channel devices for
> networking and permanent storage that are currently even more common
> than PCI devices. Hence it could have a fully functional s390 kernel
> with CONFIG_PCI=n, then the relevant iomem mapping functions
> [including ioremap(), devm_ioremap(), etc.] are not available.
>
> Here let QCOM_HIDMA depend on HAS_IOMEM so that it won't be built to
> cause below compiling error if PCI is unset.
>
> --------------------------------------------------------
> ld: drivers/dma/qcom/hidma.o: in function `hidma_probe':
> hidma.c:(.text+0x4b46): undefined reference to `devm_ioremap_resource'
> ld: hidma.c:(.text+0x4b9e): undefined reference to `devm_ioremap_resource'
> make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 1
> make: *** [Makefile:1264: vmlinux] Error 2
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dmaengine@vger.kernel.org
> ---
>  drivers/dma/qcom/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@gmail.com>

-- 
With best wishes
Dmitry
