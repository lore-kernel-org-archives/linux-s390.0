Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836D3C4332F
	for <linux-s390@archiver.kernel.org>; Wed, 11 May 2022 20:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347478AbiEKUBe (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 11 May 2022 16:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347502AbiEKUBa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 11 May 2022 16:01:30 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D2A1D48C7
        for <linux-s390@vger.kernel.org>; Wed, 11 May 2022 13:01:27 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id p10so5389506lfa.12
        for <linux-s390@vger.kernel.org>; Wed, 11 May 2022 13:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aIr7kufHqh1aklBFT48PcfwiGgRwuFks7DI5SiM+9Q0=;
        b=aDFV+CNgCaB8HAuXCMaTOeqfz3Euqlc9UfykqEg/M7trT+lMOcwb6NTqEGZJ7SsVNZ
         wKPGERgQdDUkJumgL37urxFlDsGkmX7PqdKJaBJZ9MZbdtLV8cQTIpE0yfVn6cMSgZyZ
         GDcUvdJSKIpdCHdovd/rPOddBCdGdf7Tcs7gNO1JNMXTpaAKmIBz3TFWivhPzhsqWiWP
         vJ/31TdyTBLQqry7t/YKe6QWlgU/ihp+YfVohSDDCIs1NWIXVc6t8SiZYJv7SQNHxS8u
         uvm0zjVSH3yCGxEApXJnHd78LwJfVPsGlD2n86/VBo9AQNLgEv62rjfzxd444XLv3wC4
         k+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aIr7kufHqh1aklBFT48PcfwiGgRwuFks7DI5SiM+9Q0=;
        b=SgCMMe5EklLIt+aeu9ZBIC3RYmmb1SrcG6ta9SX79FbxsuBzwmglBnTnJWHkbOBLUl
         65rMVrwhfiQ48ZhbxZI9lWtntlk33OdOXYKcdIZva3gLblVxvNzGvE+xJvvs+Bxxvdci
         Q/kAa4hhA9XtsKQ/Nf9oImlSOYQwqrCkepsD39th0D2Zhx41/XotmmpSNG1cC/qJUl/e
         Fs9PeaQf2jm1CgS1GSXkoQ9TBlWYeega51Lad0b2OwXsux++umI5LvjkUm+e6i06EQ9Q
         /hmKCn3CMpLRbQZkn9d/QXTkA0ZixfKSnwG0cmsNG6iZye+apdbiJDp/qRKK3mS0jAHK
         rK1Q==
X-Gm-Message-State: AOAM533ALJhDho75lno+7XQk4M+wibpMKxn/OeUhMK6q1tbWsUDUmc8A
        Ywa9jJHrDzxWVOb6BN4hq4IbuGYaIoWoZMIeV2YaAQ==
X-Google-Smtp-Source: ABdhPJyw+NM/b0aVOHtc066BYz2oDYf2ffAEKshIqZZZ77ExFAqpVJecq3d8qHUAeYUdPNE/gr7l7Cdi4Emgrt5UzVw=
X-Received: by 2002:a19:4303:0:b0:473:f5fb:27b2 with SMTP id
 q3-20020a194303000000b00473f5fb27b2mr20127658lfa.626.1652299285108; Wed, 11
 May 2022 13:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220508190631.2386038-1-masahiroy@kernel.org>
 <20220508190631.2386038-4-masahiroy@kernel.org> <CAKwvOd=LR=UNOeWJDmM-McJ=FrCWTo8w1ox+KGMQCwCVpiUyFg@mail.gmail.com>
 <CAK7LNARGNEDzPPUsPjDXsXUUUPSFK2erQRuyPocR_v5hTYRihg@mail.gmail.com>
 <CAKwvOdmK4oH0t8Q6F19sWKX1fT=AgS=kfvn05FT01HffLJwgMQ@mail.gmail.com>
 <CAK7LNAR5preB59HJH1-F_ZfEmoF3N8b9z4eRhYzsEVwu_XUH4Q@mail.gmail.com> <8babc23b-5e24-f662-6c4a-eb1c30e0e6da@quicinc.com>
In-Reply-To: <8babc23b-5e24-f662-6c4a-eb1c30e0e6da@quicinc.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 11 May 2022 13:01:13 -0700
Message-ID: <CAKwvOdk1z6jnTA79W8qyy1sWuoa29YxppU1gAkHkQ=g6UiVvCw@mail.gmail.com>
Subject: Re: [PATCH v4 03/14] modpost: split the section mismatch checks into section-check.c
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, May 11, 2022 at 12:51 PM Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>
> On 5/11/2022 12:27 PM, Masahiro Yamada wrote:
> > On Thu, May 12, 2022 at 3:48 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> >>
> >> On Mon, May 9, 2022 at 11:57 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >>>
> >>>>> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> >>>>> index a78b75f0eeb0..e7e2c70a98f5 100644
> >>>>> --- a/scripts/mod/modpost.c
> >>>>> +++ b/scripts/mod/modpost.c
> >>>>> @@ -31,7 +31,7 @@ static bool external_module;
> >>>>>   /* Only warn about unresolved symbols */
> >>>>>   static bool warn_unresolved;
> >>>>>
> >>>>> -static int sec_mismatch_count;
> >>>>> +int sec_mismatch_count;
> >>>>
> >>>> ^ this should go in modpost.h if it is to be used in two translation
> >>>> units, rather than forward declaring it in section-check.c.  You did
> >>>> this for the functions.
> >>>
> >>>
> >>> Sorry, I do not understand.
> >>>
> >>>
> >>> In modpost.h, I put the declaration:
> >>>
> >>>    extern int sec_mismatch_count;
> >>>
> >>> If I moved it to the header without 'extern'
> >>> I would get multiple definitions.
> >>
> >> Yeah, you need to _declare_ it w/ extern in the header, then _define_
> >> it in one source file.
> >>
> >> That way, if the type ever changes, the sources will agree on type in
> >> all source files. You will get a redefinition error if the definition
> >> changes the type of the variable since the last declaration.
> >>
> >> What you're doing is forward declaring, which works, and is a common
> >> pattern for (bloated) C++, but is less type safe than sharing a single
> >> common declaration between multiple source files via a single common
> >> shared header. (Sorry I didn't respond before you sent v5)
> >
> > Sorry, I still do not understand your suggestion.
> >
> >
> > Could you provide me with a code diff
> > showing how to do this better?
>
> I think you are doing exactly what he's asking for:
> declare it with extern in the header (modpost.h change)
> define it in one source file (modpost.c change)
>

Oh! Indeed, sorry, I'm getting lost here in the review. Sorry for the
noise then.
-- 
Thanks,
~Nick Desaulniers
