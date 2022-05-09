Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CFAC4332F
	for <linux-s390@archiver.kernel.org>; Mon,  9 May 2022 17:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239460AbiEIRNI (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 9 May 2022 13:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbiEIRNG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 May 2022 13:13:06 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F0A1E3275
        for <linux-s390@vger.kernel.org>; Mon,  9 May 2022 10:09:11 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u23so19253186lfc.1
        for <linux-s390@vger.kernel.org>; Mon, 09 May 2022 10:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qmNh/UlR00KzKm2embL/8KXGrDJlEF5LNSh8Qse0tHI=;
        b=XlxYVyti/+Q7NqrSdb22SAIl6Y2j55Yg5g2k37ctvzV1ktFvUd3+GBrrXaqN+9NFeY
         6EJHldsP4pwcrjQ2xzBRUlRSmr1Qray+IZ0Azb6pH9oGWAA6cH1MqKDYqSoobESAB3Tt
         eRGYGGgOM/icKjcAIArV0t0cRsOS98O3uc3oCmKTiATpvxAJt2dw7pFRGKnsUp5Fy6+q
         XIPCiWfYfE/TS6cBhvExSO/fG7/pxV+Gc6ing+pOzWL/ysqhEjHBgLIYNRnpXIBuNHwt
         4ZGKV+R/g8mxG2EAM+mfZqER4WmDuwtD4WjdICN3razEbRrdkjkeh/S/AOCAatbdqrDm
         dp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qmNh/UlR00KzKm2embL/8KXGrDJlEF5LNSh8Qse0tHI=;
        b=JwK5JVqnqi3CPtjvOzF4CV0uobEnmNljfCgfQ5xEKyolNiAnqdPLLn5KjMYbETDWMF
         x6yfA1bNf7Tzq7Odz3U93lTIeuNoUpFdZvUb4/572d+XTM3ozUpcMUtSO72RUr2agV3L
         kEjxBhPFfYncYvrOHIgM7mjlLtyJdTkFZVdRNSxajq/AoZ12OKuoDaX1m6Fvd6ibMvyY
         NtIdTO7CIA6yBcww6ab8TUBqgAQO2r8QA2haqapNxsSJD5KU4KJS8nTE1CSS4AgWCY1+
         4zdKHAhHPlYgBKjzgBGMTYxYWQmSD91CxFwxN1mlLix8R+sfts9JQM/9NUgZS49tN4TK
         SZ8g==
X-Gm-Message-State: AOAM533g02Au8KmYCBIbFVJb8bAFNPSuJ8u73AXFCh1s85autL0Pdsum
        qCmnEipnV/c+uwoWwGqZjeZGDnI9Sp72RnqapvspfQ==
X-Google-Smtp-Source: ABdhPJwxw3I1e8oaAvfUjbq5Ev4Yd8NjV0buUyZoAzr7cbILcvl2TRmROPbsKEb/6HUIdbYLzAigXpP3dNIEtdsX6aE=
X-Received: by 2002:a05:6512:1d1:b0:471:f63a:b182 with SMTP id
 f17-20020a05651201d100b00471f63ab182mr13052968lfp.392.1652116149145; Mon, 09
 May 2022 10:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220508190631.2386038-1-masahiroy@kernel.org> <20220508190631.2386038-2-masahiroy@kernel.org>
In-Reply-To: <20220508190631.2386038-2-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 May 2022 10:08:57 -0700
Message-ID: <CAKwvOdnawYY05Boy6FNUtBoi11z8yyMnfDzGUw0CDMT3vKuP5w@mail.gmail.com>
Subject: Re: [PATCH v4 01/14] modpost: remove left-over cross_compile declaration
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sun, May 8, 2022 at 12:09 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> This is a remnant of commit 6543becf26ff ("mod/file2alias: make
> modalias generation safe for cross compiling").
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch! (I wonder if we should put our old mailing list
in .mailmap?)
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> Changes in v4:
>   - New patch
>
>  scripts/mod/modpost.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> index cfa127d2bb8f..d9daeff07b83 100644
> --- a/scripts/mod/modpost.h
> +++ b/scripts/mod/modpost.h
> @@ -174,7 +174,6 @@ static inline unsigned int get_secindex(const struct elf_info *info,
>  }
>
>  /* file2alias.c */
> -extern unsigned int cross_build;
>  void handle_moddevtable(struct module *mod, struct elf_info *info,
>                         Elf_Sym *sym, const char *symname);
>  void add_moddevtable(struct buffer *buf, struct module *mod);
> --

-- 
Thanks,
~Nick Desaulniers
