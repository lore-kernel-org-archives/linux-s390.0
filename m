Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43820 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgAPFe2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Jan 2020 00:34:28 -0500
Received: by mail-pf1-f196.google.com with SMTP id x6so9639725pfo.10
        for <linux-s390@vger.kernel.org>; Wed, 15 Jan 2020 21:34:26 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH 1/2] kasan: stop tests being eliminated as dead code with FORTIFY_SOURCE
In-Reply-To: <CACT4Y+Y-qPLzn2sur5QnS2h4=Qb2B_5rFxwMKuzhe-hwsReGqg@mail.gmail.com>
References: <20200115063710.15796-1-dja@axtens.net> <20200115063710.15796-2-dja@axtens.net> <CACT4Y+bAuaeHOcTHqp-=ckOb58fRajpGYk4khNzpS7_OyBDQYQ@mail.gmail.com> <917cc571-a25c-3d3e-547c-c537149834d6@c-s.fr> <CACT4Y+Y-qPLzn2sur5QnS2h4=Qb2B_5rFxwMKuzhe-hwsReGqg@mail.gmail.com>
Date: Thu, 16 Jan 2020 16:34:23 +1100
Message-ID: <87zheoj76o.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>, Christophe Leroy <christophe.leroy@c-s.fr>
Cc: linux-s390 <linux-s390@vger.kernel.org>, linux-xtensa@linux-xtensa.org, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, Linux-MM <linux-mm@kvack.org>, Daniel Micay <danielmicay@gmail.com>, Alexander Potapenko <glider@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

>> >> +/*
>> >> + * We assign some test results to these globals to make sure the tests
>> >> + * are not eliminated as dead code.
>> >> + */
>> >> +
>> >> +int int_result;
>> >> +void *ptr_result;
>> >
>> > These are globals, but are not static and don't have kasan_ prefix.
>> > But I guess this does not matter for modules?
>> > Otherwise:
>> >
>> > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
>> >
>>
>> I think if you make them static, GCC will see they aren't used and will
>> eliminate everything still ?
>
> static volatile? :)

Yeah so these are module globals. They'd be accessible from any other
files you linked into the module (currently there are no such
files). They're not visible outside the module because they're not
EXPORTed.

Making them static does lead to them getting eliminated, and 'static
volatile' seems both gross and like something checkpatch would complain
about. I'll leave them as they are but stick a kasan_ prefix on them
just for the additional tidiness.

Regards,
Daniel
