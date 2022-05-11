Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804FBC433F5
	for <linux-s390@archiver.kernel.org>; Wed, 11 May 2022 19:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347045AbiEKTkY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 11 May 2022 15:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347065AbiEKTkX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 11 May 2022 15:40:23 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE72219F69
        for <linux-s390@vger.kernel.org>; Wed, 11 May 2022 12:40:21 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id o22so3013326ljp.8
        for <linux-s390@vger.kernel.org>; Wed, 11 May 2022 12:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s0WHnwC/LKH7P9lNbxHLOT0Ey/YFu5D9xNYFJTYtZ1Q=;
        b=Fvz5uPtJHUorCw5qkY372eQ60ClhKlpeLwO1xjhAL9PQHj9vflc26CO74tkzg7EmAI
         FEHbyF3V9YbZQYUmxvm1RNGhLDcIjYqTBqP4pZiVRnOpH7gUtNFeTmFleqdhViv3AS3i
         q3If8KCbEwTyPf7Uo6YzYZ1DgplKvn07+Q5FTK3v4nApvYHZxE1K0C9zkXE0CAEZsylG
         /vV6IuLMlkcjNQ0IVy3QsNh5mor400xpsLkIzUSChrp4HwfNkleiWjE/UsdexJvxUSKo
         7XcpLaapmKfq6RqUk63VDmyq5ZCSDITSYlTLQDsqe8Nq/YlTdnTooSQfbfWhq1VOhG6a
         uP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s0WHnwC/LKH7P9lNbxHLOT0Ey/YFu5D9xNYFJTYtZ1Q=;
        b=nhh3eGXCQsMJwkn5g3xs64N5vg1/3trynxWyEkW00wX+cbzEM/SxxQ/Ur9K/mjH5NZ
         eKmkgWOyifyaqzRzGD0D4V2rUEaYXt8b5sw5PIKqqd706YB9QYqB8AzNhYLMsQyGy63v
         eYM+mzQdRcDoGe/k5VhOzrjijp9qd4cyAzWAv4pTbOdv0v/5RrBZBrgLOE/YsNM+d7IT
         3upahJhCCsn8A84za3lz+4NAERETFrcbNNSl1KSgy52x/iV+xstyY5JpcBkBP5T9HD1W
         ny+fzZ59MNWMpAiFfS57FWBNUIaQC/YDtL2P/WSINz2fh32Xe/F0jBJnby70eKMlUxa2
         +FHg==
X-Gm-Message-State: AOAM533T8oFX3rH+OHUZUlvdqam4XHaLGUrIomGkt7nK6SYeYquvCoZ/
        wB5jSXZA6a7LMxBynZlo9X7AX2lmfpy4mxiNx3LHLw==
X-Google-Smtp-Source: ABdhPJz0NVpIZePVvZ3oOx6+FO7jLpzyA7B8CJCC9CbYcQngiEhIKV2dTdoUVdm176erPVni03DBhy5q0Zs/JvZO3y4=
X-Received: by 2002:a05:651c:101:b0:250:896d:f870 with SMTP id
 a1-20020a05651c010100b00250896df870mr17878467ljb.235.1652298019389; Wed, 11
 May 2022 12:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220511120532.2228616-1-hca@linux.ibm.com> <20220511120532.2228616-8-hca@linux.ibm.com>
In-Reply-To: <20220511120532.2228616-8-hca@linux.ibm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 11 May 2022 12:40:07 -0700
Message-ID: <CAKwvOdn3Mdn9ek-7EotHmd6Wb7C5rzZnOxAQVtbQEd2LBBZGRg@mail.gmail.com>
Subject: Re: [PATCH 7/8] s390/boot: do not emit debug info for assembly with
 llvm's IAS
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
> Commit ee6d777d3e93 ("s390/decompressor: support extra debug flags")
> added extra debug flags, in particular debug info is created,
> depending on config options.
>
> With llvm's IAS this causes this compile warning:
>
> arch/s390/boot/head.S:38:1: warning: DWARF2 only supports one section per compilation unit
> .section ".head.text","ax"
> ^
>
> This is a known problem and was addressed with a commit b8a9092330da
> ("Kbuild: do not emit debug info for assembly with LLVM_IAS=1").
> Just do the same for s390 to get rid of this warning.
>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/s390/Makefile b/arch/s390/Makefile
> index c59efc83f020..d73611b35164 100644
> --- a/arch/s390/Makefile
> +++ b/arch/s390/Makefile
> @@ -20,7 +20,9 @@ LDFLAGS_vmlinux       := -pie
>  endif
>  aflags_dwarf   := -Wa,-gdwarf-2

^ or can we use a more modern variant of dwarf, like at least dwarf-4?

>  KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
> +ifndef CONFIG_AS_IS_LLVM
>  KBUILD_AFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),$(aflags_dwarf))
> +endif
>  KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2 -mpacked-stack
>  KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
>  KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float -mbackchain
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
