Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45243 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbfJ2IWa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 29 Oct 2019 04:22:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id q13so12539619wrs.12
        for <linux-s390@vger.kernel.org>; Tue, 29 Oct 2019 01:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191028210559.8289-1-rth@twiddle.net>
In-Reply-To: <20191028210559.8289-1-rth@twiddle.net>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 29 Oct 2019 09:22:16 +0100
Message-ID: <CAKv+Gu-mnyKK_0s7fF_8C0aq1ur+RoHscVwTfd31quEVqZhefw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Improvements for random.h/archrandom.h
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Mon, 28 Oct 2019 at 22:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> During patch review for an addition of archrandom.h for arm64,
> it was suggeted that the arch_random_get_* functions should be
> marked __must_check.  Which does sound like a good idea, since
> the by-reference integer output may be uninitialized when the
> boolean result is false.
>
> In addition, I noticed a few other minor inconsistencies between
> the different architectures: x86 defines some functional macros
> outside CONFIG_ARCH_RANDOM, and powerpc isn't using bool.
>
>
> r~
>
>
> Richard Henderson (6):
>   random: Mark CONFIG_ARCH_RANDOM functions __must_check
>   x86: Move arch_has_random* inside CONFIG_ARCH_RANDOM
>   x86: Mark archrandom.h functions __must_check
>   powerpc: Use bool in archrandom.h
>   powerpc: Mark archrandom.h functions __must_check
>   s390x: Mark archrandom.h functions __must_check
>

Modulo the nit in reply to 1/6:

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>


>  arch/powerpc/include/asm/archrandom.h | 24 +++++++++++++-----------
>  arch/s390/include/asm/archrandom.h    |  8 ++++----
>  arch/x86/include/asm/archrandom.h     | 24 ++++++++++++------------
>  include/linux/random.h                |  8 ++++----
>  4 files changed, 33 insertions(+), 31 deletions(-)
>
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
