Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95761C4338F
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jul 2021 14:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F9B560EBB
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jul 2021 14:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbhG2Ox1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 29 Jul 2021 10:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237799AbhG2Ox1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 29 Jul 2021 10:53:27 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EA1C061765
        for <linux-s390@vger.kernel.org>; Thu, 29 Jul 2021 07:53:23 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id t128so8829177oig.1
        for <linux-s390@vger.kernel.org>; Thu, 29 Jul 2021 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rz/FWXWJIdJs5D3kcgNlgtx454VDwz/C1hhNbH4bMzk=;
        b=Ze6QRgWWb+lHbCY6+Wyvvr0cQrSGAnwY9AXf9xUDEpUQUO1Ks0zjzXgSbTKHZg9hvO
         euLDod7XoiygnT0oSQy0EKMXpk1ON9ykY3Lrb/fUkGn17DmUp6w8OHwcTrO/8cYPLIRD
         GQkxPchndEqXYyWvf2TIX62aEKymSqs2u2LyLMOHRaeYSEN6Ho2XicNfyTG6WcciJQ3f
         zcZBq0hf7UMaBk/qk+6us732yAvw5ypvzIDZMMjg7gLPdYAkjmASk+S1tzhO819ignh1
         4iANoJp2IOmW0nie5yGsr1MrmDXZtbJklSdQ9y7hA3ZPYkOZMPRLWAjFtAKiJw3qsC62
         Ltaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rz/FWXWJIdJs5D3kcgNlgtx454VDwz/C1hhNbH4bMzk=;
        b=A92KjpgkW1t7looYJ29dd4NQ1bgVQKzhv63OzbOEsYtxv7Z7Er9jRHdOCxCzh5BnqL
         HhmSz6s8iXqI9ZQhBbRE493/15zlEyAn9HQvAzS3726FNNe7S7N885itv8uh4q+dn0RN
         8yPQ7q+WgirTKM47xFyj4ZS426tsOelnvX6GTicccAxkHO7aN79ZgoEzkxkGyKrIInDG
         DoKgHh6MN7MeubLu/ptT0dS3GuFGbqwjhNQEmWkTuO+zI4ByPcMC2L3FWw4VY0Q/ywla
         c0WKgqdnjmK9PNQ0GMPywkZv6kSkL8BBaxVMsgqSk+f/ybMKIZer1i1OUQ9twDl7kSgL
         4/wQ==
X-Gm-Message-State: AOAM531/zwjSQR7fPnxS1Zyhs4AyDV7UiyshbzR6kd8sQJHzBGyW3Iok
        2Ymd6w1Dbp63/Yc8fasxB2+vVup4TRl7t6Z5AtCdcA==
X-Google-Smtp-Source: ABdhPJx4KJ3VVPzhGKpY3n3A8ZLZOnyaUppNX9EeEqvRHtpVVtWmK+nQ9CHP4axrhg6dc+asDlMOcSvW/EBjUzylFro=
X-Received: by 2002:aca:c402:: with SMTP id u2mr3281466oif.121.1627570402255;
 Thu, 29 Jul 2021 07:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210729142811.1309391-1-hca@linux.ibm.com>
In-Reply-To: <20210729142811.1309391-1-hca@linux.ibm.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 29 Jul 2021 16:53:10 +0200
Message-ID: <CANpmjNM=rSFwmJCEq6gxHZBdYKVZas4rbnd2gk8GCAEjiJ_5UQ@mail.gmail.com>
Subject: Re: [PATCH] kcsan: use u64 instead of cycles_t
To:     Heiko Carstens <hca@linux.ibm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

+Cc: Paul

On Thu, 29 Jul 2021 at 16:28, Heiko Carstens <hca@linux.ibm.com> wrote:
>
> cycles_t has a different type across architectures: unsigned int,
> unsinged long, or unsigned long long. Depending on architecture this
> will generate this warning:
>
> kernel/kcsan/debugfs.c: In function =E2=80=98microbenchmark=E2=80=99:
> ./include/linux/kern_levels.h:5:25: warning: format =E2=80=98%llu=E2=80=
=99 expects argument of type =E2=80=98long long unsigned int=E2=80=99, but =
argument 3 has type =E2=80=98cycles_t=E2=80=99 {aka =E2=80=98long unsigned =
int=E2=80=99} [-Wformat=3D]
>
> To avoid this simple change the type of cycle to u64 in
> microbenchmark(), since u64 is of type unsigned long long for all
> architectures.
>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Acked-by: Marco Elver <elver@google.com>

Do you have a series adding KCSAN support for s390, i.e. would you
like to keep it together with those changes?

Otherwise this would go the usual route through Paul's -rcu tree.

Thanks,
-- Marco

> ---
>  kernel/kcsan/debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
> index e65de172ccf7..1d1d1b0e4248 100644
> --- a/kernel/kcsan/debugfs.c
> +++ b/kernel/kcsan/debugfs.c
> @@ -64,7 +64,7 @@ static noinline void microbenchmark(unsigned long iters=
)
>  {
>         const struct kcsan_ctx ctx_save =3D current->kcsan_ctx;
>         const bool was_enabled =3D READ_ONCE(kcsan_enabled);
> -       cycles_t cycles;
> +       u64 cycles;
>
>         /* We may have been called from an atomic region; reset context. =
*/
>         memset(&current->kcsan_ctx, 0, sizeof(current->kcsan_ctx));
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/20210729142811.1309391-1-hca%40linux.ibm.com.
