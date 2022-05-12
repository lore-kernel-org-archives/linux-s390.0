Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FC4C433EF
	for <linux-s390@archiver.kernel.org>; Thu, 12 May 2022 18:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351936AbiELSAr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 12 May 2022 14:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357215AbiELSAr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 12 May 2022 14:00:47 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC3FCC1
        for <linux-s390@vger.kernel.org>; Thu, 12 May 2022 11:00:45 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id d19so10465024lfj.4
        for <linux-s390@vger.kernel.org>; Thu, 12 May 2022 11:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PIUIK3/vvssf4wL4R4yeMIIg3nsvqklAR/DEjJ1CAm4=;
        b=ccasTpHZqLRg0Dkgl8Ihu4LaomzXbUhwYSh1fwRbe5hvyv4gVY5MRM6btJfuT2HkgD
         Yfi29F8Xw/4nJhGRIxPC7ziiFvTkipDqhk8NfYiUg6jk+ewv+1gk0EonjuGtuVANyW8h
         vP6to6PHdIMhqQ/8akSnGCCvG0Bf1mX88xHMGhC6oqXD1/bi/NFoYXkXLRRtEHoxoYEm
         sxgVee4bXilSSl6hpnr1z3ahGsqGv/qGqmqpW3c/48bJj8sBZ+AwMgVVIMQ1h+8lBiXT
         msJz6LS8qOAWudNX7tX3gdjeEzGOZPg/LmNbdtS0fpr9orjDAUfFWBeKzwHfTEFNFx8l
         DLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PIUIK3/vvssf4wL4R4yeMIIg3nsvqklAR/DEjJ1CAm4=;
        b=usOb/ToZXu+Ml8YZnnDAl32r7NUk8HTAzFOKU9sNAs11RB0fJMYu73audzlHFl8S6t
         cQ20nmXzOD3Xe4yElEJK6dGVYfXoLOd026oEPxFzUjH79EEg0Wz1LDNa29XEVha5gSb7
         DlyoV9lj26bE8Kl3pfOwwfMwW2ar5nWb9hUJLZr1V0+yaiilrn62gm6OQhIfeMz2UIkV
         M0sIcaFc9jgBBafGR6xWDWtB4PV3kujPbdnZ/DLpu0m5gYvhBJEsQ4i18j0MVIzzmvwb
         xqV2vISYfzxEPjrsTG1/ZJ0TxAqFxlXWCmLt/afyoETy2f/bU0GXgw7ptJjI9SCh0GmD
         mu5Q==
X-Gm-Message-State: AOAM532Kqo4+FHl3SMJxTMQIhZM8oreCnxaav+ft/IfjNjWAwGCqHpZG
        mustchyLYTL8/WNJHOjjVEc5az5S50ssNhD5wirQhg==
X-Google-Smtp-Source: ABdhPJxOG/NkXFVV6nAx9ClTAlKcpWSaUzyjdt+9an0VWAbc3h3vB+4ksHhR80k/qq0QPRjiAIdB7WGAx6fvI2/ho1A=
X-Received: by 2002:ac2:5e86:0:b0:473:d044:60f5 with SMTP id
 b6-20020ac25e86000000b00473d04460f5mr667320lfq.87.1652378443079; Thu, 12 May
 2022 11:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220511120532.2228616-1-hca@linux.ibm.com> <20220511120532.2228616-4-hca@linux.ibm.com>
 <Yn1CLcsu9I0M8IEM@osiris>
In-Reply-To: <Yn1CLcsu9I0M8IEM@osiris>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 12 May 2022 11:00:31 -0700
Message-ID: <CAKwvOdmSBNsA7C2ZCGDEmuxCituSQ=HPJx=9+AsBAOYfkSZRPA@mail.gmail.com>
Subject: Re: [PATCH 3/8] s390/entry: shorten OUTSIDE macro
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jonas Paulsson <paulsson@linux.vnet.ibm.com>,
        Ulrich Weigand <ulrich.weigand@de.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, May 12, 2022 at 10:22 AM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> On Wed, May 11, 2022 at 02:05:27PM +0200, Heiko Carstens wrote:
> > Since the minimum architecture level has been raised to z10 a shorter
> > instruction sequence can be used to implement the OUTSIDE macro. This
> > also reduces the number of used registers within that macro to one.
> >
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > ---
> >  arch/s390/kernel/entry.S | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> > index a6b45eaa3450..e1664b45090f 100644
> > --- a/arch/s390/kernel/entry.S
> > +++ b/arch/s390/kernel/entry.S
> > @@ -169,11 +169,9 @@ _LPP_OFFSET      = __LC_LPP
> >        * @outside_label: jump here if @reg is outside of [@start..@end)
> >        */
> >       .macro OUTSIDE reg,start,end,outside_label
> > -     lgr     %r14,\reg
> > -     larl    %r13,\start
> > -     slgr    %r14,%r13
> > -     lghi    %r13,\end - \start
> > -     clgr    %r14,%r13
> > +     larl    %r14,\start
> > +     slgrk   %r14,\reg,%r14
> > +     clgfi   %r14,\end - \start
>
> Clever me.. slgrk was added with z196, and not z10.
> So dropping this patch.

How do the version numbers work for SystemZ? Is there a list/reference
you could link me to?  If it's too deep a rabbit hole, then nevermind,
but I would like to learn a little more about the architecture.
-- 
Thanks,
~Nick Desaulniers
