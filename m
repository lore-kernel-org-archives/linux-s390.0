Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA791C4338F
	for <linux-s390@archiver.kernel.org>; Fri, 20 Aug 2021 15:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D023E6103D
	for <linux-s390@archiver.kernel.org>; Fri, 20 Aug 2021 15:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241228AbhHTPmo (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 20 Aug 2021 11:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241245AbhHTPmm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 20 Aug 2021 11:42:42 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9555C0613CF
        for <linux-s390@vger.kernel.org>; Fri, 20 Aug 2021 08:42:03 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id y23so9547591pgi.7
        for <linux-s390@vger.kernel.org>; Fri, 20 Aug 2021 08:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q8jZHSiFFfLy2DZDlFqcLZRFcfHsQs2eaK/uITfLozM=;
        b=gxFhBBzJw6MYFPO85nq5sl6q+X4IPCdfY+KIwfcptL3vT1Ic1lmczfKpNv9t+6QewK
         r2T354UoS+XEdkGmAhxUsU2UUxrO+eR+uOmoTVMjcJVpb4kAvTvwawGynAndCvpGr8tn
         p9ocBNhfb7tGVAiP/UnDbnPOvuWYf7ivb2ybXL4eMxRPL3+CEZobUEvQQkBw7AAWv16W
         yp2ozgyOt3nxeQxMUcDZjxCcV1A46xL86HRuujYwJHUCVHPIJ6QgasgsTl6XiLm3S1qK
         lMFf4Z+zOfL2T40sJ8y1hGqYWXbL1ZdWFCaa9WTNf4MGih+CCOuoYrkgfwmNeu4iMthf
         hXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q8jZHSiFFfLy2DZDlFqcLZRFcfHsQs2eaK/uITfLozM=;
        b=eE4JjJet2UuKIuTAYtU5coOBW7Y+s7xAZEneLkk/geRA85HbB/LeFsM3NinN1Mrg8x
         /XBllvf29MkMhlU0O1IJuya7HXPOAQVv/sJrv++u+aQ8nRZvwZCRyksfZLyXF2/xIcuE
         l4Bb26SPpjwBTwAXYD2CT13Lk92RNkKL+0vM7rIJqZqMuFOcnHL2XKN00U7tsYkygl8r
         jxas9WVvK5SbRuiLORQKU1YI0vWGaM8NtGsCNMdDld109Z5euX9a7buq14/Rlw68qVi2
         BmOgCA2tBKcTiDeRCvrEq95DgbYEsLCIzjVbUS3ZJMO9WfIRxuKb8QH9qhf60ISAQTGa
         7uBg==
X-Gm-Message-State: AOAM530gWSr1H2iYxSpCrU+Ft9fOV6A9kfshGob7sZgUh8++a1rOpr8d
        /U3Y9pWUCyFocy+2EMkLO8cbVOE9P0H+LRxZRHLR3Q==
X-Google-Smtp-Source: ABdhPJziD/dmI1/E002HyAJ5OylTk+JhXSjQ5FRN2yxl8+RzYWMFBCQEuK+/1sCUgSRaUjkwUyvDHK2r4a8SFvshsMM=
X-Received: by 2002:a63:311:: with SMTP id 17mr19133524pgd.450.1629474123284;
 Fri, 20 Aug 2021 08:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210820054340.GA28560@lst.de>
In-Reply-To: <20210820054340.GA28560@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 20 Aug 2021 08:41:52 -0700
Message-ID: <CAPcyv4i5GHUXPCEu4RbD1x_=usTdK2VWqHfvHFEHijDYBg+CLw@mail.gmail.com>
Subject: Re: can we finally kill off CONFIG_FS_DAX_LIMITED
To:     Christoph Hellwig <hch@lst.de>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Joao Martins <joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

[ add Gerald and Joao ]

On Thu, Aug 19, 2021 at 10:44 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi all,
>
> looking at the recent ZONE_DEVICE related changes we still have a
> horrible maze of different code paths.  I already suggested to
> depend on ARCH_HAS_PTE_SPECIAL for ZONE_DEVICE there, which all modern
> architectures have anyway.  But the other odd special case is
> CONFIG_FS_DAX_LIMITED which is just used for the xpram driver.  Does
> this driver still see use?  If so can we make it behave like the
> other DAX drivers and require a pgmap?  I think the biggest missing
> part would be to implement ARCH_HAS_PTE_DEVMAP for s390.
>

Gerald,

Might you still be looking to help dcssblk get out of FS_DAX_LIMITED
jail [1]? I recall Martin saying that 'struct page' overhead was
prohibitive. I don't know if Joao's 'struct page' diet patches could
help alleviate that at all (would require the filesystem to only
allocate blocks in large page sizes).

[1]: https://lore.kernel.org/r/20180523205017.0f2bc83e@thinkpad
