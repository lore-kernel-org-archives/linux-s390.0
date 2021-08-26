Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B83C4320E
	for <linux-s390@archiver.kernel.org>; Thu, 26 Aug 2021 22:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA4F660FE7
	for <linux-s390@archiver.kernel.org>; Thu, 26 Aug 2021 22:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243731AbhHZWVj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 26 Aug 2021 18:21:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243721AbhHZWVj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Aug 2021 18:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630016449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x25KwSHDDRRQqsVl47v2hM4HtFlmU81V8CETU4p2thE=;
        b=EHuhHm9FhspaBmg5M3C4AtuApnXI77voegEu6oXHEv4nimTUDddSc3biQrO/OqnQxtps86
        SjKr4z9k9QFTIrLgDWdXjLc9HEVXI9y9wO83Kg2C66Nmj9yQ1TJ5uVTgwlohXfhM8dhoqV
        03BUyh0DTGX2v/XSH9qZY0pePRX4EaU=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-PdOPJLhhOXu1Duz6x56akA-1; Thu, 26 Aug 2021 18:20:44 -0400
X-MC-Unique: PdOPJLhhOXu1Duz6x56akA-1
Received: by mail-oo1-f72.google.com with SMTP id a127-20020a4a4c850000b029028b35f322edso2060441oob.9
        for <linux-s390@vger.kernel.org>; Thu, 26 Aug 2021 15:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x25KwSHDDRRQqsVl47v2hM4HtFlmU81V8CETU4p2thE=;
        b=GINnl4kIGfo0qhCsSC5MLItSM7xU6dO5FQkAJwqZL2sOeS2UxtlaKORXuel3IwUcFT
         zOiEO7PaxKqhvbW7f5b2Y1Ww1u+2oPo6xPk5D67NaPW/+HDTd4vVquMkibUam6ZVsyes
         GNco6xsive6OTOA0ykVjD6rQ+gTCWc85bVOWOZcOq09d8rr/zpLFA+6nSYEUJs0s+yrj
         F20CtNkxmssM/HSYwcpRs/iPN0Z6/3rR9B02RwyBGhOnmhy0Ux9w0/QKRuqQ53K9OWAi
         mIliSWmq0pjsusNC/oE/ZpLTo/J1War23AMiE6woQJkBWU0So+2uS9Q8vO3vfLnwYkbZ
         Ejiw==
X-Gm-Message-State: AOAM5321HOQ7XoYwjrX8iAdDqcUfH75hgZjcnEj3sWbY0PCZL/tKTRX8
        8NZ3TNxU1aOi1edJHHi8fx+Ga42u3PdVDOIPr9AmzNy/FtFnGhJmFNChdnKkznCNiKR6UDPSm4X
        Zj/EbUbX+ilyQzBNjkH6XKw==
X-Received: by 2002:a05:6808:690:: with SMTP id k16mr4230635oig.152.1630016443731;
        Thu, 26 Aug 2021 15:20:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/CPQBQzGnGZAoVpvwmMUzj3NaTUTuMHtLgclxQkuDqcr22UYsvkTUXA4wlQ852jrUyT+LFA==
X-Received: by 2002:a05:6808:690:: with SMTP id k16mr4230624oig.152.1630016443525;
        Thu, 26 Aug 2021 15:20:43 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id z18sm938199oib.27.2021.08.26.15.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 15:20:43 -0700 (PDT)
Date:   Thu, 26 Aug 2021 16:20:42 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     <mjrosato@linux.ibm.com>, <farman@linux.ibm.com>,
        <cohuck@redhat.com>, <linux-s390@vger.kernel.org>,
        <kvm@vger.kernel.org>
Subject: Re: [PATCH v2] vfio-pci/zdev: Remove repeated verbose license text
Message-ID: <20210826162042.095f085e.alex.williamson@redhat.com>
In-Reply-To: <20210824003749.1039-1-caihuoqing@baidu.com>
References: <20210824003749.1039-1-caihuoqing@baidu.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 24 Aug 2021 08:37:49 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> remove it because SPDX-License-Identifier is already used
> and change "GPL-2.0+" to "GPL-2.0-only"
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
> v1->v2: change "GPL-2.0+" to "GPL-2.0-only"
> 
>  drivers/vfio/pci/vfio_pci_zdev.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Applied to vfio next branch for v5.15 with Matthew's review and agreed
commit log wording.  Thanks,

Alex

