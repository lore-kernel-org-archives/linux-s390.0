Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B53C61DA4
	for <linux-s390@archiver.kernel.org>; Mon, 30 Jan 2023 23:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjA3Xwn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 30 Jan 2023 18:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjA3Xwj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 30 Jan 2023 18:52:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F8E2CC42
        for <linux-s390@vger.kernel.org>; Mon, 30 Jan 2023 15:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675122722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PAdTklmEDyAgRNbObsy/Ygo6Kv9vgqHE1ov2RCXdrFg=;
        b=cooegUOTAGO7rvWFTc16Uakzm1X1He/Fo5jchbeFU4XcMuxZvOA3iR4BIVOQR9h7+Ojjx2
        5jr2Bqb5N3dbsSsoGH1wn3cu7w4E0NUlS/+vn2lXQ1TBr13bo7X6lwVZM/qf+eLpw74p5P
        rVD/mtgnoszOKOjcL4Fy/tUSZIpmI0A=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-204-G0HgJSpjNoW9FzXJBRv-HA-1; Mon, 30 Jan 2023 18:52:00 -0500
X-MC-Unique: G0HgJSpjNoW9FzXJBRv-HA-1
Received: by mail-io1-f71.google.com with SMTP id r11-20020a6b8f0b000000b0071853768168so3643602iod.23
        for <linux-s390@vger.kernel.org>; Mon, 30 Jan 2023 15:52:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAdTklmEDyAgRNbObsy/Ygo6Kv9vgqHE1ov2RCXdrFg=;
        b=UNWNjaY0xBJdbDrCl3AFEVjxQ6Stn6fS+xNAoQoxzpiEU9H4B4SW1ufiHPS2rw2PrC
         Cxc59yK9VB+mqMPBpxlYmuoyHRbvqpSuam7H03uLhDdXqxl6uMUKE+vgrQBmLedNcFRH
         ElCvVTWU3bU/5MmwhSOTggW477+4AoAi4jckGWdEbZdGFly6GYaMiqOIQkOMfh8lerVj
         7p+1fPHX5hXARHcFWD+vDReKw9GnjgDxnmLAy6DGoFV2c8Ik5yDAduydXIlPRHCsbxRQ
         OMJBVAW0YBklz1c9MFGH4iJZ8GTJK7tAu+vlOAHkG2OUu0i5trjhDnZ1WxoehEA+bECH
         df3Q==
X-Gm-Message-State: AO0yUKXXdLit1TbxvvBvp/ejRT+cbS40fAG2lGTlSQ56BNtuLZp7fMwP
        HpParAfMlMXsvzJJ6aVb7OgCHjDrN08lNykTPkxTdaepAbpHX3sUoFVkiNAYshbu7v2bp7bkVHW
        7HCY8F4AD6TnksOsZJ2k7EQ==
X-Received: by 2002:a05:6e02:190f:b0:310:eb55:3856 with SMTP id w15-20020a056e02190f00b00310eb553856mr6886968ilu.9.1675122720174;
        Mon, 30 Jan 2023 15:52:00 -0800 (PST)
X-Google-Smtp-Source: AK7set+Tjuh/QLV5ACoKjB78BPy3FHiMPojdoqjURp7yFxxmHnP5uajB9G0cNMY2hpBpgzJz6u+eCQ==
X-Received: by 2002:a05:6e02:190f:b0:310:eb55:3856 with SMTP id w15-20020a056e02190f00b00310eb553856mr6886951ilu.9.1675122719932;
        Mon, 30 Jan 2023 15:51:59 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id w65-20020a025d44000000b0039deb26853csm5227538jaa.10.2023.01.30.15.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:51:59 -0800 (PST)
Date:   Mon, 30 Jan 2023 16:51:58 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        dri-devel@lists.freedesktop.org,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Heiko Carstens <hca@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Steven Rostedt \(Google\)" <rostedt@goodmis.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] [v2] vfio-mdev: add back CONFIG_VFIO dependency
Message-ID: <20230130165158.6993fc28.alex.williamson@redhat.com>
In-Reply-To: <20230126211211.1762319-1-arnd@kernel.org>
References: <20230126211211.1762319-1-arnd@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 26 Jan 2023 22:08:31 +0100
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> CONFIG_VFIO_MDEV cannot be selected when VFIO itself is
> disabled, otherwise we get a link failure:
> 
> WARNING: unmet direct dependencies detected for VFIO_MDEV
>   Depends on [n]: VFIO [=n]
>   Selected by [y]:
>   - SAMPLE_VFIO_MDEV_MTTY [=y] && SAMPLES [=y]
>   - SAMPLE_VFIO_MDEV_MDPY [=y] && SAMPLES [=y]
>   - SAMPLE_VFIO_MDEV_MBOCHS [=y] && SAMPLES [=y]
> /home/arnd/cross/arm64/gcc-13.0.1-nolibc/x86_64-linux/bin/x86_64-linux-ld: samples/vfio-mdev/mdpy.o: in function `mdpy_remove':
> mdpy.c:(.text+0x1e1): undefined reference to `vfio_unregister_group_dev'
> /home/arnd/cross/arm64/gcc-13.0.1-nolibc/x86_64-linux/bin/x86_64-linux-ld: samples/vfio-mdev/mdpy.o: in function `mdpy_probe':
> mdpy.c:(.text+0x149e): undefined reference to `_vfio_alloc_device'
> 
> Fixes: 8bf8c5ee1f38 ("vfio-mdev: turn VFIO_MDEV into a selectable symbol")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: fix the s390 and drm drivers as well, in addition to the
> sample code.
> ---
>  arch/s390/Kconfig            | 4 +++-
>  drivers/gpu/drm/i915/Kconfig | 1 +
>  samples/Kconfig              | 3 +++
>  3 files changed, 7 insertions(+), 1 deletion(-)

Applied to vfio next branch for v6.3.  Thanks,

Alex

