Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029F2C4338F
	for <linux-s390@archiver.kernel.org>; Mon, 23 Aug 2021 16:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAA29611C9
	for <linux-s390@archiver.kernel.org>; Mon, 23 Aug 2021 16:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhHWQVo (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 23 Aug 2021 12:21:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34300 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229586AbhHWQVn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Aug 2021 12:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629735660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=71l7HuQPH09rcwEW7WJrnA99Ea0t1Z3460JPOoHmvwU=;
        b=WlxqKwu8galleVdPbvukqbfif94qvIjuZ+sRDoZaYzoAMwfzveVpBbhps/6NJ6QkKTxkG5
        PuoNfgh15J+nhBTxvIx/Xs/xLMIZLE9Q8VtFgGUPcFP+dqN6XsZwTW1+E2ZXHctTWOYiWe
        bd3en75LqN5r9E185zevS2rMsZKeAPU=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-vcXCZ8KhOdCClvaequ-lFQ-1; Mon, 23 Aug 2021 12:20:59 -0400
X-MC-Unique: vcXCZ8KhOdCClvaequ-lFQ-1
Received: by mail-oo1-f72.google.com with SMTP id s20-20020a4aead40000b029028b41986b27so9568046ooh.14
        for <linux-s390@vger.kernel.org>; Mon, 23 Aug 2021 09:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=71l7HuQPH09rcwEW7WJrnA99Ea0t1Z3460JPOoHmvwU=;
        b=qU/Ipbbr8sXo9yHD3DB8tilawyYBl+bZ0RVk0AbBQGWRf4L9PpBf3gR8bRYEwuWXMg
         QOV3UDMou9xjxXNULoy+YXFcSUY/XwC4KlsKDjxqvWZ7lEyGrBKlj9wGm9iBIUFeGUAM
         AksVMV8myH8kaV18V1DrqdNaU6GcVhPSN1ib+zzRsiNdZKUo3HF07Uu8//vg6h41MUPv
         /YKYNOsmBvT/W76Z5kN4rxZsEhBfZ0uibNOCGeb1LBQLkORLB9p/Pfr+BlwjOgCNULYn
         mGkgSk81ClWHjIQ9V6Us7zkFU3Is/IRq76tE2IIojjHRzTaWm01Jdqbkz4G8hBPrFq1A
         FvLQ==
X-Gm-Message-State: AOAM532EtzCh8Av3qkGJRzKBU8FA5cazU5JZuVDzSuhF8WIYMsHwEeTJ
        JyGkRp1Fny/Q8dlYN6/pPELwdLfKBwoM2WPSAMjwEyR4QC/0Sv7NuHUi5lCsyjANUfMqfR4zaLW
        NgV2Q5Zri5OcF6V1avRSKcQ==
X-Received: by 2002:a4a:2c49:: with SMTP id o70mr26027960ooo.71.1629735658103;
        Mon, 23 Aug 2021 09:20:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytJtuQ3SpG7msNN3C4qxLKEw23HYYuXZy4UzrQ7Bc4P8QrmE1aecpbhTM4xCuxYHj1l1ui4w==
X-Received: by 2002:a4a:2c49:: with SMTP id o70mr26027942ooo.71.1629735657918;
        Mon, 23 Aug 2021 09:20:57 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id x8sm3448488oof.27.2021.08.23.09.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 09:20:57 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:20:56 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     <mjrosato@linux.ibm.com>, <farman@linux.ibm.com>,
        <cohuck@redhat.com>, <linux-s390@vger.kernel.org>,
        <kvm@vger.kernel.org>
Subject: Re: [PATCH] vfio-pci/zdev: Remove repeated verbose license text
Message-ID: <20210823102056.49daf260.alex.williamson@redhat.com>
In-Reply-To: <20210822043500.561-1-caihuoqing@baidu.com>
References: <20210822043500.561-1-caihuoqing@baidu.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sun, 22 Aug 2021 12:35:00 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> remove it because SPDX-License-Identifier is already used
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/vfio/pci/vfio_pci_zdev.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> index 7b011b62c766..dfd8d826223d 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -5,11 +5,6 @@
>   * Copyright (C) IBM Corp. 2020.  All rights reserved.
>   *	Author(s): Pierre Morel <pmorel@linux.ibm.com>
>   *                 Matthew Rosato <mjrosato@linux.ibm.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   */
>  #include <linux/io.h>
>  #include <linux/pci.h>

The SPDX license for this file is actually GPL-2.0+ but the text here
matches the more restrictive GPL-2.0.  I'm not a lawyer, but I'd expect
the more restrictive license holds, so removing this text might
actually change the license.  Should this also correct the SPDX
license?  Perhaps we need clarification from the authors.  Thanks,

Alex

