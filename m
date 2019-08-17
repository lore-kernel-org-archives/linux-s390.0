Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 16 Aug 2019 22:19:42 -0700
From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 3/6] crypto: sha256 - Move lib/sha256.c to lib/crypto
Message-ID: <20190817051942.GB8209@sol.localdomain>
References: <20190816211611.2568-1-hdegoede@redhat.com>
 <20190816211611.2568-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816211611.2568-4-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-crypto@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 11:16:08PM +0200, Hans de Goede wrote:
> diff --git a/include/linux/sha256.h b/include/crypto/sha256.h
> similarity index 100%
> rename from include/linux/sha256.h
> rename to include/crypto/sha256.h

<crypto/sha.h> already has the declarations for both SHA-1 and SHA-2, including
SHA-256.  So I'm not sure a separate sha256.h is appropriate.  How about putting
these declarations in <crypto/sha.h>?

- Eric
