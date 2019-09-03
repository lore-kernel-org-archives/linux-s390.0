Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44979 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfICH7W (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Sep 2019 03:59:22 -0400
Received: by mail-vs1-f67.google.com with SMTP id w195so8015547vsw.11
        for <linux-s390@vger.kernel.org>; Tue, 03 Sep 2019 00:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190901203532.2615-1-hdegoede@redhat.com> <20190901203532.2615-6-hdegoede@redhat.com>
 <CAOtvUMdd+V5pesw+O-kk9_JB5YpxUM+hU+Uu=kiMvOL9d0AziQ@mail.gmail.com> <0d55a6a7-9cca-38cb-97a2-558280fdc122@redhat.com>
In-Reply-To: <0d55a6a7-9cca-38cb-97a2-558280fdc122@redhat.com>
From: Gilad Ben-Yossef <gilad@benyossef.com>
Date: Tue, 3 Sep 2019 10:59:10 +0300
Message-ID: <CAOtvUMeK2+29PJBm6L1S0dqM8JXEZYUy1qKiP9H=xDEJjnO7mA@mail.gmail.com>
Subject: Re: [PATCH 5/9] crypto: ccree - Rename arrays to avoid conflict with crypto/sha256.h
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Atul Gupta <atul.gupta@chelsio.com>, Marc Zyngier <marc.zyngier@arm.com>, Eric Biggers <ebiggers@kernel.org>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, x86@kernel.org, linux-s390@vger.kernel.org, linux-efi@vger.kernel.org, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Tue, Sep 3, 2019 at 10:51 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 03-09-19 09:45, Gilad Ben-Yossef wrote:
> > On Sun, Sep 1, 2019 at 11:36 PM Hans de Goede <hdegoede@redhat.com> wro=
te:
> >>
> >> Rename the algo_init arrays to cc_algo_init so that they do not confli=
ct
> >> with the functions declared in crypto/sha256.h.
> >>
> >> This is a preparation patch for folding crypto/sha256.h into crypto/sh=
a.h.
> >
> > I'm fine with the renaming.
> >
> > Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
>
> Your Signed-off-by is only used when the patches passes through your hand=
s,
> since Herbert will likely apply this directly that is not the case.
>
> You want either Acked-by or Reviewed-by to signal that you are ok with th=
is patch.
>

Yes, you are right of course. Wrong macro... sorry about that.

Acked-by: Gilad Ben-Yossef <gilad@benyossef.com>


--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
