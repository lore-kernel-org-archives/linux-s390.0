Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325C2C4332F
	for <linux-s390@archiver.kernel.org>; Thu, 30 Sep 2021 21:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A23A61A02
	for <linux-s390@archiver.kernel.org>; Thu, 30 Sep 2021 21:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349270AbhI3VWl (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 30 Sep 2021 17:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349279AbhI3VWj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Sep 2021 17:22:39 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3D2C06176C
        for <linux-s390@vger.kernel.org>; Thu, 30 Sep 2021 14:20:52 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 194so7220081qkj.11
        for <linux-s390@vger.kernel.org>; Thu, 30 Sep 2021 14:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h/TBKn03dF9IntMFcuDE9WlvX4rnNMcxTnYaxfj4f3M=;
        b=BlxMYaM/OWq2QOg73mmSIuZReJqS9WDVJwYpygBxYlCdpjQvMPkG8JUUJuWMEfe7VW
         Kc4xJOkMskHk8O+awxj6C0zYig/iRuEgT85zngr4j5VHau1O2THU+xT3x/AlUo4/mD7V
         wX52wLkXcsoyoK8aKbnCd70Ljj6pEqXvKGjjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h/TBKn03dF9IntMFcuDE9WlvX4rnNMcxTnYaxfj4f3M=;
        b=Qm1kxdUQi8c+WFYsFRQ3HAI2wZn3HLfnxRRT9Y7PHBOpRUjMQqEA//9Kh+OfyzWFe+
         7JZGE5mO2dVVA8mOv9lv57JW3nRR+duGlBFoDQP6B7EP4V12IH2SeTeDHFrPYm7spXSm
         7eio/ImhinXo8s8BK1q/Fx0oIX3SbXsPU97fgrHERFO/QM3inhV8c5rKbjfbQkl9hrQm
         pw6mox3S5G5AjTvSC7QDBPWC96JUVl7BIVbFx9zoWmkzGan1exW96OH3w0TfghgyXqM4
         p00vpWCbH9CACOoDrkIMC7rY/qNG2qwGrVhZNp8cdqIfH6z0ZuT8VLHbLtlhoBX30s09
         Uqlg==
X-Gm-Message-State: AOAM531jVjssi5Z3TCfoqlbyjTxA9Ms7ydCcjJhIIBqoA87wWjIQ+T6Z
        Fqd6vkxEusm62f/ETkp9rSJxJJrGns1Oa1ydvoY=
X-Google-Smtp-Source: ABdhPJxACwhogb+6HjdCl1PONfHNpYsv+24Q7ctvp6mAxEpWX8MQ4bp+qLSdelpzjkup67T5/RBZTQ==
X-Received: by 2002:a37:a953:: with SMTP id s80mr6867851qke.211.1633036851344;
        Thu, 30 Sep 2021 14:20:51 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id b14sm2365801qtk.64.2021.09.30.14.20.50
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 14:20:50 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id z5so16289149ybj.2
        for <linux-s390@vger.kernel.org>; Thu, 30 Sep 2021 14:20:50 -0700 (PDT)
X-Received: by 2002:a25:df06:: with SMTP id w6mr1562849ybg.459.1633036849801;
 Thu, 30 Sep 2021 14:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210930185031.18648-1-rppt@kernel.org>
In-Reply-To: <20210930185031.18648-1-rppt@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Sep 2021 14:20:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjS76My8aJLWJAHd-5GnMEVC1D+kV7DgtV9GjcbtqZdig@mail.gmail.com>
Message-ID: <CAHk-=wjS76My8aJLWJAHd-5GnMEVC1D+kV7DgtV9GjcbtqZdig@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] memblock: cleanup memblock_free interface
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Juergen Gross <jgross@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        devicetree <devicetree@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KVM list <kvm@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-usb@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Sep 30, 2021 at 11:50 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> The first patch is a cleanup of numa_distance allocation in arch_numa I've
> spotted during the conversion.
> The second patch is a fix for Xen memory freeing on some of the error
> paths.

Well, at least patch 2 looks like something that should go into 5.15
and be marked for stable.

Patch 1 looks like a trivial local cleanup, and could go in
immediately. Patch 4 might be in that same category.

The rest look like "next merge window" to me, since they are spread
out and neither bugfixes nor tiny localized cleanups (iow renaming
functions, global resulting search-and-replace things).

So my gut feel is that two (maybe three) of these patches should go in
asap, with three (maybe four) be left for 5.16.

IOW, not trat this as a single series.

Hmm?

             Linus
