Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 22 Aug 2019 15:57:32 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v2 0/7] crypto: sha256 - Merge 2 separate C
 implementations into 1, put into separate library
Message-ID: <20190822055732.GI3860@gondor.apana.org.au>
References: <20190817142435.8532-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817142435.8532-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eric Biggers <ebiggers@kernel.org>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-crypto@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Aug 17, 2019 at 04:24:28PM +0200, Hans de Goede wrote:
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

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
