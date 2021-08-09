Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104A8C432BE
	for <linux-s390@archiver.kernel.org>; Mon,  9 Aug 2021 07:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC5B61055
	for <linux-s390@archiver.kernel.org>; Mon,  9 Aug 2021 07:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbhHIHuk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 9 Aug 2021 03:50:40 -0400
Received: from mail-vs1-f46.google.com ([209.85.217.46]:44652 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbhHIHuh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Aug 2021 03:50:37 -0400
Received: by mail-vs1-f46.google.com with SMTP id n22so9468509vsq.11;
        Mon, 09 Aug 2021 00:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSkDBecKhj6XgHI95Z5g89aQzQ9wTkJ5QUH4uHs+PHw=;
        b=j4AvqmT6q3euZhzNQNeV2rU1IuxgTu5x9UR1SjtvCwLuERUM64qGCdGqOVsFf+SLpz
         op4C85+pT187ByCAcKsajqCUIr+2I0Tj8Y+7AoiO+3cUwEBUGCegkAFPf+vOtxPzuALr
         JKRdhC1bShnN+FGbsekHoaUSbhkcA9IM+X5DV7FaePoHyqEvIS/TsgklchZMWnV8D30C
         wvYHAhetPhhbCSmfhp0bn0Rhtizf6wOV6c/qqi1+7+yhG/p62sVc6QzDd+2WpftVgZ9R
         vtdSo9P/y8byqNNW87Tin2PfOAHn87xhNiR58/K738IX9WuE/nK+QRQuetbyIfeU6yIN
         o4Xg==
X-Gm-Message-State: AOAM530zwSc5sA9wuUBtlNcSlXsk0dOoB+vZX2C76syLs0wRH4EwjXPj
        ptAYMurSJfQt5NwpAwUSwEdJYH3O3lcMc6LG6sMIovZCZXHnrw==
X-Google-Smtp-Source: ABdhPJwyzUqGggBh82zJedC1ezudY8M3CGBhbipUvvVxKcRpEZQp/J85EiOjTr/A4pLeQ3fz9QsU8e+W6uo4gY5xssg=
X-Received: by 2002:a05:6102:d9:: with SMTP id u25mr6193125vsp.42.1628495416464;
 Mon, 09 Aug 2021 00:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210809073738.200237-1-geert@linux-m68k.org>
In-Reply-To: <20210809073738.200237-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Aug 2021 09:50:05 +0200
Message-ID: <CAMuHMdXdHx_7t51F+wGDa1oigJnGt4FDBYHvx58FWVv_iGVxDg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.14-rc4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-um <linux-um@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Aug 9, 2021 at 9:40 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.14-rc4[1] to v5.14-rc3[3], the summaries are:
>   - build errors: +5/-0

  + /kisskb/src/drivers/dma/idxd/init.c: error: implicit declaration
of function 'cpu_feature_enabled'
[-Werror=implicit-function-declaration]:  => 805:7
  + /kisskb/src/drivers/dma/idxd/perfmon.h: error: 'struct perf_event'
has no member named 'pmu':  => 24:13, 35:13
  + /kisskb/src/drivers/dma/ioat/dca.c: error: implicit declaration of
function 'boot_cpu_has' [-Werror=implicit-function-declaration]:  =>
74:6
  + /kisskb/src/drivers/dma/ioat/dca.c: error: implicit declaration of
function 'cpuid_eax' [-Werror=implicit-function-declaration]:  =>
64:18
  + /kisskb/src/drivers/dma/ioat/dca.c: error: implicit declaration of
function 'cpuid_ebx' [-Werror=implicit-function-declaration]:  =>
17:31

um-x86_64/um-allyesconfig
(seen before on v5.14-rc2)

>   - build warnings: +3/-0

  + /kisskb/src/drivers/iio/test/iio-test-format.c: warning: the frame
size of 2128 bytes is larger than 2048 bytes [-Wframe-larger-than=]:
=> 98:1
  + /kisskb/src/drivers/thunderbolt/test.c: warning: the frame size of
3168 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  =>
2207:1
  + /kisskb/src/drivers/thunderbolt/test.c: warning: the frame size of
7192 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  =>
2367:1

s390x-gcc4.9/s390-allyesconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/c500bee1c5b2f1d59b1081ac879d73268ab0ff17/ (182 out of 189 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ff1176468d368232b684f75e82563369208bc371/ (182 out of 189 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
