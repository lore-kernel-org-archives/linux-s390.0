Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079B2C433EF
	for <linux-s390@archiver.kernel.org>; Wed, 11 May 2022 19:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346811AbiEKT17 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 11 May 2022 15:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346835AbiEKT15 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 11 May 2022 15:27:57 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F613818A
        for <linux-s390@vger.kernel.org>; Wed, 11 May 2022 12:27:53 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id g16so3898561lja.3
        for <linux-s390@vger.kernel.org>; Wed, 11 May 2022 12:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SW6iq+qYhyOT6jikrCxFTwADR0TMZdkkRDPETazGaSM=;
        b=nB3Xvk21FevH9/hA9Yk7i5EiWu5T7wG775A1abZsEReiLLe3bbhxjmdCJPypSFradb
         cFh5Gp4yTjPKn9AaewWZ/cnRXM3lpD1ZJfEq+C2UO7zBZ8d9EccVMseanvn4dga9Wu1t
         VPzaF/qFDbZQqFB1CaIWIXSzVB1K9OkNxjty5qGxMCBa0C0Y6lvequVJsxLt6qMJOrpr
         Pxuib0rhCsTJUsdyArRGSYyQOpbdWLQqEDdIqWh/RtIEfieUrbha3yEGRWYWj3W68NHV
         3R7XHUO0/HGijPUcjkbZtAATUyb7CrfyPk5orQ70v0A8YyGJ0bd/Jd7GmtiPm6uygzfp
         CIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SW6iq+qYhyOT6jikrCxFTwADR0TMZdkkRDPETazGaSM=;
        b=SiYXYPLlGf2pyF4Ddatac+9HI9ts0aFNMH6xzUC4361ERe5ZZgrkwW0zovT32WwfH/
         +Y+hTEwBDQEkg/Qejem5F3rmCHlNxo9daF8ZpxWWzBV3lWitjLLadOW90lMiunipCL5i
         bX8MWGYrnmYcLM5e6kc3YQbPZCEyhTO5p+FifDTEYJ88vuX6WO2C/gqsj1TbaFGppWyu
         A4RQwacQeMq9VEBJh7Dw00eU8QvNEqzLpzD1Vp9l2Jaz7EFbQHOMgCHFBpdum2xajZN1
         6upWFwhQGHduD+qlR4rZzrIrULdwrw0zyikuJJUWdIH0+oiid5WDfCGXyBAMiqqm5DQi
         gvTw==
X-Gm-Message-State: AOAM5316xmo/ss0qi4uJ5uCmh852fMeMKOkwKOLdpHkvP+H6J5H9BjXK
        tkmDxEOHGbwo2rtQ0pDFbjqnI9Qz597ceyjbkjK7zw==
X-Google-Smtp-Source: ABdhPJydB8FVx07Gzpsea2mcu0GzM5Al7+CTg9CTEqkX8nYWBBx0ISM+XN60+ObYsYrs9KAMSUaYIZ1zXLZ2/xAGu8o=
X-Received: by 2002:a2e:a7c8:0:b0:24f:700a:4df5 with SMTP id
 x8-20020a2ea7c8000000b0024f700a4df5mr17838500ljp.472.1652297271133; Wed, 11
 May 2022 12:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220511120532.2228616-1-hca@linux.ibm.com> <20220511120532.2228616-9-hca@linux.ibm.com>
In-Reply-To: <20220511120532.2228616-9-hca@linux.ibm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 11 May 2022 12:27:39 -0700
Message-ID: <CAKwvOd=EQa9tyWUi-ZfKrK-AABDRG7=TErHK+yb+_Z_dkjrmfQ@mail.gmail.com>
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

On Wed, May 11, 2022 at 5:05 AM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> Before version 14.0.0 llvm's integrated assembler fails to handle some
> displacement variants:
>
> arch/s390/purgatory/head.S:108:10: error: invalid operand for instruction
>  lg %r11,kernel_type-.base_crash(%r13)
>
> Instead of working around this and given that this is already fixed
> raise the minimum clang version from 13.0.0 to 14.0.0.

Do you have the commit in LLVM that fixed this? Might be nice to link
to the particular commit in the commit message. Either way:
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

(Thanks for the series, will pull down and test!)

If you have a github account, let me know it if you'd like to be cc'ed
when we wire this up in our CI.

>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  scripts/min-tool-version.sh | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> index 53fe64856015..f1e8358ec19a 100755
> --- a/scripts/min-tool-version.sh
> +++ b/scripts/min-tool-version.sh
> @@ -24,9 +24,8 @@ icc)
>         echo 16.0.3
>         ;;
>  llvm)
> -       # https://lore.kernel.org/r/YMtib5hKVyNknZt3@osiris/
>         if [ "$SRCARCH" = s390 ]; then
> -               echo 13.0.0
> +               echo 14.0.0
>         else
>                 echo 11.0.0
>         fi
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
