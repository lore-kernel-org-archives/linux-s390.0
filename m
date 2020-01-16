Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35555 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgAPIHp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Jan 2020 03:07:45 -0500
Received: by mail-qt1-f193.google.com with SMTP id e12so18203204qto.2
        for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2020 00:07:44 -0800 (PST)
MIME-Version: 1.0
References: <20200116062625.32692-1-dja@axtens.net> <20200116062625.32692-4-dja@axtens.net>
In-Reply-To: <20200116062625.32692-4-dja@axtens.net>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 16 Jan 2020 09:07:32 +0100
Message-ID: <CACT4Y+YpOm9cDk5Hi62iAwMFgiotzWjfiK4i9-9jkha_ZNwuvw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] kasan: initialise array in kasan_memcmp test
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Axtens <dja@axtens.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, kasan-dev <kasan-dev@googlegroups.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-xtensa@linux-xtensa.org, the arch/x86 maintainers <x86@kernel.org>, Christophe Leroy <christophe.leroy@c-s.fr>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>

On Thu, Jan 16, 2020 at 7:26 AM Daniel Axtens <dja@axtens.net> wrote:
>
> memcmp may bail out before accessing all the memory if the buffers
> contain differing bytes. kasan_memcmp calls memcmp with a stack array.
> Stack variables are not necessarily initialised (in the absence of a
> compiler plugin, at least). Sometimes this causes the memcpy to bail
> early thus fail to trigger kasan.
>
> Make sure the array initialised to zero in the code.
>
> No other test is dependent on the contents of an array on the stack.
>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  lib/test_kasan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index a130d75b9385..519b0f259e97 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -619,7 +619,7 @@ static noinline void __init kasan_memcmp(void)
>  {
>         char *ptr;
>         size_t size = 24;
> -       int arr[9];
> +       int arr[9] = {};
>
>         pr_info("out-of-bounds in memcmp\n");
>         ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
> --
> 2.20.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200116062625.32692-4-dja%40axtens.net.
