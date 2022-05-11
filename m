Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD3CC433F5
	for <linux-s390@archiver.kernel.org>; Wed, 11 May 2022 19:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiEKTvS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 11 May 2022 15:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347224AbiEKTvA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 11 May 2022 15:51:00 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7484612626
        for <linux-s390@vger.kernel.org>; Wed, 11 May 2022 12:50:58 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id l19so3935283ljb.7
        for <linux-s390@vger.kernel.org>; Wed, 11 May 2022 12:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6vJ9IfqbShMwDeZyz1OcvmyyEHqFvjHPJh6cdK+fsg8=;
        b=UOIE2CT/TYOhvf0DQUQNJDj520sVaeFt2GPpw42TGAING/IxIHozir3J+l2kzfBaOP
         aZ56YV1LVJWQ1bijrGOPa3B9nSstWPsqBb2wkqnwcszxqn++LJvNICOYSOj65xkC6zgx
         hdKsujTqiIeus3grGd7grZ5z0LCNNhej1SM1H9tCyCrjPNOuiJhsgWsvFzrH5PzJs4aK
         dD8GDfegvX0E3s56aIb199J0fhjJKjx1BMi0yK07l4/Ut6ngXRy27nsNAhUutV0A+See
         L2QDulBw0Hr8OXjInO7UQQKP8Wct/ZhNCtIKLku71YjzrKpUNNPCN+GvJOkWwfPXLofR
         KzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6vJ9IfqbShMwDeZyz1OcvmyyEHqFvjHPJh6cdK+fsg8=;
        b=m+8cluSlSvNAGYrsxbYt+XKJ/YTVd4g5ytEAtcM8R5ZZx2orUJ8HuixBCvy7v5uqhd
         WuomKW+P6PsnMIisndjUQuMrk2pJE9GBPC8vIAY8AxA8ZIoXt0PpTSbq2oisGFtPRseP
         qkai5pQHZVOZf9DKc0Qk52gEBJWgil37I96+tFh8mS7ZzY4d5R5UdwneY9RsCB4lgT0S
         m+kohO7s3JFgflS4LXCPp1u+aSiVaNNUamec+x5YEpW8MBLKNEV0yvREf0Y526ZAZd+w
         QrO1i89YM7Gr8F2M3RJrNwsWcLw0S5yU8K8f3gzpsTFIei0XeoTOdWZlRGJaBwkvIlRD
         1g0g==
X-Gm-Message-State: AOAM530kYMmjNWyfx/xSjlbnDSvJIUyPjf3UyP0hc1CGf65hJRAxt7dt
        o8/deuk+SY79k9+Py+zByrEi/gFQ3qKnCNAToqEABw==
X-Google-Smtp-Source: ABdhPJxbl6AVhFz14fTg7IRY5I0/Q58Tf2tCnV3m85uqUY7iJNM7YqYLU6WY5ikkw36a0J+gHUd0dYfSGwztBAg47GM=
X-Received: by 2002:a2e:854b:0:b0:24f:b98:e2d2 with SMTP id
 u11-20020a2e854b000000b0024f0b98e2d2mr18763646ljj.165.1652298656527; Wed, 11
 May 2022 12:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220511120532.2228616-1-hca@linux.ibm.com> <20220511120532.2228616-7-hca@linux.ibm.com>
In-Reply-To: <20220511120532.2228616-7-hca@linux.ibm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 11 May 2022 12:50:45 -0700
Message-ID: <CAKwvOdkNAY0C0qC0=_P5vq54VHYwTpAcVLps4VtzHhUxcrmq=w@mail.gmail.com>
Subject: Re: [PATCH 6/8] s390/boot: workaround llvm IAS bug
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
> For at least the mvc and clc instructions llvm's integrated assembler can
> generate incorrect code. In particular this happens with decompressor boot
> code. The reason seems to be that relocations for the second displacement
> of each instruction are at incorrect locations (-/+: gas vs llvm IAS):
>
> mvc     __LC_IO_NEW_PSW(16),.Lnewpsw
>
> results in
>
>         4:      d2 0f 01 f0 00 00       mvc     496(16,%r0),0
> -                       8: R_390_12     .head.text+0x10
> +                       6: R_390_12     .head.text+0x10
>
> and
> clc     0(3,%r4),.L_hdr
> results in
>
>       258:      d5 02 40 00 00 00       clc     0(3,%r4),0
> -                       25c: R_390_12   .head.text+0x324
> +                       25a: R_390_12   .head.text+0x324
>
> Workaround this by writing the code in a different way.
>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Please link to an LLVM bugreport for this.

> ---
>  arch/s390/boot/head.S | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
>
> diff --git a/arch/s390/boot/head.S b/arch/s390/boot/head.S
> index 2ced90172680..8402e1cd133b 100644
> --- a/arch/s390/boot/head.S
> +++ b/arch/s390/boot/head.S
> @@ -42,7 +42,8 @@ ipl_start:
>  # subroutine to wait for end I/O
>  #
>  .Lirqwait:
> -       mvc     __LC_IO_NEW_PSW(16),.Lnewpsw    # set up IO interrupt psw
> +       larl    %r13,.Lnewpsw           # set up IO interrupt psw
> +       mvc     __LC_IO_NEW_PSW(16),0(%r13)
>         lpsw    .Lwaitpsw
>  .Lioint:
>         br      %r14
> @@ -155,9 +156,11 @@ ipl_start:
>         lr      %r2,%r3
>  .Lnotrunc:
>         l       %r4,.Linitrd
> -       clc     0(3,%r4),.L_hdr         # if it is HDRx
> +       larl    %r13,.L_hdr
> +       clc     0(3,%r4),0(%r13)        # if it is HDRx
>         bz      .Lagain1                # skip dataset header
> -       clc     0(3,%r4),.L_eof         # if it is EOFx
> +       larl    %r13,.L_eof
> +       clc     0(3,%r4),0(%r13)        # if it is EOFx
>         bz      .Lagain1                # skip dateset trailer
>
>         lr      %r5,%r2
> @@ -181,9 +184,11 @@ ipl_start:
>  .Lrdcont:
>         l       %r2,.Linitrd
>
> -       clc     0(3,%r2),.L_hdr         # skip HDRx and EOFx
> +       larl    %r13,.L_hdr             # skip HDRx and EOFx
> +       clc     0(3,%r2),0(%r13)
>         bz      .Lagain2
> -       clc     0(3,%r2),.L_eof
> +       larl    %r13,.L_eof
> +       clc     0(3,%r2),0(%r13)
>         bz      .Lagain2
>
>  #
> @@ -260,20 +265,23 @@ SYM_CODE_START_LOCAL(startup_normal)
>         .fill   16,4,0x0
>  0:     lmh     %r0,%r15,0(%r13)        # clear high-order half of gprs
>         sam64                           # switch to 64 bit addressing mode
> -       basr    %r13,0                  # get base
> -.LPG0:
> -       mvc     __LC_EXT_NEW_PSW(16),.Lext_new_psw-.LPG0(%r13)
> -       mvc     __LC_PGM_NEW_PSW(16),.Lpgm_new_psw-.LPG0(%r13)
> -       mvc     __LC_IO_NEW_PSW(16),.Lio_new_psw-.LPG0(%r13)
> +       larl    %r13,.Lext_new_psw
> +       mvc     __LC_EXT_NEW_PSW(16),0(%r13)
> +       larl    %r13,.Lpgm_new_psw
> +       mvc     __LC_PGM_NEW_PSW(16),0(%r13)
> +       larl    %r13,.Lio_new_psw
> +       mvc     __LC_IO_NEW_PSW(16),0(%r13)
>         xc      0x200(256),0x200        # partially clear lowcore
>         xc      0x300(256),0x300
>         xc      0xe00(256),0xe00
>         xc      0xf00(256),0xf00
> -       lctlg   %c0,%c15,.Lctl-.LPG0(%r13)      # load control registers
> +       larl    %r13,.Lctl
> +       lctlg   %c0,%c15,0(%r13)        # load control registers
>         stcke   __LC_BOOT_CLOCK
>         mvc     __LC_LAST_UPDATE_CLOCK(8),__LC_BOOT_CLOCK+1
> -       spt     6f-.LPG0(%r13)
> -       mvc     __LC_LAST_UPDATE_TIMER(8),6f-.LPG0(%r13)
> +       larl    %r13,6f
> +       spt     0(%r13)
> +       mvc     __LC_LAST_UPDATE_TIMER(8),0(%r13)
>         larl    %r15,_stack_end-STACK_FRAME_OVERHEAD
>         brasl   %r14,sclp_early_setup_buffer
>         brasl   %r14,verify_facilities
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
