Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39294 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgBZXsd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 26 Feb 2020 18:48:33 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so341152plp.6
        for <linux-s390@vger.kernel.org>; Wed, 26 Feb 2020 15:48:32 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v2 0/3] Fix some incompatibilites between KASAN and FORTIFY_SOURCE
In-Reply-To: <20200116062625.32692-1-dja@axtens.net>
References: <20200116062625.32692-1-dja@axtens.net>
Date: Thu, 27 Feb 2020 10:48:26 +1100
Message-ID: <87o8tkrjud.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, kasan-dev@googlegroups.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org, x86@kernel.org, dvyukov@google.com, christophe.leroy@c-s.fr

Daniel Axtens <dja@axtens.net> writes:

> 3 KASAN self-tests fail on a kernel with both KASAN and FORTIFY_SOURCE:
> memchr, memcmp and strlen. I have observed this on x86 and powerpc.
>
> When FORTIFY_SOURCE is on, a number of functions are replaced with
> fortified versions, which attempt to check the sizes of the
> operands. However, these functions often directly invoke __builtin_foo()
> once they have performed the fortify check.
>
> This breaks things in 2 ways:
>
>  - the three function calls are technically dead code, and can be
>    eliminated. When __builtin_ versions are used, the compiler can detect
>    this.
>
>  - Using __builtins may bypass KASAN checks if the compiler decides to
>    inline it's own implementation as sequence of instructions, rather than
>    emit a function call that goes out to a KASAN-instrumented
>    implementation.
>
> The patches address each reason in turn. Finally, test_memcmp used a
> stack array without explicit initialisation, which can sometimes break
> too, so fix that up.

Hi all,

It doesn't look like this has been picked up yet. Is there anything I
can do to help things along?

Regards,
Daniel

>
> v2: - some cleanups, don't mess with arch code as I missed some wrinkles.
>     - add stack array init (patch 3)
>
> Daniel Axtens (3):
>   kasan: stop tests being eliminated as dead code with FORTIFY_SOURCE
>   string.h: fix incompatibility between FORTIFY_SOURCE and KASAN
>   kasan: initialise array in kasan_memcmp test
>
>  include/linux/string.h | 60 +++++++++++++++++++++++++++++++++---------
>  lib/test_kasan.c       | 32 +++++++++++++---------
>  2 files changed, 68 insertions(+), 24 deletions(-)
>
> -- 
> 2.20.1
