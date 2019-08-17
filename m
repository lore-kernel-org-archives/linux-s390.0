Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfHQFNW (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 17 Aug 2019 01:13:22 -0400
Date: Fri, 16 Aug 2019 22:13:18 -0700
From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 6/6] crypto: sha256_generic - Use sha256_transform from
 generic sha256 lib
Message-ID: <20190817051318.GA8209@sol.localdomain>
References: <20190816211611.2568-1-hdegoede@redhat.com>
 <20190816211611.2568-7-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816211611.2568-7-hdegoede@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-crypto@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 11:16:11PM +0200, Hans de Goede wrote:
> Drop the duplicate sha256_transform function from crypto/sha256_generic.c
> and use the implementation from lib/crypto/sha256.c instead.
> "diff -u lib/crypto/sha256.c sha256_generic.c"
> shows that both implementations are identical.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Hi Hans, thanks for doing this!

I'm a little concerned that the only sha256 lib function which sha256_generic.c
calls is sha256_transform().  This means that sha256_init(), sha256_update(),
and sha256_final() are not tested by the crypto self-tests.  They could be
broken and we wouldn't know.

IMO, it would be better to make sha256_generic.c use sha256_init(),
sha256_update(), and sha256_final() rather than using sha256_base.h.
Then we'd get test coverage of both the sha256 lib, and of sha256_base.h
via the architecture-specific implementations.

To do this you'll also need to add sha224_init(), sha224_update(), and
sha224_final().  But that's straightforward.

- Eric
