Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45681 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgAOOn0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Jan 2020 09:43:26 -0500
Received: by mail-qk1-f196.google.com with SMTP id x1so15790775qkl.12
        for <linux-s390@vger.kernel.org>; Wed, 15 Jan 2020 06:43:25 -0800 (PST)
MIME-Version: 1.0
References: <20200115063710.15796-1-dja@axtens.net> <20200115063710.15796-2-dja@axtens.net>
In-Reply-To: <20200115063710.15796-2-dja@axtens.net>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 15 Jan 2020 15:43:12 +0100
Message-ID: <CACT4Y+bAuaeHOcTHqp-=ckOb58fRajpGYk4khNzpS7_OyBDQYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kasan: stop tests being eliminated as dead code with FORTIFY_SOURCE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Axtens <dja@axtens.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, kasan-dev <kasan-dev@googlegroups.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-xtensa@linux-xtensa.org, the arch/x86 maintainers <x86@kernel.org>, Daniel Micay <danielmicay@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>

On Wed, Jan 15, 2020 at 7:37 AM Daniel Axtens <dja@axtens.net> wrote:
>
> 3 KASAN self-tests fail on a kernel with both KASAN and FORTIFY_SOURCE:
> memchr, memcmp and strlen.
>
> When FORTIFY_SOURCE is on, a number of functions are replaced with
> fortified versions, which attempt to check the sizes of the operands.
> However, these functions often directly invoke __builtin_foo() once they
> have performed the fortify check. The compiler can detect that the result=
s
> of these functions are not used, and knows that they have no other side
> effects, and so can eliminate them as dead code.
>
> Why are only memchr, memcmp and strlen affected?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Of string and string-like functions, kasan_test tests:
>
>  * strchr  ->  not affected, no fortified version
>  * strrchr ->  likewise
>  * strcmp  ->  likewise
>  * strncmp ->  likewise
>
>  * strnlen ->  not affected, the fortify source implementation calls the
>                underlying strnlen implementation which is instrumented, n=
ot
>                a builtin
>
>  * strlen  ->  affected, the fortify souce implementation calls a __built=
in
>                version which the compiler can determine is dead.
>
>  * memchr  ->  likewise
>  * memcmp  ->  likewise
>
>  * memset ->   not affected, the compiler knows that memset writes to its
>                first argument and therefore is not dead.
>
> Why does this not affect the functions normally?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> In string.h, these functions are not marked as __pure, so the compiler
> cannot know that they do not have side effects. If relevant functions are
> marked as __pure in string.h, we see the following warnings and the
> functions are elided:
>
> lib/test_kasan.c: In function =E2=80=98kasan_memchr=E2=80=99:
> lib/test_kasan.c:606:2: warning: statement with no effect [-Wunused-value=
]
>   memchr(ptr, '1', size + 1);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/test_kasan.c: In function =E2=80=98kasan_memcmp=E2=80=99:
> lib/test_kasan.c:622:2: warning: statement with no effect [-Wunused-value=
]
>   memcmp(ptr, arr, size+1);
>   ^~~~~~~~~~~~~~~~~~~~~~~~
> lib/test_kasan.c: In function =E2=80=98kasan_strings=E2=80=99:
> lib/test_kasan.c:645:2: warning: statement with no effect [-Wunused-value=
]
>   strchr(ptr, '1');
>   ^~~~~~~~~~~~~~~~
> ...
>
> This annotation would make sense to add and could be added at any point, =
so
> the behaviour of test_kasan.c should change.
>
> The fix
> =3D=3D=3D=3D=3D=3D=3D
>
> Make all the functions that are pure write their results to a global,
> which makes them live. The strlen and memchr tests now pass.
>
> The memcmp test still fails to trigger, which is addressed in the next
> patch.
>
> Cc: Daniel Micay <danielmicay@gmail.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Fixes: 0c96350a2d2f ("lib/test_kasan.c: add tests for several string/memo=
ry API functions")
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  lib/test_kasan.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 328d33beae36..58a8cef0d7a2 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -23,6 +23,14 @@
>
>  #include <asm/page.h>
>
> +/*
> + * We assign some test results to these globals to make sure the tests
> + * are not eliminated as dead code.
> + */
> +
> +int int_result;
> +void *ptr_result;

These are globals, but are not static and don't have kasan_ prefix.
But I guess this does not matter for modules?
Otherwise:

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> +
>  /*
>   * Note: test functions are marked noinline so that their names appear i=
n
>   * reports.
> @@ -603,7 +611,7 @@ static noinline void __init kasan_memchr(void)
>         if (!ptr)
>                 return;
>
> -       memchr(ptr, '1', size + 1);
> +       ptr_result =3D memchr(ptr, '1', size + 1);
>         kfree(ptr);
>  }
>
> @@ -618,8 +626,7 @@ static noinline void __init kasan_memcmp(void)
>         if (!ptr)
>                 return;
>
> -       memset(arr, 0, sizeof(arr));
> -       memcmp(ptr, arr, size+1);
> +       int_result =3D memcmp(ptr, arr, size + 1);
>         kfree(ptr);
>  }
>
> @@ -642,22 +649,22 @@ static noinline void __init kasan_strings(void)
>          * will likely point to zeroed byte.
>          */
>         ptr +=3D 16;
> -       strchr(ptr, '1');
> +       ptr_result =3D strchr(ptr, '1');
>
>         pr_info("use-after-free in strrchr\n");
> -       strrchr(ptr, '1');
> +       ptr_result =3D strrchr(ptr, '1');
>
>         pr_info("use-after-free in strcmp\n");
> -       strcmp(ptr, "2");
> +       int_result =3D strcmp(ptr, "2");
>
>         pr_info("use-after-free in strncmp\n");
> -       strncmp(ptr, "2", 1);
> +       int_result =3D strncmp(ptr, "2", 1);
>
>         pr_info("use-after-free in strlen\n");
> -       strlen(ptr);
> +       int_result =3D strlen(ptr);
>
>         pr_info("use-after-free in strnlen\n");
> -       strnlen(ptr, 1);
> +       int_result =3D strnlen(ptr, 1);
>  }
>
>  static noinline void __init kasan_bitops(void)
> @@ -724,11 +731,12 @@ static noinline void __init kasan_bitops(void)
>         __test_and_change_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
>
>         pr_info("out-of-bounds in test_bit\n");
> -       (void)test_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
> +       int_result =3D test_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
>
>  #if defined(clear_bit_unlock_is_negative_byte)
>         pr_info("out-of-bounds in clear_bit_unlock_is_negative_byte\n");
> -       clear_bit_unlock_is_negative_byte(BITS_PER_LONG + BITS_PER_BYTE, =
bits);
> +       int_result =3D clear_bit_unlock_is_negative_byte(BITS_PER_LONG +
> +               BITS_PER_BYTE, bits);
>  #endif
>         kfree(bits);
>  }
> --
> 2.20.1
>
