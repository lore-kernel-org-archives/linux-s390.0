Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42109 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfKONLJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 15 Nov 2019 08:11:09 -0500
Received: by mail-pf1-f194.google.com with SMTP id s5so6647224pfh.9
        for <linux-s390@vger.kernel.org>; Fri, 15 Nov 2019 05:11:09 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v2 1/2] kasan: support instrumented bitops combined with generic bitops
In-Reply-To: <CANpmjNOCxTxTpbB_LwUQS5jzfQ_2zbZVAc4nKf0FRXmrwO-7sA@mail.gmail.com>
References: <20190820024941.12640-1-dja@axtens.net> <877e6vutiu.fsf@dja-thinkpad.axtens.net> <878sp57z44.fsf@dja-thinkpad.axtens.net> <CANpmjNOCxTxTpbB_LwUQS5jzfQ_2zbZVAc4nKf0FRXmrwO-7sA@mail.gmail.com>
Date: Sat, 16 Nov 2019 00:11:03 +1100
Message-ID: <87a78xgu8o.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: christophe.leroy@c-s.fr, linux-s390@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linuxppc-dev@lists.ozlabs.org, kasan-dev <kasan-dev@googlegroups.com>

> test_bit() is an atomic bitop. I assume it was meant to be in
> instrumented-atomic.h?

Hmm, interesting.

I was tricked by the generic version doing just a simple read, with only
a volatile attribute to ensure the read occurs more-or-less as written:

/**
 * test_bit - Determine whether a bit is set
 * @nr: bit number to test
 * @addr: Address to start counting from
 */
static inline int test_bit(int nr, const volatile unsigned long *addr)
{
        return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
}

But the docs do seem to indicate that it's atomic (for whatever that
means for a single read operation?), so you are right, it should live in
instrumented-atomic.h.

Sadly, only x86 and s390 specify an arch_test_bit, which will make moving it
into instumented-atomic.h break powerpc :(

I'll have a crack at something next week, probably with a similar trick
to arch_clear_bit_unlock_is_negative_byte.

Regards,
Daniel


>
> Thanks,
> -- Marco
>
>> >> +
>> >> +#endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
>> >> --
>> >> 2.20.1
>>
>> --
>> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/878sp57z44.fsf%40dja-thinkpad.axtens.net.
