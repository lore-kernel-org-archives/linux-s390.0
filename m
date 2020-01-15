Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:59870 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgAOOrM (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 15 Jan 2020 09:47:12 -0500
Subject: Re: [PATCH 1/2] kasan: stop tests being eliminated as dead code with
 FORTIFY_SOURCE
References: <20200115063710.15796-1-dja@axtens.net>
 <20200115063710.15796-2-dja@axtens.net>
 <CACT4Y+bAuaeHOcTHqp-=ckOb58fRajpGYk4khNzpS7_OyBDQYQ@mail.gmail.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <917cc571-a25c-3d3e-547c-c537149834d6@c-s.fr>
Date: Wed, 15 Jan 2020 15:47:09 +0100
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bAuaeHOcTHqp-=ckOb58fRajpGYk4khNzpS7_OyBDQYQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>, Daniel Axtens <dja@axtens.net>
Cc: linux-s390 <linux-s390@vger.kernel.org>, linux-xtensa@linux-xtensa.org, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, Linux-MM <linux-mm@kvack.org>, Daniel Micay <danielmicay@gmail.com>, Alexander Potapenko <glider@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>



Le 15/01/2020 à 15:43, Dmitry Vyukov a écrit :
> On Wed, Jan 15, 2020 at 7:37 AM Daniel Axtens <dja@axtens.net> wrote:
>>
>> 3 KASAN self-tests fail on a kernel with both KASAN and FORTIFY_SOURCE:
>> memchr, memcmp and strlen.
>>
>> When FORTIFY_SOURCE is on, a number of functions are replaced with
>> fortified versions, which attempt to check the sizes of the operands.
>> However, these functions often directly invoke __builtin_foo() once they
>> have performed the fortify check. The compiler can detect that the results
>> of these functions are not used, and knows that they have no other side
>> effects, and so can eliminate them as dead code.
>>
>> Why are only memchr, memcmp and strlen affected?
>> ================================================
>>
>> Of string and string-like functions, kasan_test tests:
>>
>>   * strchr  ->  not affected, no fortified version
>>   * strrchr ->  likewise
>>   * strcmp  ->  likewise
>>   * strncmp ->  likewise
>>
>>   * strnlen ->  not affected, the fortify source implementation calls the
>>                 underlying strnlen implementation which is instrumented, not
>>                 a builtin
>>
>>   * strlen  ->  affected, the fortify souce implementation calls a __builtin
>>                 version which the compiler can determine is dead.
>>
>>   * memchr  ->  likewise
>>   * memcmp  ->  likewise
>>
>>   * memset ->   not affected, the compiler knows that memset writes to its
>>                 first argument and therefore is not dead.
>>
>> Why does this not affect the functions normally?
>> ================================================
>>
>> In string.h, these functions are not marked as __pure, so the compiler
>> cannot know that they do not have side effects. If relevant functions are
>> marked as __pure in string.h, we see the following warnings and the
>> functions are elided:
>>
>> lib/test_kasan.c: In function ‘kasan_memchr’:
>> lib/test_kasan.c:606:2: warning: statement with no effect [-Wunused-value]
>>    memchr(ptr, '1', size + 1);
>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> lib/test_kasan.c: In function ‘kasan_memcmp’:
>> lib/test_kasan.c:622:2: warning: statement with no effect [-Wunused-value]
>>    memcmp(ptr, arr, size+1);
>>    ^~~~~~~~~~~~~~~~~~~~~~~~
>> lib/test_kasan.c: In function ‘kasan_strings’:
>> lib/test_kasan.c:645:2: warning: statement with no effect [-Wunused-value]
>>    strchr(ptr, '1');
>>    ^~~~~~~~~~~~~~~~
>> ...
>>
>> This annotation would make sense to add and could be added at any point, so
>> the behaviour of test_kasan.c should change.
>>
>> The fix
>> =======
>>
>> Make all the functions that are pure write their results to a global,
>> which makes them live. The strlen and memchr tests now pass.
>>
>> The memcmp test still fails to trigger, which is addressed in the next
>> patch.
>>
>> Cc: Daniel Micay <danielmicay@gmail.com>
>> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> Cc: Alexander Potapenko <glider@google.com>
>> Cc: Dmitry Vyukov <dvyukov@google.com>
>> Fixes: 0c96350a2d2f ("lib/test_kasan.c: add tests for several string/memory API functions")
>> Signed-off-by: Daniel Axtens <dja@axtens.net>
>> ---
>>   lib/test_kasan.c | 30 +++++++++++++++++++-----------
>>   1 file changed, 19 insertions(+), 11 deletions(-)
>>
>> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
>> index 328d33beae36..58a8cef0d7a2 100644
>> --- a/lib/test_kasan.c
>> +++ b/lib/test_kasan.c
>> @@ -23,6 +23,14 @@
>>
>>   #include <asm/page.h>
>>
>> +/*
>> + * We assign some test results to these globals to make sure the tests
>> + * are not eliminated as dead code.
>> + */
>> +
>> +int int_result;
>> +void *ptr_result;
> 
> These are globals, but are not static and don't have kasan_ prefix.
> But I guess this does not matter for modules?
> Otherwise:
> 
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> 

I think if you make them static, GCC will see they aren't used and will 
eliminate everything still ?

Christophe
