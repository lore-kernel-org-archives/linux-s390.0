Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F4AC433F5
	for <linux-s390@archiver.kernel.org>; Wed, 11 May 2022 19:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347399AbiEKT5C (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 11 May 2022 15:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347512AbiEKT4m (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 11 May 2022 15:56:42 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263E81F7E1D
        for <linux-s390@vger.kernel.org>; Wed, 11 May 2022 12:56:41 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 16so3912230lju.13
        for <linux-s390@vger.kernel.org>; Wed, 11 May 2022 12:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4nav3zqBTONgwlQKkoQjO7boVlk/kox8wJwi0Xj/n8I=;
        b=ic/D5CKG2LyVrqw4wvCxxA6OLn57RU3DCA8VBOtixUNoN24i8HfMU1HXyuPrX8rWY7
         9a4GzrCJDGSGxlEUCziaqhFiwRK0oy+kn8UTP5elQBBPa1c4/12eKVIPOQN1gKSwS6Il
         G72397sWxrnK8ZkEd3tWWg3rJfpGFj7Kg5RnjIayGMpPPfFG+LQ3HK+Nq3tdUcmBa8wp
         UNOFQfQfw3fH4X1YkYR1SHrNjFET2bC0S6eNMZYShxraJX1+EOwfBEbp66sth9vidqwt
         5ndTtZ290g8yXXU06GWXVAb2gf3brP8aaoKozX4+gQ9MPoVEVSUkFaoWNtjLPCm5L7Wt
         2ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4nav3zqBTONgwlQKkoQjO7boVlk/kox8wJwi0Xj/n8I=;
        b=53MS5DuebsaSOnTs0kPbxTcps5pWygO28V6Gdns7HLCO9Rf4mDYF7go1yolMNDLW8A
         7PWXfgr99m2/wA4D8ciOrE0dSOVjZVEZRC6TIVHv6Nckyd87/qbJGldvRBq4Hpd1TCpT
         SRORvObf7yQmL/dcdUEiIIbtI9F+NsHXYww2NkKNKX2bJrN8qWpo956Mgk9x01Zo/yXn
         TYHboebdGq/ahhJUxlo1HvjGpsQI4gs7f8Y1eKZBXXGcVV0IspBriqPEofjoPn12hagY
         NSo2aDmOtP7SUnBg/bt1KxAlTwbEezYBqbJmGC+uep99oSIFe6dndPfZ+QnkHrEDm9Ip
         zjuA==
X-Gm-Message-State: AOAM531R9Q++34wKCuyX7jvwhKh1GUzxnBys+S8CL9ki1ZsS8d56S/dg
        6PBEWc7idbgOge599y3b0yzgdDK39vwAISrfnDYVxA==
X-Google-Smtp-Source: ABdhPJyfR5tpRmHvf0W0smFj5zTGn2GPW75XC4VbTwtu6gw8q649ATaXEfp3GanjzSqmQcNTQL/2MvVi/IKK2CcD5Vg=
X-Received: by 2002:a2e:91cf:0:b0:24f:11ea:d493 with SMTP id
 u15-20020a2e91cf000000b0024f11ead493mr17680560ljg.408.1652298999315; Wed, 11
 May 2022 12:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220511120532.2228616-1-hca@linux.ibm.com> <20220511120532.2228616-9-hca@linux.ibm.com>
 <CAKwvOd=EQa9tyWUi-ZfKrK-AABDRG7=TErHK+yb+_Z_dkjrmfQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=EQa9tyWUi-ZfKrK-AABDRG7=TErHK+yb+_Z_dkjrmfQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 11 May 2022 12:56:27 -0700
Message-ID: <CAKwvOd=T5bd69-pduh8OnYdzGuBdJmF692VYP833ZG3BfGUA+A@mail.gmail.com>
Subject: Re: [PATCH 8/8] scripts/min-tool-version.sh: raise minimum clang
 version to 14.0.0 for s390
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

On Wed, May 11, 2022 at 12:27 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, May 11, 2022 at 5:05 AM Heiko Carstens <hca@linux.ibm.com> wrote:
> >
> > Before version 14.0.0 llvm's integrated assembler fails to handle some
> > displacement variants:
> >
> > arch/s390/purgatory/head.S:108:10: error: invalid operand for instruction
> >  lg %r11,kernel_type-.base_crash(%r13)
> >
> > Instead of working around this and given that this is already fixed
> > raise the minimum clang version from 13.0.0 to 14.0.0.
>
> Do you have the commit in LLVM that fixed this? Might be nice to link

Maybe it's
https://reviews.llvm.org/D113341?

Also, these are the open issues we had for the integrated assembler.
https://github.com/ClangBuiltLinux/linux/issues?q=is%3Aopen+is%3Aissue+label%3A%22%5BARCH%5D+s390%22+label%3A%22%5BTOOL%5D+integrated-as%22

Any chance you could include relevant Link tags on your commit
messages for patches that address these? It makes it easier to track
when/where things land if we ever intend to backport anything to
stable.

Or can any of those be closed out?

> to the particular commit in the commit message. Either way:
> Acked-by: Nick Desaulniers <ndesaulniers@google.com>
>
> (Thanks for the series, will pull down and test!)
>
> If you have a github account, let me know it if you'd like to be cc'ed
> when we wire this up in our CI.
>
> >
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > ---
> >  scripts/min-tool-version.sh | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> > index 53fe64856015..f1e8358ec19a 100755
> > --- a/scripts/min-tool-version.sh
> > +++ b/scripts/min-tool-version.sh
> > @@ -24,9 +24,8 @@ icc)
> >         echo 16.0.3
> >         ;;
> >  llvm)
> > -       # https://lore.kernel.org/r/YMtib5hKVyNknZt3@osiris/
> >         if [ "$SRCARCH" = s390 ]; then
> > -               echo 13.0.0
> > +               echo 14.0.0
> >         else
> >                 echo 11.0.0
> >         fi
> > --
> > 2.32.0
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
