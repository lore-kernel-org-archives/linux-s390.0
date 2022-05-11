Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB85C433F5
	for <linux-s390@archiver.kernel.org>; Wed, 11 May 2022 19:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbiEKTs6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 11 May 2022 15:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243056AbiEKTss (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 11 May 2022 15:48:48 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F470207916
        for <linux-s390@vger.kernel.org>; Wed, 11 May 2022 12:48:47 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id bx33so3905977ljb.12
        for <linux-s390@vger.kernel.org>; Wed, 11 May 2022 12:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=viN6sY+f+N6S/Prtk7UnuYOXqrply8ByGnamSFChEnk=;
        b=LqEw+RL5CYtKiuGwKItpr/vP15rmt1WIf8mKYuC78DH3jcI9PUi2AVINwFyLUIVAk1
         lKDJ6Ej4LU2UtrCjIAjplO0BZgnmMNwpiaWC0vxqFyPLryYhgVyms39EYjp2s11jdzd9
         g5aAClMb7Q5z3ObDP3+0PhYuW2rd98/gkBZ/h0q3XfNCje3MUS9C4Nw50sbngNzFfVon
         2Tc6E4kzU73Nm9j8FpqUQNTJ6TkzTAAWeFfNhEiMY98XWYhAINVbCG/gjU5SpybVt03I
         PeFXmrDcG5qm4gLyyBK4J7stH+L2qr6NnjHbP82lmlYXmOypntABiIbBtd2BIxRnMAOr
         HtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=viN6sY+f+N6S/Prtk7UnuYOXqrply8ByGnamSFChEnk=;
        b=rSldjuVIA91RNYQU2CpSyoeMdaFCCMrLsGuBplVzXbuKoRdGVMtqUVQa5ZHQLZm+La
         HgNawRWP6ke+X3QY4ADYCsjMoMAC3jueC+vIO20sUCfzZeUn1lzwdDIScOT0ogE9w/t4
         EoH56oY6vsOGLRSCx7WRAqqNgMgUBHDojajQpQE68Ks9loNXFdx1KBhgFKBzqVlt5Czm
         HmOvxZiVcP2J0omkJtNdPGbZEdnDtG9Lcn9lfATLRXXgjm8eJJpIew20FbZQLmRCkxhM
         m3haBQcWasF0YMElSGwb+4GxaeALkz9wlgXyKc58O4Dlz1raf+RrJFrRkarFp7dM5ejM
         EToA==
X-Gm-Message-State: AOAM533MRbIR2XUm2KNum6JZLf19hI0O2+jU77cA4GMMfhfjHxUwA8kP
        1utMqj4oc6ibk70QHaq5X1kBCHGMBj5pfnxbgB8xSg==
X-Google-Smtp-Source: ABdhPJxYEkh+IGZ8j3Rp59ahCR4uKEBHb3CjX7DDoNNpVo1R2zxZ/WC02y+NpOYgA4HkmUhGag0f/NUNZwgjrybgMrI=
X-Received: by 2002:a05:651c:1a09:b0:250:5bd1:6daf with SMTP id
 by9-20020a05651c1a0900b002505bd16dafmr17385580ljb.468.1652298525759; Wed, 11
 May 2022 12:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220511120532.2228616-1-hca@linux.ibm.com>
In-Reply-To: <20220511120532.2228616-1-hca@linux.ibm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 11 May 2022 12:48:34 -0700
Message-ID: <CAKwvOdkXy0nhS-S+dOAsSO+mpj2dCuZ4aUTe=upPV8epfTA7Aw@mail.gmail.com>
Subject: Re: [PATCH 0/8] s390: allow to build with llvm's integrated assembler
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

On Wed, May 11, 2022 at 5:05 AM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> A couple of patches which in result make it finally possible to build the
> kernel for s390 with llvm's integrated assembler. Several configs build
> without errors or warnings, and the kernel also works as expected.
>
> Note that patch 6 ("s390/boot: workaround llvm IAS bug") reveals a
> miscompile. This looks like a bug in the instruction definitions of the mvc
> and clc instructions(?). I'd like to ask people to look into this, since
> this silently generated broken code.
>
> This patch series is based on linux-next, which contains two additional
> required s390 specific patches to make llvm's IAS work.

I did a quick test of just a defconfig via:
$ ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- make CC=clang -j72 defconfig all
and this assembled then booted in qemu for me. Thanks for the work
that went into this!

Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Sounds like Nathan is doing additional testing as well.

>
> Thanks,
> Heiko
>
> Heiko Carstens (8):
>   s390/alternatives: provide identical sized orginal/alternative sequences
>   s390/alternatives: remove padding generation code
>   s390/entry: shorten OUTSIDE macro
>   s390/entry: workaround llvm's IAS limitations
>   s390/purgatory: workaround llvm's IAS limitations
>   s390/boot: workaround llvm IAS bug
>   s390/boot: do not emit debug info for assembly with llvm's IAS
>   scripts/min-tool-version.sh: raise minimum clang version to 14.0.0 for s390
>
>  arch/s390/Makefile                      |  2 +
>  arch/s390/boot/head.S                   | 34 +++++----
>  arch/s390/include/asm/alternative-asm.h | 76 +++-----------------
>  arch/s390/include/asm/alternative.h     | 93 ++++++-------------------
>  arch/s390/include/asm/spinlock.h        |  2 +-
>  arch/s390/kernel/alternative.c          | 61 +---------------
>  arch/s390/kernel/entry.S                | 39 +++++++----
>  arch/s390/lib/spinlock.c                |  4 +-
>  arch/s390/purgatory/head.S              | 29 ++++++--
>  scripts/min-tool-version.sh             |  3 +-
>  10 files changed, 104 insertions(+), 239 deletions(-)
>
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
