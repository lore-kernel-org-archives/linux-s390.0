Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B36C433F5
	for <linux-s390@archiver.kernel.org>; Fri, 19 Nov 2021 01:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB9E261A8C
	for <linux-s390@archiver.kernel.org>; Fri, 19 Nov 2021 01:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbhKSBOD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 18 Nov 2021 20:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhKSBOD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 18 Nov 2021 20:14:03 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26405C061574
        for <linux-s390@vger.kernel.org>; Thu, 18 Nov 2021 17:11:02 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id t26so34976291lfk.9
        for <linux-s390@vger.kernel.org>; Thu, 18 Nov 2021 17:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x50jM6pG1zOVTOkOckDcnqbrEYWJvq1YZ9GgThuybmM=;
        b=LnFuJ6GGDFKUBGHDotmBDPpidrdMYO7qSi+dbFiGNHOZ1yH1kiSUv+OIy6u/UTv3rv
         zyPxiEljS5zJlO38S5PNAVs16qHUHeDoXMrVuMVjjmgDx5YqOFVekYafSZ4YR3zf6Yga
         Xr5T8h21knWiZ0bsZnJ3HPb2SR66tnPPRYvcvLNpPPiXcyIYCe9W0MEIoL28YIzyMUee
         UY0gagpDJlyINCYnDEmJp/9p7tA3C0hp6PavO5ejhL4vWtJBTrxqLxdeQX9LgHN1CAjX
         l8W8XZEzJVMoQnbGwEk2IfnKFu1unQufwi/PBIl0hZo9M8hKp8Dva+GqCJOOeo1+BXYC
         qdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x50jM6pG1zOVTOkOckDcnqbrEYWJvq1YZ9GgThuybmM=;
        b=LClKwuVy/HNeWdCJ6O4/Khd6gdtk0L2vTsMzmLLOyi0Pa93u2agyw56ujjaJZt4AW+
         tMKvE2NVzWE87mS4ALwt961Np/DYayGnkit8gEKjqv88KW7Cc1kLc3ypEziC+N36PUKn
         hiPXoEy8jyvrceVKtzNONP/rHqDxmSqnkyImlO3ZhgUDVd5iFxQ/masfEfY/xLhfL1bg
         qdVNQKqlo/5ysX9Ez1YGlOVZa5hNqp7ycu0xveZxPYl5kfyiVz7Q5UfiWVqNtTRfkhg+
         9nohk4MG6RIRqKrOAW2h6dPV5HBFNyGtlJMhLgXe11ECZ6iUUyD4FLDk7dq0YiCpsMU2
         U3bA==
X-Gm-Message-State: AOAM530V1x3glwPtCFbVRZoFxngSkQhd03WbFskSBBB1dE/eP6sJEJBQ
        38vCbB6s7GduEeH+nr8e8dtqGHncMHQ78SFuxN+kNA==
X-Google-Smtp-Source: ABdhPJzF60VCgIXOgoMT0JlxAr4h5sGo54t98q/f/v4/msXsJrdVT3pwUqhpV5SbV0W4z3FADWYSFJ+6mYSAM6KxLJk=
X-Received: by 2002:a05:6512:3b9c:: with SMTP id g28mr28619869lfv.651.1637284260284;
 Thu, 18 Nov 2021 17:11:00 -0800 (PST)
MIME-Version: 1.0
References: <20211117174822.3632412-1-ilie.halip@gmail.com>
In-Reply-To: <20211117174822.3632412-1-ilie.halip@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 Nov 2021 17:10:48 -0800
Message-ID: <CAKwvOd=9tsHHhPBOx2ORZoJP09VsX5dRZn58qj3MzCc2vmVosg@mail.gmail.com>
Subject: Re: [PATCH] s390/test_unwind: use raw opcode instead of invalid instruction
To:     Ilie Halip <ilie.halip@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Mete Durlu <meted@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, llvm@lists.linux.dev,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Nov 17, 2021 at 9:48 AM Ilie Halip <ilie.halip@gmail.com> wrote:
>
> Building with clang & LLVM_IAS=1 leads to an error:
>     arch/s390/lib/test_unwind.c:179:4: error: invalid register pair
>                         "       mvcl    %%r1,%%r1\n"
>                         ^
>
> The test creates an invalid instruction that would trap at runtime, but the
> LLVM inline assembler tries to validate it at compile time too.
>
> Use the raw instruction opcode instead.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1421
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>

Ilie, thanks for the patch!

So if I understand
https://sourceware.org/binutils/docs/as/s390-Directives.html#s390-Directives
https://sourceware.org/binutils/docs/as/s390-Formats.html
that `e,` prefix is for 16B opcodes?

LGTM, thanks again.
Suggested-by: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

I triple checked that GAS, clang, and GNU objdump are in agreement in
terms of encoding here.

> ---
>  arch/s390/lib/test_unwind.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/s390/lib/test_unwind.c b/arch/s390/lib/test_unwind.c
> index cfc5f5557c06..d342bc884b94 100644
> --- a/arch/s390/lib/test_unwind.c
> +++ b/arch/s390/lib/test_unwind.c
> @@ -176,7 +176,7 @@ static noinline int unwindme_func4(struct unwindme *u)
>                  * trigger specification exception
>                  */
>                 asm volatile(
> -                       "       mvcl    %%r1,%%r1\n"
> +                       "       .insn e,0x0e11\n"       /* mvcl %%r1,%%r1" */
>                         "0:     nopr    %%r7\n"
>                         EX_TABLE(0b, 0b)
>                         :);
> --
> 2.25.1
>


-- 
Thanks,
~Nick Desaulniers
