Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39186 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfHSPIy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 19 Aug 2019 11:08:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so9085275wra.6
        for <linux-s390@vger.kernel.org>; Mon, 19 Aug 2019 08:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190817142435.8532-1-hdegoede@redhat.com>
In-Reply-To: <20190817142435.8532-1-hdegoede@redhat.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 19 Aug 2019 18:08:34 +0300
Message-ID: <CAKv+Gu_bdcEQVnUcBpucgxk8zJ3EgsS=mBUpqfECOq_k1YYN9w@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] crypto: sha256 - Merge 2 separate C
 implementations into 1, put into separate library
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eric Biggers <ebiggers@kernel.org>, Andy Lutomirski <luto@kernel.org>, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, 17 Aug 2019 at 17:24, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> Here is v2 of my patch series refactoring the current 2 separate SHA256
> C implementations into 1 and put it into a separate library.
>
> There are 3 reasons for this:
>
> 1) Remove the code duplication of having 2 separate implementations
>
> 2) Offer a separate library SHA256 implementation which can be used
> without having to call crypto_alloc_shash first. This is especially
> useful for use during early boot when crypto_alloc_shash does not
> work yet.
>
> 3) Having the purgatory code using the same code as the crypto subsys means
> that the purgratory code will be tested by the crypto subsys selftests.
>
> This has been tested on x86, including checking that kecec still works.
>
> This has NOT been tested on s390, if someone with access to s390 can
> test that things still build with this series applied and that
> kexec still works, that would be great.
>
> Changes in v2:
> - Use put_unaligned_be32 to store the hash to allow callers to use an
>   unaligned buffer for storing the hash
> - Add a comment to include/crypto/sha256.h explaining that these functions
>   now may be used outside of the purgatory too (and that using the crypto
>   API instead is preferred)
> - Add sha224 support to the lib/crypto/sha256 library code
> - Make crypto/sha256_generic.c not only use sha256_transform from
>   lib/crypto/sha256.c but also switch it to using sha256_init, sha256_update
>   and sha256_final from there so that the crypto subsys selftests fully test
>   the lib/crypto/sha256.c implementation
>

This looks fine to me, although I agree with Eric's feedback regarding
further cleanups. Also, now that we have a C library, I'd like to drop
the dependency of the mips and x86 sha256 algo implementations up
sha256_generic.c, and use the library directly instead (so that
sha256-generic is no longer needed on x86 or mips)
