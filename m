Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728349AbfHSTiY (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 19 Aug 2019 15:38:24 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 313523DBC2
        for <linux-s390@vger.kernel.org>; Mon, 19 Aug 2019 19:38:23 +0000 (UTC)
Received: by mail-ed1-f70.google.com with SMTP id l15so2683014edw.15
        for <linux-s390@vger.kernel.org>; Mon, 19 Aug 2019 12:38:23 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] crypto: sha256 - Merge 2 separate C
 implementations into 1, put into separate library
References: <20190817142435.8532-1-hdegoede@redhat.com>
 <CAKv+Gu_bdcEQVnUcBpucgxk8zJ3EgsS=mBUpqfECOq_k1YYN9w@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <26a86843-d610-80fe-6bdc-a8ce4fd43d6b@redhat.com>
Date: Mon, 19 Aug 2019 21:38:19 +0200
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_bdcEQVnUcBpucgxk8zJ3EgsS=mBUpqfECOq_k1YYN9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eric Biggers <ebiggers@kernel.org>, Andy Lutomirski <luto@kernel.org>, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi,

On 19-08-19 17:08, Ard Biesheuvel wrote:
> On Sat, 17 Aug 2019 at 17:24, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi All,
>>
>> Here is v2 of my patch series refactoring the current 2 separate SHA256
>> C implementations into 1 and put it into a separate library.
>>
>> There are 3 reasons for this:
>>
>> 1) Remove the code duplication of having 2 separate implementations
>>
>> 2) Offer a separate library SHA256 implementation which can be used
>> without having to call crypto_alloc_shash first. This is especially
>> useful for use during early boot when crypto_alloc_shash does not
>> work yet.
>>
>> 3) Having the purgatory code using the same code as the crypto subsys means
>> that the purgratory code will be tested by the crypto subsys selftests.
>>
>> This has been tested on x86, including checking that kecec still works.
>>
>> This has NOT been tested on s390, if someone with access to s390 can
>> test that things still build with this series applied and that
>> kexec still works, that would be great.
>>
>> Changes in v2:
>> - Use put_unaligned_be32 to store the hash to allow callers to use an
>>    unaligned buffer for storing the hash
>> - Add a comment to include/crypto/sha256.h explaining that these functions
>>    now may be used outside of the purgatory too (and that using the crypto
>>    API instead is preferred)
>> - Add sha224 support to the lib/crypto/sha256 library code
>> - Make crypto/sha256_generic.c not only use sha256_transform from
>>    lib/crypto/sha256.c but also switch it to using sha256_init, sha256_update
>>    and sha256_final from there so that the crypto subsys selftests fully test
>>    the lib/crypto/sha256.c implementation
>>
> 
> This looks fine to me, although I agree with Eric's feedback regarding
> further cleanups.

Ack, as I already told Eric I'm happy to do a follow up series with
the necessary local static function renames so that we can then merge
sha256.h into sha.h .

> Also, now that we have a C library, I'd like to drop
> the dependency of the mips and x86 sha256 algo implementations up
> sha256_generic.c, and use the library directly instead (so that
> sha256-generic is no longer needed on x86 or mips)

I assume this is more of a generic remark and not targeted towards me?

Regards,

Hans
