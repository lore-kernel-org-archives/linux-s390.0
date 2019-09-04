Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55462 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730254AbfIDNCY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Sep 2019 09:02:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id g207so3211262wmg.5
        for <linux-s390@vger.kernel.org>; Wed, 04 Sep 2019 06:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190901203532.2615-1-hdegoede@redhat.com>
In-Reply-To: <20190901203532.2615-1-hdegoede@redhat.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 4 Sep 2019 06:02:09 -0700
Message-ID: <CAKv+Gu8zQd982BH=WRzJC_acU5d+JR2vYzwm9cs4Zrp5Y3FzrQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] crypto: sha256 - Merge crypto/sha256.h into crypto/sha.h
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Gilad Ben-Yossef <gilad@benyossef.com>, Atul Gupta <atul.gupta@chelsio.com>, Marc Zyngier <marc.zyngier@arm.com>, Eric Biggers <ebiggers@kernel.org>, Andy Lutomirski <luto@kernel.org>, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Sun, 1 Sep 2019 at 13:35, Hans de Goede <hdegoede@redhat.com> wrote:
>
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
>

For the series,

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks Hans.
