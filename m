Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 5 Sep 2019 14:55:24 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 0/9] crypto: sha256 - Merge crypto/sha256.h into
 crypto/sha.h
Message-ID: <20190905045524.GC32038@gondor.apana.org.au>
References: <20190901203532.2615-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901203532.2615-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Gilad Ben-Yossef <gilad@benyossef.com>, Atul Gupta <atul.gupta@chelsio.com>, Marc Zyngier <marc.zyngier@arm.com>, Eric Biggers <ebiggers@kernel.org>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-crypto@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, Sep 01, 2019 at 10:35:23PM +0200, Hans de Goede wrote:
> Hi All,
> 
> As promised here is a follow-up series to my earlier sha256 series.
> 
> Note I have only compiled and tested this series on x86_64 !! 
> 
> All changes to architecture specific code on other archs have not even
> been tested to compile! With that said most of these changes were done
> using my editors search - replace function so things should be fine...
> (and FWIW I did do a Kconfig hack to compile test the ccree change).
> 
> The first patch in this series rename various file local functions /
> arrays to avoid conflicts with the new include/crypto/sha256.h, followed
> by a patch merging include/crypto/sha256.h into include/crypto/sha.h.
> 
> The last patch makes use of this merging to remove a bit more code
> duplication, making sha256_generic use sha256_init and sha224_init from
> lib/crypto/sha256.c. An added advantage of this, is that this gives these
> 2 functions coverage by the crypto selftests.

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
