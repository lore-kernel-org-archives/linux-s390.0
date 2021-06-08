Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B44C4743D
	for <linux-s390@archiver.kernel.org>; Tue,  8 Jun 2021 14:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADDBE6124B
	for <linux-s390@archiver.kernel.org>; Tue,  8 Jun 2021 14:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhFHOzr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 8 Jun 2021 10:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbhFHOzq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Jun 2021 10:55:46 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA078C061787;
        Tue,  8 Jun 2021 07:53:53 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id f11so11019880vst.0;
        Tue, 08 Jun 2021 07:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2AJ2s6Swi7DKePDYPTjpM9W7XfKGuXx2NmxnXLQgYSU=;
        b=rU2pKJ75Y3/QHhh8al8WEHFkA1xcRM5SZMWEuWTFwhfJJj/V+31x/44DQ1/ocvOPg+
         HHLB+cX2JzVE7e8VyhwDv4Qz2FVNR+zh+m0OixPYjyc4fzjuukhztIpMy0r4QCqs9ENM
         rx2wn2LyftAjOv4hRMViR3COc1TqDPy9Jwcq9YGNqCboxfBQc5R+uHuQkEmoWcUMg/uD
         GgTRTBH9LOsD2SMP7YGpIDk7kjlQlU6IpzX1idxEjiKF6VTF7R6q/SsI4HkaBei2kO/c
         foGKHLzxbvnAfZr24OLQ0mXOUtMYfCqu0p3aPHXa31jtaApPg9eDz4MFF332lbCsxpOF
         vhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2AJ2s6Swi7DKePDYPTjpM9W7XfKGuXx2NmxnXLQgYSU=;
        b=D4riTu+GYWyLpk4htmmpUOp//a4v0AguE0Z0xrLAcTS4VYON/XHr2P917+FNf7oe/6
         JstzC4vbnA9ocx6zWvuDO+iUwBNqMnQjhR1AGfYIU5Z14HNW2zWoAgLkvl9KJbmTKWV9
         66Bluy+vYTZd5Q5bPgtLaIV9iBA6DwmuXBSvuNCVfDbPPDxhP+fj1l0kPG3OWU7nstXM
         /jWm+2hFhu+safn732hzQR4ClEk55qByl0iPT7dfF/Ut40/PQkXng0LlXRxkyqYeFB+9
         fBTfyRbGZm0Bx4tvgdFoE5zrXaHPQfryJc6ieTF5IPp2d5zABdTzQ6COvuDOfk7s8wnZ
         /ofg==
X-Gm-Message-State: AOAM530niIKkmnn81rPS+u1KlNCItTSihfYBSoqGD1/fzjisqJQRTV0n
        95Jf382kH8y3U3dM5UvUlANZOD3Jr0NiVXHD+Bw=
X-Google-Smtp-Source: ABdhPJyRLWrfWEbRY82WKzbAaqxe+Tz0Rq9l4OoSLSgaPe9ZQ71sH6V/8n9uYyj4peJXY7ySMuwi8lVHUHfIxXWhTlU=
X-Received: by 2002:a67:ed5a:: with SMTP id m26mr149235vsp.59.1623164030307;
 Tue, 08 Jun 2021 07:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210608083418.137226-1-wangkefeng.wang@huawei.com> <20210608083418.137226-2-wangkefeng.wang@huawei.com>
In-Reply-To: <20210608083418.137226-2-wangkefeng.wang@huawei.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 8 Jun 2021 20:23:38 +0530
Message-ID: <CAFqt6zYmCQ=wxEjnOJ6fgJWYQyFajBuxWD=UT_D-WjWUS_4pcw@mail.gmail.com>
Subject: Re: [PATCH v3 resend 01/15] mm: add setup_initial_init_mm() helper
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-s390@vger.kernel.org,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jun 8, 2021 at 1:56 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> Add setup_initial_init_mm() helper to setup kernel text,
> data and brk.
>
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-csky@vger.kernel.org
> Cc: uclinux-h8-devel@lists.sourceforge.jp
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: openrisc@lists.librecores.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-sh@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Cc: x86@kernel.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  include/linux/mm.h | 3 +++
>  mm/init-mm.c       | 9 +++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c274f75efcf9..02aa057540b7 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -244,6 +244,9 @@ int __add_to_page_cache_locked(struct page *page, struct address_space *mapping,
>
>  #define lru_to_page(head) (list_entry((head)->prev, struct page, lru))
>
> +void setup_initial_init_mm(void *start_code, void *end_code,
> +                          void *end_data, void *brk);
> +

Gentle query -> is there any limitation to add inline functions in
setup_arch() functions ?

>  /*
>   * Linux kernel virtual memory manager primitives.
>   * The idea being to have a "virtual" mm in the same way
> diff --git a/mm/init-mm.c b/mm/init-mm.c
> index 153162669f80..b4a6f38fb51d 100644
> --- a/mm/init-mm.c
> +++ b/mm/init-mm.c
> @@ -40,3 +40,12 @@ struct mm_struct init_mm = {
>         .cpu_bitmap     = CPU_BITS_NONE,
>         INIT_MM_CONTEXT(init_mm)
>  };
> +
> +void setup_initial_init_mm(void *start_code, void *end_code,
> +                          void *end_data, void *brk)
> +{
> +       init_mm.start_code = (unsigned long)start_code;
> +       init_mm.end_code = (unsigned long)end_code;
> +       init_mm.end_data = (unsigned long)end_data;
> +       init_mm.brk = (unsigned long)brk;
> +}
> --
> 2.26.2
>
>
