Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D460EECAAD3
	for <linux-s390@archiver.kernel.org>; Fri,  9 Sep 2022 08:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiIIIiX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 9 Sep 2022 04:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiIIIiW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 9 Sep 2022 04:38:22 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBB1129C66
        for <linux-s390@vger.kernel.org>; Fri,  9 Sep 2022 01:38:18 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id bs13so973910ljb.8
        for <linux-s390@vger.kernel.org>; Fri, 09 Sep 2022 01:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=BQBhZcEfl6T9p1U34zgQ/JzWRYaK36lx1DLrHB7PYZQ=;
        b=j09QxsNsiS6ScV7OwpSKQmeohH2DKbk8MbRDvGLQqmFFj3+o0zQSiT8fi+lgn0VfZS
         oOZOz34KyZ8NMQRv9iQ4lVxa5lqYz2FcGB971Cz4/3uiyh5opfc43F3u30kDXOz2vbHn
         XGkJ95fRoYADZy99hd8d0cTEF3oThzAUFDqK0k4GKjP7b5zxPSU8qwi2tghumha15dJy
         wuGILdiH48QfezIT9wAx2qblM6SKGhI6eZag9/mlHTfvuFJwYOoRw+GfawubrnLmpCxL
         CgkwutO4hNTkkSNUNU/qCkXG8jqKS8cZ529W44ybltGfRLaGYMFMikbpQ9Av5rw4xWYg
         aj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=BQBhZcEfl6T9p1U34zgQ/JzWRYaK36lx1DLrHB7PYZQ=;
        b=2FqvBTaoEdTT/v7kp35GeaR9kItv0UQw2WKXml3ZYVZOYGxpz9ekuJEE6zUFE5VR+a
         2xF1jCBpYyXd+Hlcyk7mzOjGeOARUPyOPuQIHL6ufOJ7JfWmwhvKghrAInoa8PC3yR2M
         /1amDI0eu7ifIzOO8MyUx+OeeL13VCAaFuzyhgN5hfWd3dF6OQWwjfL8L3doqxXomQ+v
         ZDaaOzFteAV/A0WniR7i83xTH6Obq1+orc6BZQHNVK/j/d/wrW1kl+i+mjoC+tTzZPLE
         pPKg+1vfERUpudo0FZ9N2pas5C6l1dcW6LPWYnL6bgdVBEElIyxmDkNVuvAWBrBEtCTO
         E1/g==
X-Gm-Message-State: ACgBeo122Y0WFbl9+pDa9SiYPBVDpyS/coHXKYAoHNNKTzGv5uvWjiHY
        I87Uf3eXKppLyAos1YaHcLVaL+bOsd9NnkgMXyGtsg==
X-Google-Smtp-Source: AA6agR6RJr6eTkMa6PU0QWPPFxYYwmaaxaNYjGWefoTfZlImxv5iZJCWz/Amdxg7tYqmq+XELjddohxZwdle5nSJeDs=
X-Received: by 2002:a2e:bf07:0:b0:261:cafb:d4a8 with SMTP id
 c7-20020a2ebf07000000b00261cafbd4a8mr3459885ljr.268.1662712696564; Fri, 09
 Sep 2022 01:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220909073840.45349-1-elver@google.com> <20220909073840.45349-2-elver@google.com>
In-Reply-To: <20220909073840.45349-2-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 9 Sep 2022 10:38:04 +0200
Message-ID: <CACT4Y+Zuf+ynzSbboTAN0_VLedeVErO6qm49H4YzuR1e8EgJUQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kcsan: Instrument memcpy/memset/memmove with newer Clang
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-s390@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 9 Sept 2022 at 09:38, Marco Elver <elver@google.com> wrote:
>
> With Clang version 16+, -fsanitize=thread will turn
> memcpy/memset/memmove calls in instrumented functions into
> __tsan_memcpy/__tsan_memset/__tsan_memmove calls respectively.
>
> Add these functions to the core KCSAN runtime, so that we (a) catch data
> races with mem* functions, and (b) won't run into linker errors with
> such newer compilers.
>
> Cc: stable@vger.kernel.org # v5.10+
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v2:
> * Fix for architectures which do not provide their own
>   memcpy/memset/memmove and instead use the generic versions in
>   lib/string. In this case we'll just alias the __tsan_ variants.
> ---
>  kernel/kcsan/core.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index fe12dfe254ec..4015f2a3e7f6 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -18,6 +18,7 @@
>  #include <linux/percpu.h>
>  #include <linux/preempt.h>
>  #include <linux/sched.h>
> +#include <linux/string.h>
>  #include <linux/uaccess.h>
>
>  #include "encoding.h"
> @@ -1308,3 +1309,41 @@ noinline void __tsan_atomic_signal_fence(int memorder)
>         }
>  }
>  EXPORT_SYMBOL(__tsan_atomic_signal_fence);
> +
> +#ifdef __HAVE_ARCH_MEMSET
> +void *__tsan_memset(void *s, int c, size_t count);
> +noinline void *__tsan_memset(void *s, int c, size_t count)
> +{
> +       check_access(s, count, KCSAN_ACCESS_WRITE, _RET_IP_);

These can use large sizes, does it make sense to truncate it to
MAX_ENCODABLE_SIZE?


> +       return __memset(s, c, count);
> +}
> +#else
> +void *__tsan_memset(void *s, int c, size_t count) __alias(memset);
> +#endif
> +EXPORT_SYMBOL(__tsan_memset);
> +
> +#ifdef __HAVE_ARCH_MEMMOVE
> +void *__tsan_memmove(void *dst, const void *src, size_t len);
> +noinline void *__tsan_memmove(void *dst, const void *src, size_t len)
> +{
> +       check_access(dst, len, KCSAN_ACCESS_WRITE, _RET_IP_);
> +       check_access(src, len, 0, _RET_IP_);
> +       return __memmove(dst, src, len);
> +}
> +#else
> +void *__tsan_memmove(void *dst, const void *src, size_t len) __alias(memmove);
> +#endif
> +EXPORT_SYMBOL(__tsan_memmove);
> +
> +#ifdef __HAVE_ARCH_MEMCPY
> +void *__tsan_memcpy(void *dst, const void *src, size_t len);
> +noinline void *__tsan_memcpy(void *dst, const void *src, size_t len)
> +{
> +       check_access(dst, len, KCSAN_ACCESS_WRITE, _RET_IP_);
> +       check_access(src, len, 0, _RET_IP_);
> +       return __memcpy(dst, src, len);
> +}
> +#else
> +void *__tsan_memcpy(void *dst, const void *src, size_t len) __alias(memcpy);
> +#endif
> +EXPORT_SYMBOL(__tsan_memcpy);
> --
> 2.37.2.789.g6183377224-goog
>
