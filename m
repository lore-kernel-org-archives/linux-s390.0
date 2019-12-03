Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33579 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfLCXjt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Dec 2019 18:39:49 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay6so2332950plb.0
        for <linux-s390@vger.kernel.org>; Tue, 03 Dec 2019 15:39:48 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v2 1/2] kasan: support instrumented bitops combined with generic bitops
In-Reply-To: <87r21lef1k.fsf@mpe.ellerman.id.au>
References: <20190820024941.12640-1-dja@axtens.net> <877e6vutiu.fsf@dja-thinkpad.axtens.net> <878sp57z44.fsf@dja-thinkpad.axtens.net> <CANpmjNOCxTxTpbB_LwUQS5jzfQ_2zbZVAc4nKf0FRXmrwO-7sA@mail.gmail.com> <87a78xgu8o.fsf@dja-thinkpad.axtens.net> <87y2wbf0xx.fsf@dja-thinkpad.axtens.net> <CANpmjNN-=F6GK_jHPUx8OdpboK7nMV=i=sKKfSsKwKEHnMTG0g@mail.gmail.com> <87r21lef1k.fsf@mpe.ellerman.id.au>
Date: Wed, 04 Dec 2019 10:39:44 +1100
Message-ID: <87pnh5dlmn.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Marco Elver <elver@google.com>
Cc: linux-s390@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-arch <linux-arch@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org

Hi Michael,
> I only just noticed this thread as I was about to send a pull request
> for these two commits.
>
> I think I agree that test_bit() shouldn't move (yet), but I dislike that
> the documentation ends up being confusing due to this patch.
>
> So I'm inclined to append or squash in the patch below, which removes
> the new headers from the documentation. The end result is the docs look
> more or less the same, just the ordering of some of the functions
> changes. But we don't end up with test_bit() under the "Non-atomic"
> header, and then also documented in Documentation/atomic_bitops.txt.
>
> Thoughts?

That sounds good to me.

Regards,
Daniel

>
> cheers
>
>
> diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
> index 2caaeb55e8dd..4ac53a1363f6 100644
> --- a/Documentation/core-api/kernel-api.rst
> +++ b/Documentation/core-api/kernel-api.rst
> @@ -57,21 +57,12 @@ The Linux kernel provides more basic utility functions.
>  Bit Operations
>  --------------
>  
> -Atomic Operations
> -~~~~~~~~~~~~~~~~~
> -
>  .. kernel-doc:: include/asm-generic/bitops/instrumented-atomic.h
>     :internal:
>  
> -Non-atomic Operations
> -~~~~~~~~~~~~~~~~~~~~~
> -
>  .. kernel-doc:: include/asm-generic/bitops/instrumented-non-atomic.h
>     :internal:
>  
> -Locking Operations
> -~~~~~~~~~~~~~~~~~~
> -
>  .. kernel-doc:: include/asm-generic/bitops/instrumented-lock.h
>     :internal:
>  
